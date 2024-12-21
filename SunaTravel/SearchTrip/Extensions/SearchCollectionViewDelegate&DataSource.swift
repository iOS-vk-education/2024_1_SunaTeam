//
//  CollectionViewDelegate&DataSource.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 21.12.2024.
//
import UIKit

// MARK: - UICollectionViewDataSource
extension SearchPlacesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoritePlaceCell.reuseID,
            for: indexPath
        ) as? FavoritePlaceCell else {
            fatalError("Unable to dequeue FavoritePlaceCell")
        }
        let place = viewModel.filteredPlaces[indexPath.item]
        cell.configure(with: place)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchPlacesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.filteredPlaces.count else {
            print("Error: Index out of bounds")
            return
        }
        let selectedPlace = viewModel.filteredPlaces[indexPath.item]
    }
}


// MARK: - UISearchBarDelegate
extension SearchPlacesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterPlaces(by: searchText)
    }
}
