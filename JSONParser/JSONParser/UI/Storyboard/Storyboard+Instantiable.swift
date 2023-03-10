//
//  Storyboard+Instantiable.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

enum Storyboard {
    case main
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }
    
    func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}

protocol StoryboardInstantiable {
    static var storyboard: Storyboard { get }
}

extension UIViewController {
    static var controllerIdentifier: String {
        return String(describing: self)
    }
}

extension StoryboardInstantiable {
    static func instantiateInitialVC() -> UIViewController {
        if let vc = storyboard.getStoryboard().instantiateInitialViewController() {
            return vc
        } else {
            fatalError("Storyboard \(storyboard.name) doesn't contain initial View Controller")
        }
    }
    
    static func instantiateInitialVC<T: UIViewController>() -> T {
        if let vc = instantiateInitialVC() as? T {
            return vc
        } else {
            fatalError("Initital ViewController from \(storyboard.name) storyboard doesn't fit type \(T.self)")
        }
    }
    
    static func instantiateVC<T: UIViewController>(type: T.Type, with identifier: String? = nil) -> T {
        let identifier = identifier ?? T.controllerIdentifier
        if let vc = storyboard.getStoryboard().instantiateViewController(withIdentifier: identifier) as? T {
            return vc
        } else {
            fatalError("Storyboard \(storyboard.name) doesn't contain \(T.self) with identifier \(identifier)")
        }
    }
}
