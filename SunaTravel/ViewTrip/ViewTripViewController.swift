import UIKit
import SwiftUI

class ViewTripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UI Elements
    // Background Image
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "FirstPlace")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 20
//        button.backgroundColor = UIColor(hex: "1B1E28").withAlphaComponent(0.16)
//        button.setTitle("<", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Details"
//        label.textColor = .black
//
//        // what with font???
//        if let font = UIFont(name: "SFUIDisplay-Bold", size: 90) {
//                label.font = UIFontMetrics.default.scaledFont(for: font)
//        } else{
//                label.font = UIFont.preferredFont(forTextStyle: .headline)
//        }
//
//        label.adjustsFontForContentSizeCategory = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        return label
//        }()

    // Main Container View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let collapseButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "7D848D").withAlphaComponent(0.2)
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let NiladriReservoirLabel: UILabel = {
        let label = UILabel()
        label.text = "Niladri Reservoir"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let TekergatLabel: UILabel = {
        let label = UILabel()
        label.text = "Tekergat"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var containerHeightConstraint: NSLayoutConstraint!
    private var selectedFile: UIImage?

    private let photoGalleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 70, height: 70)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var photos: [UIImage] = [
            UIImage(named: "FirstPlace")!,
            UIImage(named: "SecondPlace")!,
            UIImage(named: "ThirdPlace")!,
            UIImage(named: "FourthPlace")!,
            UIImage(named: "FifthPlace")!
        ]
    
    private let aboutDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "About Destination"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        You will get a complete travel package on the beaches, designed to provide you with an unforgettable experience. Our packages include everything you need for a perfect getaway, from airline tickets to recommended hotel rooms, ensuring that your journey is as smooth and enjoyable as possible.

        Imagine arriving at your destination, greeted by the warm sun and the sound of waves gently lapping at the shore. Our travel packages offer a variety of options tailored to your preferences, whether you’re looking for a romantic escape, a family vacation, or an adventurous trip with friends. You’ll have access to a selection of the best hotels, each chosen for their comfort, amenities, and proximity to the beach.

        In addition to accommodation, we also provide transportation options to make your travel hassle-free. Whether you prefer a rental car to explore the local area or shuttle services to and from the airport, we’ve got you covered. Our team is dedicated to ensuring that every aspect of your trip is taken care of, allowing you to focus on relaxation and enjoyment.

        Have you ever been on holiday to the Greek islands? If not, now is the perfect time to experience the stunning beauty of places like Santorini, Mykonos, and Crete. Picture yourself lounging on pristine beaches, indulging in delicious local cuisine, and exploring charming villages filled with rich history and culture. Our travel packages include guided tours and activities, so you can immerse yourself in the local lifestyle and create lasting memories.

        With our comprehensive travel packages, you can rest assured that every detail is meticulously planned to provide you with the ultimate beach vacation. From the moment you book your trip to the time you return home, we are here to support you every step of the way. Don’t miss out on the opportunity to unwind and rejuvenate on the beautiful beaches of Greece—book your travel package today and get ready for the adventure of a lifetime!
        """
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let readMoreButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Read more", for: .normal)
            button.setTitleColor(UIColor(hex: "FF7029"), for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(didTapReadMore), for: .touchUpInside)
            return button
    }()

//    private var photos: [UIImage] = [
//        UIImage(named: "FirstPlace")!,
//        UIImage(named: "SecondPlace")!,
//        UIImage(named: "ThirdPlace")!,
//        UIImage(named: "FourthPlace")!,
//        UIImage(named: "FifthPlace")!
//    ]

    private var isExpanded = false
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var subtitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationIcon, TekergatLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false // Scrolling is disabled if you remove it
        return scrollView
    }()
    
    private let descriptionContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        addCollapseButtonGesture()

        photoGalleryCollectionView.delegate = self
        photoGalleryCollectionView.dataSource = self
        photoGalleryCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }

    // MARK: - Setup Methods
    private func setupView() {
        view.addSubview(backgroundImageView)
        //view.addSubview(backButton)
        //view.addSubview(titleLabel)
        view.addSubview(containerView)

        containerView.addSubview(collapseButton)
        
        containerView.addSubview(descriptionScrollView)
        descriptionScrollView.addSubview(descriptionContentView)
        descriptionContentView.addSubview(descriptionLabel)
        descriptionContentView.addSubview(readMoreButton)

        containerView.addSubview(NiladriReservoirLabel)
        containerView.addSubview(TekergatLabel)
        containerView.addSubview(photoGalleryCollectionView)
        containerView.addSubview(aboutDestinationLabel)
        containerView.addSubview(subtitleStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Background Image
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Back Button
            //            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //            backButton.widthAnchor.constraint(equalToConstant: 40),
            //            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Title Label
            //            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            //            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
            
            // Container View
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 430)
        containerHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            collapseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            collapseButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            collapseButton.widthAnchor.constraint(equalToConstant: 36),
            collapseButton.heightAnchor.constraint(equalToConstant: 5),
            
            NiladriReservoirLabel.topAnchor.constraint(equalTo: collapseButton.bottomAnchor, constant: 16),
            NiladriReservoirLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            // Subtitle StackView (Location Icon + location Label)
            subtitleStackView.topAnchor.constraint(equalTo: NiladriReservoirLabel.bottomAnchor, constant: 7),
            subtitleStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            photoGalleryCollectionView.topAnchor.constraint(equalTo: TekergatLabel.bottomAnchor, constant: 12),
            photoGalleryCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            photoGalleryCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            photoGalleryCollectionView.heightAnchor.constraint(equalToConstant: 70),
            
            aboutDestinationLabel.topAnchor.constraint(equalTo: photoGalleryCollectionView.bottomAnchor, constant: 18),
            aboutDestinationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            descriptionScrollView.topAnchor.constraint(equalTo: aboutDestinationLabel.bottomAnchor, constant: 3),
            descriptionScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            descriptionScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            descriptionContentView.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor),
            descriptionContentView.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            descriptionContentView.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor),
            descriptionContentView.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
            descriptionContentView.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContentView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContentView.trailingAnchor, constant: -6),
            
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 7),
            // readMoreButton.leadingAnchor.constraint(equalTo: descriptionContentView.leadingAnchor),
            readMoreButton.trailingAnchor.constraint(equalTo: descriptionContentView.trailingAnchor, constant: -11),
            readMoreButton.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor),
            readMoreButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func addCollapseButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCollapseButton))
        collapseButton.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapCollapseButton() {
        let isCollapsed = containerHeightConstraint.constant == 430
        containerHeightConstraint.constant = isCollapsed ? 200 : 430
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func didTapReadMore() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 8
        readMoreButton.setTitle(isExpanded ? "Collapse" : "Read more", for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.descriptionScrollView.isScrollEnabled = self.isExpanded
            self.view.layoutIfNeeded()
        }
    }


    // MARK: - UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.item]
        cell.configure(with: photo, isLast: indexPath.item == photos.count - 1, remainingCount: photos.count - 4)
        return cell
    }
}

class FullScreenImageViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "SFUIDisplay", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.addSubview(imageView)
        view.addSubview(closeButton)

        imageView.image = image

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // MARK: Close Button constraint
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}


class PhotoCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let overlayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(overlayLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            overlayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            overlayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage, isLast: Bool, remainingCount: Int) {
        imageView.image = image
        overlayLabel.isHidden = true // without counter
        imageView.backgroundColor = .clear // clarity
    }

}

extension ViewTripViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.image = photo
        
        present(fullScreenVC, animated: true, completion: nil)
    }
}

struct ViewTripViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let ViewTripViewController = ViewTripViewController()
        let navigationController = UINavigationController(rootViewController: ViewTripViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

