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
    static let collectionViewItemSpacing: CGFloat = 8
    static let viewSidePadding: CGFloat = 16
    static let titleTopMargin: CGFloat = 8
    static let titleFontLargeSize: CGFloat = 20
    static let subtitleIconConstant: CGFloat = 20
    static let leadingPadding: CGFloat = 5
    static var imageHeight: CGFloat { return UIScreen.main.bounds.width * 0.35 }
    static var collectionViewItemHeight: CGFloat { return UIScreen.main.bounds.width * 0.6 }
    static var collectionViewItemWidth: CGFloat { return UIScreen.main.bounds.width / 2 }
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
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
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
    
    private func setupViews() {
        setupImageView()
        setupTitleLabel()
        setupSubtitleStackView()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.leadingPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupSubtitleStackView() {
        contentView.addSubview(subtitleStackView)
        locationIcon.widthAnchor.constraint(equalToConstant: UIConstants.subtitleIconConstant).isActive = true
        NSLayoutConstraint.activate([
            subtitleStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.subtitleTopPadding),
            subtitleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.leadingPadding),
            subtitleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with place: Place) {
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
        imageView.image = UIImage(named: place.imageName)
    }
}

protocol PlaceProvider {
    func getModel() -> Place
}

struct FavoritePlaceCellRepresentable: UIViewRepresentable {
    var placeProvider: PlaceProvider

    func makeUIView(context: Context) -> FavoritePlaceCell {
        let cell = FavoritePlaceCell()
        cell.configure(with: placeProvider.getModel())
        return cell
    }

    func updateUIView(_ uiView: FavoritePlaceCell, context: Context) {
        uiView.configure(with: placeProvider.getModel())
    }
}

struct ExamplePlaceProvider: PlaceProvider {
    func getModel() -> Place {
        return Place(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "FirstPlace")
    }
}

struct FavoritePlaceCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePlaceCellRepresentable(placeProvider: ExamplePlaceProvider())
            .frame(width: UIConstants.collectionViewItemWidth, height: UIConstants.collectionViewItemHeight)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
