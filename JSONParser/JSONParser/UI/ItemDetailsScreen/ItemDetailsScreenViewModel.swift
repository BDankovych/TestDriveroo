//
//  ItemDetailsScreenViewModel.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 09.02.2023.
//

import UIKit

protocol ItemDetailsScreenViewModelProtocol: class {
    var title: String { get }
    var subtitle: String { get }
    var images: [UIImage] { get }
}

class ItemDetailsScreenViewModel: ItemDetailsScreenViewModelProtocol {
    var item: ItemDetails
    
    init(item: ItemDetails) {
        self.item = item
    }
    
    var title: String {
        item.item.title
    }
    
    var subtitle: String {
        item.item.details
    }
    
    var images: [UIImage] {
        item.images
    }
}
