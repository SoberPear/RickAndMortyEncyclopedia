//
//  SrcondRouter.swift
//  table
//
//  Created by Алексей Волобуев on 27.02.2023.
//

import Foundation
import UIKit

protocol SecondRouterDelegate {
    func showCharacter(char: Character)
    
}

final class SecondRouter {
    private var view: UIViewController?
    init(view: UIViewController) {
        self.view = view
    }
}

extension SecondRouter: SecondRouterDelegate {
    func showCharacter(char: Character) {
        let thirdModule = ThirdModuleBuilder.createThirdModule(char: char)
        view?.navigationController?.pushViewController(thirdModule, animated: true)
    }
}
