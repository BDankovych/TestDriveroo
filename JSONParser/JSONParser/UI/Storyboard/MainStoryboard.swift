//
//  MainStoryboard.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

import Foundation

struct MainStoryboard: StoryboardInstantiable {
    
    static var storyboard: Storyboard {
        .main
    }
    
    static func itemListScreen(viewModel: ItemsListVMProtocol) -> ItemsListScreen {
        let vc: ItemsListScreen = instantiateVC(type: ItemsListScreen.self)
        vc.configure(viewModel: viewModel)
        return vc
    }
    
    static func itemDetailsScreen(viewModel: ItemDetailsScreenViewModelProtocol) -> ItemDetailsScreen {
        let vc: ItemDetailsScreen = instantiateVC(type: ItemDetailsScreen.self)
        vc.configure(viewModel: viewModel)
        return vc
    }
}
