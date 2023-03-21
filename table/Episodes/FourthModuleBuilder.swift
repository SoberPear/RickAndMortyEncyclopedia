//
//  FourthModuleBuilder.swift
//  table
//
//  Created by Алексей Волобуев on 04.03.2023.
//

import Foundation

class FourthModuleBuilder {
    static func CreateFourthModule (charName: String, epLinks: [String]) -> FourthViewController {
        let viewController = FourthViewController()
        let presenter = FourthPresenter(viewInput: viewController, epLinks: epLinks)
        
        viewController.name = charName
        viewController.outputDelegate = presenter
        
        return viewController
    }
}
