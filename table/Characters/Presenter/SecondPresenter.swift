//
//  SecondPresenter.swift
//  table
//
//  Created by Алексей Волобуев on 07.02.2023.
//

import Foundation
import UIKit

protocol SecondViewOutputDelegate: AnyObject {
    func getChars(completionHandler: (()->())?)
    func didSelectСell(id: Int)
}

class SecondPresenter {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    private var characterLinks: [String]
    
    var charSource = [Character]()
    var charImage = UIImage()
    
    private var router: SecondRouterDelegate
    weak private var viewInputDelegate: SecondViewInputDelegate?
    
    init(router: SecondRouter, viewInput: SecondViewInputDelegate?, charLinks: [String]) {
        self.router = router
        self.viewInputDelegate = viewInput
        self.characterLinks = charLinks
    }
    
    private func getCharacters(complitionHandler: (([CharacterViewModel])->Void)? ) {
        var charViewModelSource = [CharacterViewModel]()
        let dispatchGroup = DispatchGroup()
        for charLink in characterLinks {
            dispatchGroup.enter()
            guard let url = URL(string: charLink) else { return }
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if error == nil, let parsData = data {
                    guard let char = try? strongSelf.decoder.decode(Character.self, from: parsData) else { dispatchGroup.leave(); return }
                    strongSelf.charSource.append(char)
                    guard let url = URL(string: char.image) else { return }
                    var image = UIImage()
                    if let data = try? Data(contentsOf: url) {
                        image = UIImage(data: data) ?? UIImage()
                    }
                    charViewModelSource.append(CharacterViewModel(name: char.name, image: image))
                }
                dispatchGroup.leave()
            }.resume()
            
        }
        dispatchGroup.notify(queue: .main) {
            complitionHandler?(charViewModelSource)
        }
    }
}

extension SecondPresenter: SecondViewOutputDelegate {
    func didSelectСell(id: Int) {
        router.showCharacter(char: charSource[id])
    }
    
    func getChars(completionHandler: (()->())?) {
        getCharacters { [weak self] viewModels in
            self?.viewInputDelegate?.setupViewModel(viewModels)
        }
    }
}
