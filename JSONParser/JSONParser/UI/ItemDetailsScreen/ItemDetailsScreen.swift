//
//  ItemDetailsScreen.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import UIKit

class ItemDetailsScreen: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionLayout: UICollectionViewFlowLayout!
    
    private var viewModel: ItemDetailsScreenViewModelProtocol!
    
    func configure(viewModel: ItemDetailsScreenViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        configureView()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionLayout.minimumLineSpacing = 10
        collectionView.register(cellType: CollectionViewImageCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func configureView() {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}

extension ItemDetailsScreen: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(cellType: CollectionViewImageCell.self, for: indexPath)
        cell.configure(with: viewModel.images[indexPath.item])
        return cell
    }
}

extension ItemDetailsScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = viewModel.images[indexPath.item].size
        let height = collectionView.frame.height * 0.7
        let width = imageSize.width * height / imageSize.height
        return CGSize(width: width, height: height)
    }
}
