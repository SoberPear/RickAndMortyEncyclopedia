//
//  ThirdPresenter.swift
//  table
//
//  Created by Алексей Волобуев on 27.02.2023.
//

import Foundation
import UIKit

protocol ThirdViewOutputDelegate: AnyObject {
    func getCharInfo(complitionHandler: (()->())?)
    func didSelectEpCell()
    func didSelectLocCell(type: Int)
}

class ThirdPresenter {
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    private var router: ThirdRouterDelegate
    private var charLink: String
    weak private var thirdInputDelegate: ThirdViewInputDelegate?
    init(router: ThirdRouter, viewInput: ThirdViewInputDelegate, charLink: String) {
        self.router = router
        self.thirdInputDelegate = viewInput
        self.charLink = charLink
    }
    private func parsCharInfo(completionHandler: ((CharacterInfoViewModel)->Void)?) {
        var charInfo: CharacterInfoViewModel?
        guard let url = URL(string: charLink) else {return}
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else {return}
            if error == nil, let parsData = data {
                guard let char = try? strongSelf.decoder.decode(Character.self, from: parsData) else {return}
                guard let url = URL(string: char.image) else {return}
                var image = UIImage()
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data) ?? UIImage()
                }
                charInfo = CharacterInfoViewModel(name: char.name, status: char.status, species: char.species, gender: char.gender, origin: char.origin, location: char.location, image: image, episode: char.episode)
            }
            completionHandler?(charInfo!)
        }.resume()
        
    }
}

extension ThirdPresenter: ThirdViewOutputDelegate {
    func didSelectLocCell(type: Int) {
        parsCharInfo { [weak self] characterInfo in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                if type == 0 {
                    strongSelf.router.showLocation(link: characterInfo.origin.url)
                } else {
                    strongSelf.router.showLocation(link: characterInfo.location.url)
                }
            }
        }
    }
    
    func didSelectEpCell() {
        parsCharInfo { [weak self] characterInfo in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.router.showEpisodes(name: characterInfo.name, links: characterInfo.episode)
            }
        }
    }
    
    func getCharInfo(complitionHandler: (() -> ())?) {
        parsCharInfo { [weak self] characterInfo in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.thirdInputDelegate?.setupSharInfo(charInfo: characterInfo)
            }
        }
    }
}

