//
//  UICollectionViewCell.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 21.12.2024.
//
import UIKit

extension UICollectionViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
