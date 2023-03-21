//
//  econdModuleBuilder.swift
//  table
//
//  Created by Алексей Волобуев on 07.02.2023.
//

import Foundation

class SecondModuleBuilder {
    
    static func createSecondModule(viewModel: EpisodeViewModel) -> SecondViewController {
        let viewController = SecondViewController()
        let router = SecondRouter(view: viewController)
        let presenter = SecondPresenter(router: router, viewInput: viewController, charLinks: viewModel.episodeCharacterLinks)
        
        viewController.viewTitle = viewModel.episodeName
        viewController.viewOtputDelegate = presenter
        
        return viewController
    }
}
