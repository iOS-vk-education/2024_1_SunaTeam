
//
import UIKit
import SwiftUI

struct PlaceCellConstants {
    static let imageCornerRadius: CGFloat = 20
    static let titleFontSize: CGFloat = 18
    static let subtitleFontSize: CGFloat = 16
    static let titleTopPadding: CGFloat = 12
    static let subtitleTopPadding: CGFloat = 6
    static let collectionViewItemSpacing: CGFloat = 16
    static let viewSidePadding: CGFloat = 20
    static let titleTopMargin: CGFloat = 10
    static let titleFontLargeSize: CGFloat = 22
    static let subtitleIconConstant: CGFloat = 24
    static let leadingPadding: CGFloat = 10
    static var imageHeight: CGFloat { return UIScreen.main.bounds.width * 1.1 }
    static var collectionViewItemHeight: CGFloat { return UIScreen.main.bounds.width * 1.3}
    static var collectionViewItemWidth: CGFloat { return UIScreen.main.bounds.width * 0.87 }
    static let stackViewSpacing: CGFloat = 4
}


class FavoritePlaceCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = PlaceCellConstants.imageCornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: PlaceCellConstants.titleFontSize)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: PlaceCellConstants.subtitleFontSize)
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
        stackView.spacing = PlaceCellConstants.stackViewSpacing
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
            imageView.heightAnchor.constraint(equalToConstant: PlaceCellConstants.imageHeight)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: PlaceCellConstants.titleTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PlaceCellConstants.leadingPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupSubtitleStackView() {
        contentView.addSubview(subtitleStackView)
        locationIcon.widthAnchor.constraint(equalToConstant: PlaceCellConstants.subtitleIconConstant).isActive = true
        NSLayoutConstraint.activate([
            subtitleStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PlaceCellConstants.subtitleTopPadding),
            subtitleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PlaceCellConstants.leadingPadding),
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
            .frame(width: PlaceCellConstants.collectionViewItemWidth, height: PlaceCellConstants.collectionViewItemHeight)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
