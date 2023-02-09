//
//  ItemDetailsCoordinator.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 09.02.2023.
//

import UIKit

class ItemDetailsCoordinator: ViewCoordinator {
    typealias ViewType = ItemDetailsScreen
    var itemDetails: ItemDetails!

    var presenter: UIViewController
    
    required init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    convenience init(presenter: UIViewController, itemDetails: ItemDetails) {
        self.init(presenter: presenter)
        self.itemDetails = itemDetails
    }
    
    func generateView() -> ItemDetailsScreen {
        let viewModel = ItemDetailsScreenViewModel(item: itemDetails)
        return MainStoryboard.itemDetailsScreen(viewModel: viewModel)
    }
}

