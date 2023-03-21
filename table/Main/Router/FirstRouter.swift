//
//  FirstRouter.swift
//  table
//
//  Created by Алексей Волобуев on 09.02.2023.
//

import Foundation

import UIKit

protocol FirstRouterDelegate {
    func showEpisode(viewModel: EpisodeViewModel)
}

final class FirstRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

extension FirstRouter: FirstRouterDelegate {
    
    func showEpisode(viewModel: EpisodeViewModel) {
        let secondModule = SecondModuleBuilder.createSecondModule(viewModel: viewModel)
        view?.navigationController?.pushViewController(secondModule, animated: true)
    }
    
}
