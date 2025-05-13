//
//  FavoritePlaceViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import UIKit
import SwiftUI
import Combine

fileprivate struct UIConstants {
    static let collectionTopPadding: CGFloat = 15
    static let collectionViewLineSpacing: CGFloat = 15
    static let collectionViewItemSpacing: CGFloat = 6
    static let viewSidePadding: CGFloat = 16
    static let viewItemWidthPartition: CGFloat = 30
    
    static var collectionViewItemHeight: CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight * 0.25
    }
}

struct MockData {
    static let places: [Place] = [
        Place(title: "Niladri Reservoir", subtitle: "Tekergat, Sunamganj", imageName: "FirstPlace"),
        Place(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "SecondPlace"),
        Place(title: "Aonang Villa Resort", subtitle: "Bastola, Islampur", imageName: "ThirdPlace"),
        Place(title: "Rangauti Resort", subtitle: "Sylhet, Airport Road", imageName: "FourthPlace"),
        Place(title: "Kachura Resort", subtitle: "Vellima, Island", imageName: "FifthPlace"),
        Place(title: "Shakardu Resort", subtitle: "Shakartu, Pakistan", imageName: "SixthPlace")
    ]
}

class FavoritePlacesViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
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
        collectionView.register(FavoritePlaceCell.self, forCellWithReuseIdentifier: "FavoritePlaceCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupViews()
        setupCollectionView()
        
        AppSettings.shared.$currentLanguage
            .receive(on: RunLoop.main)
            .sink { [weak self] newLanguage in
                self?.updateLocalizedText(for: newLanguage)
            }
            .store(in: &cancellables)
        
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "All Places"
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
    
    private func updateLocalizedText(for language: String) {
        navigationItem.title = FavoriteText.title(for: language)
    }
}

struct FavoritePlacesViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FavoritePlacesViewController {
        return FavoritePlacesViewController()
    }
    
    func updateUIViewController(_ uiViewController: FavoritePlacesViewController, context: Context) {
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
