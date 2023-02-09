//
//  ItemsListCoordinator.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

class ItemsListCoordinator: ViewCoordinator {
    typealias ViewType = ItemsListScreen
    var jsonFileName = "task"

    var presenter: UIViewController
    
    required init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    convenience init(presenter: UIViewController, jsonFileName: String) {
        self.init(presenter: presenter)
        self.jsonFileName = jsonFileName
    }
    
    func generateView() -> ItemsListScreen {
        let viewModel = ItemsListViewModel()
        return MainStoryboard.itemListScreen(viewModel: viewModel)
    }
}
