//
//  ThirdRouter.swift
//  table
//
//  Created by Алексей Волобуев on 04.03.2023.
//

import Foundation
import UIKit

protocol ThirdRouterDelegate {
    func showEpisodes(name: String, links: [String])
    func showLocation(link: String)
}

final class ThirdRouter {
    private var view: UIViewController?
    init(view: UIViewController) {
        self.view = view
    }
}

extension ThirdRouter: ThirdRouterDelegate {
    func showLocation(link: String) {
        let fifthModule = FifthModuleBuilder.CreateFifthModule(link: link)
        view?.navigationController?.pushViewController(fifthModule, animated: true)
    }
    
    func showEpisodes(name: String, links: [String]) {
        let fourthModule = FourthModuleBuilder.CreateFourthModule(charName: name, epLinks: links)
        view?.navigationController?.pushViewController(fourthModule, animated: true)
    }
}
