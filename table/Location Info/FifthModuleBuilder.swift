//
//  FifthModuleBuilder.swift
//  table
//
//  Created by Алексей Волобуев on 04.03.2023.
//

import Foundation

class FifthModuleBuilder {
    static func CreateFifthModule(link: String) -> FifthViewController {
        let viewController = FifthViewController()
        let presenter = FifthPresenter(viewController: viewController, link: link)
        
        viewController.outputDelegate = presenter
        return viewController
    }
}
