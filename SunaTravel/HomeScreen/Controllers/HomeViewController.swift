//
//  HomeScreenView.swift
//  SunaTravel
//
//  Created by salfetka on 21.12.2024.
//

import Foundation

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    @ObservedObject var profileViewModel: ProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
        let defaultAvatar = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(defaultAvatar, for: .normal)
        button.tintColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        button.setTitleColor(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: HomeViewConstants.profileButtonTextSize)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: HomeViewConstants.profileButtonTextSize, bottom: 0, right: 0)
        button.layer.cornerRadius = HomeViewConstants.profileButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: – Уведомления на будущее
    //    private let notificationButton: UIButton = {
    //        let button = UIButton(type: .system)
    //        button.setImage(UIImage(systemName: "bell.badge"), for: .normal)
    //        button.tintColor = UIColor { traitCollection in
    //                return traitCollection.userInterfaceStyle == .dark ? .white : .black
    //        }
    //        button.layer.cornerRadius = HomeViewConstants.notificationButtonCornerRadius
    //        button.layer.masksToBounds = true
    //        return button
    //    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember the\n bright moments"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: HomeViewConstants.titleLabelTextSize, weight: .bold)
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttribute(.foregroundColor, value: UIColor.orange, range: NSRange(location: 21, length: 7))
        label.attributedText = attributedString
        return label
    }()
    
    private let bestDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Destinations"
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
    
    @objc private func profileButtonTapped() {
        let profileVC = UIHostingController(rootView: ProfileView(viewModel: profileViewModel, showEditButton: false))
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func viewAllButtonTapped() {
        let favoritePlacesVC = FavoritePlacesViewController()
        navigationController?.pushViewController(favoritePlacesVC, animated: true)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: PlaceCellConstants.collectionViewItemWidth, height: PlaceCellConstants.collectionViewItemHeight)
        layout.minimumLineSpacing = PlaceCellConstants.collectionViewItemSpacing
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(HomePlaceCell.self, forCellWithReuseIdentifier: "DestinationCell")
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        //profileButton.
        viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
        
        updateProfileButton()
        
        profileViewModel.$profile
            .sink { [weak self] _ in
                self?.updateProfileButton()
            }
            .store(in: &cancellables)
        
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func updateProfileButton() {
        DispatchQueue.main.async {
            self.profileButton.setTitle(self.profileViewModel.profile.name, for: .normal)

            if let avatar = self.profileViewModel.profile.avatar {
                print("Avatar size: \(avatar.size)")
                
                let diameter: CGFloat = 22 
                let scaledAvatar = avatar.resize(to: CGSize(width: diameter, height: diameter))
                let roundedAvatar = scaledAvatar?.withRoundedCorners(radius: diameter / 2)
                
                self.profileButton.setImage(roundedAvatar?.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                self.profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
            }
            
            self.profileButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
    }
    
    
    // MARK: - Setup UI
    
    private func setupUI() {
        let headerStack = UIStackView(arrangedSubviews: [profileButton])
        profileButton.imageView?.contentMode = .scaleAspectFit
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
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlace = viewModel.places[indexPath.row]
        didTapCell(with: selectedPlace)
    }
    
    func didTapCell(with place: Place) {
        let tripDetailViewController = UIHostingController(rootView: ViewTripViewControllerWrapper())
        navigationController?.pushViewController(tripDetailViewController, animated: true)
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UIImage {
    func withRoundedCorners(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        path.addClip()
        draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as? HomePlaceCell else {
            return UICollectionViewCell()
        }
        let place = viewModel.places[indexPath.row]
        cell.configure(with: place)
        return cell
    }
}

struct HomeScreenView: View {
    var body: some View {
        HomeViewControllerWrapper()
    }
}

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: HomeViewController(profileViewModel: profileViewModel))
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
