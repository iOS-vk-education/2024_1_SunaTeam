//
//  SearchPlacesViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 15.12.2024.
//

import UIKit
import SwiftUI
import Combine

class SearchPlacesViewController: UIViewController {
    
    fileprivate struct UIConstants {
        static let searchBarTopPadding: CGFloat = 100
        static let collectionTopPadding: CGFloat = 10
        static let collectionViewLineSpacing: CGFloat = 50
        static let collectionViewItemSpacing: CGFloat = 6
        static let viewSidePadding: CGFloat = 16
        static let viewItemWidthPartition: CGFloat = 40
        
        static var collectionViewItemHeight: CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            return screenHeight * 0.2
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for places"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UIConstants.collectionViewLineSpacing
        layout.minimumInteritemSpacing = UIConstants.collectionViewItemSpacing
        
        let totalSpacing = UIConstants.collectionViewItemSpacing + (UIConstants.viewSidePadding * 2)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 2 - UIConstants.viewItemWidthPartition
        layout.itemSize = CGSize(width: itemWidth, height: UIConstants.collectionViewItemHeight)
        layout.sectionInset = UIEdgeInsets(
            top: UIConstants.collectionTopPadding,
            left: UIConstants.viewSidePadding,
            bottom: 0,
            right: UIConstants.viewSidePadding
        )
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoritePlaceCell.self, forCellWithReuseIdentifier: FavoritePlaceCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var viewModel = SearchPlacesViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        bindViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Search"
        
        let backButton = UIBarButtonItem(
            title: "<",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.resetSearch()
        collectionView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.searchBarTopPadding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.viewSidePadding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.viewSidePadding),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: UIConstants.collectionTopPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.viewSidePadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.viewSidePadding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$filteredPlaces
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// SwiftUI Preview
struct SearchPlacesViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let searchPlacesVC = SearchPlacesViewController()
        return UINavigationController(rootViewController: searchPlacesVC)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

struct SearchPlacesViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchPlacesViewControllerRepresentable()
                .previewDevice("iPhone 13")
                .preferredColorScheme(.light)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
