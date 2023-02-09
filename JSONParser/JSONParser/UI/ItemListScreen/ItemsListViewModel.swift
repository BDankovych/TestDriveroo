//
//  ItemsListViewModel.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 09.02.2023.
//

import UIKit

protocol ItemsListVMProtocol {
    func loadItems()
    func showItemDetails(index: Int)
    func openDetails(item: ItemDetails, vc: UIViewController)
    
    // calback
    var itemsLoaded: (([String]) -> Void)? { get set }
    var itemDetailsLoaded: ((ItemDetails) -> Void)? { get set }
}

class ItemsListViewModel: ItemsListVMProtocol {
    
    private var items = [Item]()
    
    private lazy var loadQueue: DispatchQueue = {
        DispatchQueue(label: String(describing: Self.self) + "_loadQueue", qos: .userInteractive, attributes: .concurrent)
    }()
    
    func loadItems() {
        let processor = JSONArrayProcessor()
        guard let json = processor.readArray(file: "task") else { return }
        items = JSONParser().parseItems(from: json) ?? []
        itemsLoaded?(items.map {$0.title})
    }
    
    func openDetails(item: ItemDetails, vc: UIViewController) {
        ItemDetailsCoordinator(presenter: vc, itemDetails: item).start()
    }
    
    func showItemDetails(index: Int) {
        let group = DispatchGroup()
        let item = items[index]
        
        let imageUrls: [String] = [
            item.firstImgUrl,
            item.secondImgUrl,
            item.thirdImgUrl
        ]
        
        var images = [UIImage]()
        
        imageUrls
            .forEach { str in
                group.enter()
                loadQueue.async {
                    defer {
                        group.leave()
                    }
                    if let url = URL(string: str),
                       let data = try? Data(contentsOf: url),
                       let img = UIImage(data: data) {
                        images.append(img)
                    }
                }
            }
        
        group.notify(queue: .main) { [weak self] in
            self?.itemDetailsLoaded?(
                .init(
                    item: item,
                    images: images
                )
            )
        }
        
    }
    
    var itemsLoaded: (([String]) -> Void)?
    var itemDetailsLoaded: ((ItemDetails) -> Void)?
}

