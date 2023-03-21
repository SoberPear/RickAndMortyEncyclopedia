//
//  FifthPresenter.swift
//  table
//
//  Created by Алексей Волобуев on 04.03.2023.
//

import Foundation
import UIKit

protocol FifthViewOutputDelegate: AnyObject {
    func getLocationInfo(completionHandler: (()->())?)
}

class FifthPresenter {
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    private var charLinks = [String]()
    weak private var inputDelegate: FifthViewInputDelegate?
    private var link: String
    init(viewController: FifthViewInputDelegate, link: String){
        self.inputDelegate = viewController
        self.link = link
    }
    
    private func parsCharacters(links: [String], completionHandler: (([CharacterViewModel])->())?) {
        var charViewModelSource = [CharacterViewModel]()
        let dispatchGroup = DispatchGroup()
        for charLink in links {
            dispatchGroup.enter()
            guard let url = URL(string: charLink) else { return }
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if error == nil, let parsData = data {
                    guard let char = try? strongSelf.decoder.decode(Character.self, from: parsData) else { dispatchGroup.leave(); return }
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
            completionHandler?(charViewModelSource)
        }
    }
    
    private func parsLocation(link: String, completionHandler: ((Location)->())?) {
        var location: Location?
        guard let url = URL(string: link) else { return }
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if error == nil, let parsData = data {
                guard let loc = try? strongSelf.decoder.decode(Location.self, from: parsData) else { return }
                location = loc
                strongSelf.charLinks = loc.residents
            }
            completionHandler?(location!)
        }.resume()
    }
}

extension FifthPresenter: FifthViewOutputDelegate {
    func getLocationInfo(completionHandler: (()->())?) {
        parsLocation(link: link) { [weak self] loc in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.inputDelegate?.setupLocation(location: loc)
                strongSelf.inputDelegate?.configureLabels()
            }
            strongSelf.parsCharacters(links: strongSelf.charLinks) { charModels in
                DispatchQueue.main.async {
                    strongSelf.inputDelegate?.setupResidents(chars: charModels)
                }
            }
        }
        
    }
}
