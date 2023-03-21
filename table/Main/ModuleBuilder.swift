//
//  ModuleBuilder.swift
//  table
//
//  Created by Алексей Волобуев on 27.01.2023.
//

import Foundation

class FirstModuleBuilder {
    static func createFirstModule() -> ViewController {
        
        let viewController = ViewController()
        
        let router = FirstRouter(view: viewController)
        
        let presenter = FirstPresenter(router: router, viewInput: viewController)
        
        viewController.viewOtputDelegate = presenter
        
        return viewController
    }
}
