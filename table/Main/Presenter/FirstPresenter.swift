//
//  presenter.swift
//  table
//
//  Created by Алексей Волобуев on 23.11.2022.
//

import Foundation

protocol ViewOutputDelegate: AnyObject {
    func getData()
    func didSelectCell(id: Int)
}


class FirstPresenter {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    var dataSource = [Episode]()
    
    private var router: FirstRouterDelegate
    weak private var viewInputDelegate: ViewInputDelegate?
    
    init(router: FirstRouter, viewInput: ViewInputDelegate?) {
        self.router = router
        self.viewInputDelegate = viewInput
    }
    
    private func getEpisodes(links: [String], completionHandler: (()->())? ) {
        let dispatchGroup = DispatchGroup()
        for link in links {
            dispatchGroup.enter()
            guard let url = URL(string: link) else { return }
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                if error == nil, let parsData = data {
                    let response = try? strongSelf.decoder.decode(Response.self, from: parsData)
                    strongSelf.dataSource += response?.episodes ?? []
                } else { return }
                dispatchGroup.leave()
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler?()
        }
    }
    
}

extension FirstPresenter: ViewOutputDelegate {
    
    func didSelectCell(id: Int) {
        let secondVIewModel = EpisodeViewModel(episodeName: dataSource[id].name, episodeCharacterLinks: dataSource[id].characters)
        router.showEpisode(viewModel: secondVIewModel)
    }
    
    
    func getData() {
        self.getEpisodes(links: ["https://rickandmortyapi.com/api/episode", "https://rickandmortyapi.com/api/episode?page=2", "https://rickandmortyapi.com/api/episode?page=3"]) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewInputDelegate?.setupData(data: self.dataSource)
            }
        }
//        self.getEpisodes(link: "https://rickandmortyapi.com/api/episode?page=2")
//        self.getEpisodes(link: "https://rickandmortyapi.com/api/episode?page=3")
//        self.viewInputDelegate?.setupData(data: self.dataSource)
    }
    
}
