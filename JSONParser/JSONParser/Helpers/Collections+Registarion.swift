//
//  Collections+Registarion.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, nibName: String? = nil) {
        let identifier = "\(cellType)"
        let cellnibName = nibName ?? "\(cellType)"
        let nib = UINib(nibName: cellnibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func cell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(cellType)", for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, nibName: String? = nil) {
        let identifier = "\(cellType)"
        let cellnibName = nibName ?? "\(cellType)"
        let nib = UINib(nibName: cellnibName, bundle: nil)
        self.register(cellType, forCellWithReuseIdentifier: identifier)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func cell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "\(cellType)", for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
}
