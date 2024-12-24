//
//  HomeScreenView.swift
//  SunaTravel
//
//  Created by salfetka on 21.12.2024.
//

import Foundation

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    fileprivate struct HomeViewConstants {
        static let profileButtonTextSize: CGFloat = 20
        static let profileButtonCornerRadius: CGFloat = 6
        static let notificationButtonCornerRadius: CGFloat = 11
        static let titleLabelTextSize: CGFloat = 34
        static let destinationLabelTextSize: CGFloat = 18
        static let viewAllLabelTextSize: CGFloat = 16
        static let headerStackSpacing: CGFloat = 10
        static let titleStackSpacing: CGFloat = 5
        static let mainStackSpacing: CGFloat = 15
        static let mainStackTopAnchor: CGFloat = 10
        static let mainStackLeadingAnchor: CGFloat = 20
        static let mainStackTrailingAnchor: CGFloat = -20
        static let buttonGrayOpacity: CGFloat = 0.3
        static let navBarHeight: CGFloat = 80
    }

    private let viewModel = HomeViewModel()

    // MARK: - UI Components
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Leonardo", for: .normal)
        button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: HomeViewConstants.profileButtonTextSize)
        button.layer.cornerRadius = HomeViewConstants.profileButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    private let notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = HomeViewConstants.notificationButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore the\nBeautiful world!"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: HomeViewConstants.titleLabelTextSize, weight: .bold)
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 22, length: 6))
        label.attributedText = attributedString
        return label
    }()
    
    private let bestDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Best Destination"
        label.font = UIFont.systemFont(ofSize: HomeViewConstants.destinationLabelTextSize, weight: .semibold)
        return label
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View all", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: HomeViewConstants.viewAllLabelTextSize, weight: .semibold)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: PlaceCellConstants.collectionViewItemWidth, height: PlaceCellConstants.collectionViewItemHeight)
        layout.minimumLineSpacing = PlaceCellConstants.collectionViewItemSpacing
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FavoritePlaceCell.self, forCellWithReuseIdentifier: "DestinationCell")
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let headerStack = UIStackView(arrangedSubviews: [profileButton, UIView(), notificationButton])
        headerStack.axis = .horizontal
        headerStack.alignment = .center
        headerStack.spacing = HomeViewConstants.headerStackSpacing
        
        let titleStack = UIStackView(arrangedSubviews: [bestDestinationLabel, UIView(), viewAllButton])
        titleStack.axis = .horizontal
        titleStack.spacing = HomeViewConstants.titleStackSpacing

        let mainStack = UIStackView(arrangedSubviews: [headerStack, titleLabel, titleStack, collectionView])
        mainStack.axis = .vertical
        mainStack.spacing = HomeViewConstants.mainStackSpacing
        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: HomeViewConstants.mainStackTopAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HomeViewConstants.mainStackLeadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: HomeViewConstants.mainStackTrailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: PlaceCellConstants.collectionViewItemHeight)
        ])
        
        let navigationBar = NavigationBar()
        let hostingController = UIHostingController(rootView: navigationBar)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: HomeViewConstants.navBarHeight)
        ])
    
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as? FavoritePlaceCell else {
            return UICollectionViewCell()
        }
        let place = viewModel.places[indexPath.row]
        cell.configure(with: place)
        return cell
    }
}

struct HomeViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 13")
    }
}
