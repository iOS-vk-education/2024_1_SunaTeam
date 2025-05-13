// SearchPlacesViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 15.12.2024.
//

import UIKit
import SwiftUI
import Combine

fileprivate struct UIConstants {
    static let collectionTopPadding: CGFloat = 10
    static let collectionViewLineSpacing: CGFloat = 50
    static let collectionViewItemSpacing: CGFloat = 6
    static let collectionViewItemHeight: CGFloat = 180
    static let viewSidePadding: CGFloat = 16
    static let viewItemWidthPartition: CGFloat = 40
}

class SearchPlacesViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDataSource {
    
    var viewModel = SearchPlacesViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UIConstants.collectionViewLineSpacing
        layout.minimumInteritemSpacing = UIConstants.collectionViewItemSpacing
        
        let totalSpacing = UIConstants.collectionViewItemSpacing + (UIConstants.viewSidePadding * 2)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 2 - UIConstants.viewItemWidthPartition
        
        layout.itemSize = CGSize(width: itemWidth, height: UIConstants.collectionViewItemHeight)
        layout.sectionInset = UIEdgeInsets(top: UIConstants.collectionTopPadding, left: UIConstants.viewSidePadding, bottom: 0, right: UIConstants.viewSidePadding)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoritePlaceCell.self, forCellWithReuseIdentifier: "FavoritePlaceCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for places"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        AppSettings.shared.$currentLanguage
            .receive(on: RunLoop.main)
            .sink { [weak self] newLanguage in
                self?.updateLocalizedText(for: newLanguage)
            }
            .store(in: &cancellables)
        
        collectionView.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.viewSidePadding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.viewSidePadding),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: UIConstants.collectionTopPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.viewSidePadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.viewSidePadding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePlaceCell", for: indexPath) as! FavoritePlaceCell
        let place = MockData.places[indexPath.item]
        cell.configure(with: place)
        cell.didSelectPlace = {
            self.didTapCell(with: place)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = viewModel.filteredPlaces[indexPath.item]
        didTapCell(with: selectedPlace)
    }
    
    func didTapCell(with place: Place) {
        let detailViewController = UIHostingController(rootView: ViewTripViewControllerWrapper())
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    // UISearchBarDelegate method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPlaces(by: searchText)
        collectionView.reloadData()
    }
    
    private func updateLocalizedText(for language: String) {
        searchBar.placeholder = SearchText.search(for: language)
    }
}

struct SearchScreenView: View {
    var body: some View {
        SearchViewControllerWrapper()
    }
}

struct SearchViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: SearchPlacesViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct SearchPlacesViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let searchPlacesVC = SearchPlacesViewController()
        return UINavigationController(rootViewController: searchPlacesVC)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

struct SearchPlacesViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchPlacesViewControllerRepresentable()
                .previewDevice("iPhone 13")
                .preferredColorScheme(.light)
        }
    }
}
