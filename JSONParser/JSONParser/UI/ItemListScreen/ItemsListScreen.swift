//
//  ViewController.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

class ItemsListScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ItemsListVMProtocol!
    
    private var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        title = "List"
        configure(viewModel: ItemsListViewModel())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadItems()
    }
    
    func configure(viewModel: ItemsListVMProtocol) {
        self.viewModel = viewModel
        self.viewModel.itemsLoaded = { [weak self] items in
            self?.items = items
            self?.tableView.reloadData()
        }
        
        self.viewModel.itemDetailsLoaded = { [weak self] item in
            guard let self else { return }
            
            self.hideLoadingView()
            self.viewModel.openDetails(item: item, vc: self)
        }
    }
    
    func setupTable() {
        tableView.register(cellType: ListItemCell.self)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ItemsListScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(cellType: ListItemCell.self, for: indexPath)
        cell.configure(title: items[indexPath.row])
        return cell
    }
}

extension ItemsListScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        showLoadingView()
        viewModel.showItemDetails(index: indexPath.row)
    }
}
