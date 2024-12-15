//
//  Delegate+DataSource.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import UIKit

extension FavoritePlacesViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePlaceCell", for: indexPath) as! FavoritePlaceCell
        let place = places[indexPath.item]
        cell.configure(with: place)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = places[indexPath.item]
    }
}
