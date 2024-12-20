//
//  Delegate+DataSource.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
import UIKit

extension FavoritePlacesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MockData.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePlaceCell", for: indexPath) as! FavoritePlaceCell
        let place = MockData.places[indexPath.item]
        cell.configure(with: place)
        return cell
    }
}
extension FavoritePlacesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = MockData.places[indexPath.item]
        print("Selected Place: \(selectedPlace.title)")
    }
}
