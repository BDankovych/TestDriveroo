//
//  Coordinator.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

protocol ViewCoordinator {
    associatedtype ViewType: UIViewController
    
    var presenter: UIViewController { get set }
    
    init(presenter: UIViewController)
    
    func start(embedInNav: Bool)
    func generateView() -> ViewType
}

extension ViewCoordinator {
    func start(embedInNav: Bool = false) {
        var vc: UIViewController = generateView()
        
        if embedInNav {
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            vc = navVC
        }
        
        if let navigationVC = presenter.navigationController {
            navigationVC.pushViewController(vc, animated: true)
        } else {
            presenter.present(vc, animated: true)
        }
    }
}

