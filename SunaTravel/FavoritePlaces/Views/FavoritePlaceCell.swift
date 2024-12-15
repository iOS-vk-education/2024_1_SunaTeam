//
//  FavoritePlaceCell.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import UIKit
import SwiftUI

fileprivate struct UIConstants {
    static let imageCornerRadius: CGFloat = 25
    static let titleFontSize: CGFloat = 16
    static let subtitleFontSize: CGFloat = 14
    static let titleTopPadding: CGFloat = 8
    static let subtitleTopPadding: CGFloat = 4
    static let imageHeight: CGFloat = 150
    static let collectionViewLineSpacing: CGFloat = 16
    static let collectionViewItemSpacing: CGFloat = 8
    static let collectionViewItemWidth: CGFloat = UIScreen.main.bounds.width / 2
    static let collectionViewItemHeight: CGFloat = 180
    static let viewSidePadding: CGFloat = 16
    static let titleTopMargin: CGFloat = 8
    static let titleFontLargeSize: CGFloat = 20
    static let subtitleIconConstant: CGFloat = 23
}

class FavoritePlaceCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = UIConstants.imageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.titleFontSize)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstants.subtitleFontSize)
        label.textColor = .gray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse") // Значок геолокации из SF Symbols
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var subtitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationIcon, subtitleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleStackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.subtitleTopPadding),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.subtitleIconConstant),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(with place: Place) {
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        imageView.image = UIImage(named: place.imageName)
    }
}

struct FavoritePlaceCellRepresentable: UIViewRepresentable {
    var place: Place

    func makeUIView(context: Context) -> FavoritePlaceCell {
        let cell = FavoritePlaceCell()
        cell.configure(with: place)
        return cell
    }

    func updateUIView(_ uiView: FavoritePlaceCell, context: Context) {
    }
}

struct FavoritePlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        let examplePlace = Place(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "FirstPlace")
        
        return FavoritePlaceCellRepresentable(place: examplePlace)
            .frame(width: UIConstants.collectionViewItemWidth, height: UIConstants.collectionViewItemHeight)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
