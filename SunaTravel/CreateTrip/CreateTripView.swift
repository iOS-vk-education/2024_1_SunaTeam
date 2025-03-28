////
////  CreateTripView.swift
////  SunaTravel
////
////  Created by Lilia Chechina on 28.03.2025.
////
//import UIKit
//import PhotosUI  // for multiply photo selection
//import SwiftUI
//
//class CreateTripViewController: UIViewController {
//    // MARK: - UI Elements
//    private let backgroundImageView = BackgroundImageView(imageName: "FirstPlace")
//    private let titleLabel = TitleLabel()
//    private let containerView = TripContainerView()
//    private let tripNameTextField = RoundedTextField(placeholder: "Write a trip name")
//    private let locationTextField = RoundedTextField(placeholder: "Write location")
//    private let aboutDestinationLabel = SectionLabel(text: "About Destination")
//    private let descriptionTextView = PlaceholderTextView(placeholder: "Write description")
//    private let dateButton = ActionButton(title: "Select date", action: #selector(didTapDateButton))
//    private let addFileButton = ActionButton(title: "+", action: #selector(didTapAddFile))
//    private let saveButton = ActionButton(title: "Save")
//    private var containerHeightConstraint: NSLayoutConstraint!
//
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupLayout()
//    }
//
//    // MARK: - Setup Methods
//    private func setupView() {
//        view.addSubview(backgroundImageView)
//        view.addSubview(titleLabel)
//        view.addSubview(containerView)
//        view.addSubview(addFileButton)
//        view.addSubview(dateButton)
//        containerView.addSubview(tripNameTextField)
//        containerView.addSubview(locationTextField)
//        containerView.addSubview(aboutDestinationLabel)
//        containerView.addSubview(descriptionTextView)
//        containerView.addSubview(saveButton)
//    }
//
//    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            backgroundImageView.constraints(to: view),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            containerView.constraints(to: view, edges: [.leading, .trailing, .bottom]),
//            dateButton.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10),
//            dateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9),
//            addFileButton.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10),
//            addFileButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
//        ])
//    }
//    
//    // MARK: - Actions
//    @objc private func didTapDateButton() {
//        let datePickerVC = DatePickerViewController { selectedDate in
//            self.dateButton.setTitle(selectedDate, for: .normal)
//        }
//        present(datePickerVC, animated: true)
//    }
//    
//    @objc private func didTapAddFile() {
//        let pickerVC = ImagePickerViewController()
//        present(pickerVC, animated: true)
//    }
//}
//
