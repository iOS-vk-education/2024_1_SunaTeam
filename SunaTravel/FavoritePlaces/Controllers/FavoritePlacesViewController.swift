//
//  FavoritePlaceViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import UIKit
import SwiftUI

struct MockData {
    static let places: [PlaceModel] = [
        PlaceModel(title: "Niladri Reservoir", subtitle: "Tekergat, Sunamganj", imageName: "FirstPlace"),
        PlaceModel(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "SecondPlace"),
        PlaceModel(title: "Aonang Villa Resort", subtitle: "Bastola, Islampur", imageName: "ThirdPlace"),
        PlaceModel(title: "Rangauti Resort", subtitle: "Sylhet, Airport Road", imageName: "FourthPlace"),
        PlaceModel(title: "Kachura Resort", subtitle: "Vellima, Island", imageName: "FifthPlace"),
        PlaceModel(title: "Shakardu Resort", subtitle: "Shakartu, Pakistan", imageName: "SixthPlace")
    ]
}

class FavoritePlacesViewController: UIViewController {
    
    fileprivate struct UIConstants {
        static let collectionTopPadding: CGFloat = 30
        static let collectionViewLineSpacing: CGFloat = 50
        static let collectionViewItemSpacing: CGFloat = 6
        static let viewSidePadding: CGFloat = 16
        static let viewItemWidthPartition: CGFloat = 40
        static let UIBackgroundColor: UIColor = .white

        static var collectionViewItemHeight: CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            return screenHeight * 0.2
        }
    }
    
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
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.UIBackgroundColor
        setupNavigationBar()
        setupViews()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Favorite Places"
        
        let backButton = UIBarButtonItem(
            title: "<",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.collectionViewLineSpacing),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.viewSidePadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.viewSidePadding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// SwiftUI Preview
struct FavoritePlacesViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let vc = FavoritePlacesViewController()
        return UINavigationController(rootViewController: vc)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

struct FavoritePlacesViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoritePlacesViewControllerRepresentable()
                .previewDevice("iPhone 13")
                .preferredColorScheme(.light)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
