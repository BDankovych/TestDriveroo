//
//  Item.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

class ItemDetails {
    var item: Item
    var images: [UIImage]
    
    init(item: Item = .init(), images: [UIImage] = []) {
        self.item = item
        self.images = images
    }
}

struct Item {
    
    var title: String!
    var firstImgUrl: String!
    var secondImgUrl: String!
    var thirdImgUrl: String!
    var details: String!
    
    enum CodingKeys: String, CaseIterable {
        case title
        case firstImg = "firstimg"
        case secondImg = "secondimg"
        case thirdImg = "thirdimg"
        case details
        
        func keyPath<T>(type: T.Type) -> WritableKeyPath<Item, T>? {
            switch self {
            case .title:
                return \Item.title as? WritableKeyPath<Item, T>
            case .firstImg:
                return \Item.firstImgUrl as? WritableKeyPath<Item, T>
            case .secondImg:
                return \Item.secondImgUrl as? WritableKeyPath<Item, T>
            case .thirdImg:
                return \Item.thirdImgUrl as? WritableKeyPath<Item, T>
            case .details:
                return \Item.details as? WritableKeyPath<Item, T>
            }
        }
        
        func keyPathOptional<T>(type: T.Type) -> WritableKeyPath<Item, T?>? {
            switch self {
            case .title:
                return \Item.title as? WritableKeyPath<Item, T?>
            case .firstImg:
                return \Item.firstImgUrl as? WritableKeyPath<Item, T?>
            case .secondImg:
                return \Item.secondImgUrl as? WritableKeyPath<Item, T?>
            case .thirdImg:
                return \Item.thirdImgUrl as? WritableKeyPath<Item, T?>
            case .details:
                return \Item.details as? WritableKeyPath<Item, T?>
            }
        }
         
        var keyPattern: String {
            rawValue + "\\s*:"
        }
    }
    
    mutating func set<T>(value: T, key: CodingKeys) {
        if let kp = key.keyPath(type: T.self) {
            self[keyPath: kp] = value
        } else if let kp = key.keyPathOptional(type: T.self) {
            self[keyPath: kp] = value
        } else {
            print("wrong type")
        }
    }
}
