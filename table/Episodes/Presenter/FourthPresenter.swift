//
//  FourthPresenter.swift
//  table
//
//  Created by Алексей Волобуев on 04.03.2023.
//

import Foundation

protocol FourthViewOutputDelegate: AnyObject {
    func getEpisodes(completionHandler: (()->())?)
}

class FourthPresenter {
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    weak private var inputDelegate: FourthViewInputDelegate?
    private var epLinks: [String]
    init(viewInput: FourthViewInputDelegate, epLinks: [String]) {
        self.epLinks = epLinks
        self.inputDelegate = viewInput
    }
    private func parsEpisodes(links: [String], completionHandler: (([Episode]) -> Void)?) {
        var episodes = [Episode]()
        let dispatchGroup = DispatchGroup()
        for epLink in links {
            dispatchGroup.enter()
            guard let url = URL(string: epLink) else { return }
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if error == nil, let parsData = data {
                    guard let ep = try? strongSelf.decoder.decode(Episode.self, from: parsData) else { return }
                    episodes.append(ep)
                }
                dispatchGroup.leave()
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler?(episodes)
        }
    }
}

extension FourthPresenter: FourthViewOutputDelegate {
    func getEpisodes(completionHandler: (()->())?) {
        parsEpisodes(links: epLinks) { [weak self] eps in
            guard let strongSelf = self else { return }
            strongSelf.inputDelegate?.setupEpisodes(episodes: eps)
        }
    }
}
