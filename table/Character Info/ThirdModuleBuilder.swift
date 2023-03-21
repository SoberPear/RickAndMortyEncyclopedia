//
//  ThirdModuleBuilder.swift
//  table
//
//  Created by Алексей Волобуев on 27.02.2023.
//

import Foundation

class ThirdModuleBuilder {
    static func createThirdModule(char: Character) -> ThirdViewController {
        let viewController = ThirdViewController()
        let router = ThirdRouter(view: viewController)
        let presenter = ThirdPresenter(router: router, viewInput: viewController, charLink: char.url)
        
        viewController.name = char.name
        viewController.viewOtputDelegate = presenter
        
        return viewController
    }
}
