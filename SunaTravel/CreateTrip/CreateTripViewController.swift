import UIKit
import PhotosUI  // for multiply photo selection
import SwiftUI

import UIKit

class CreateTripViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - UI Elements

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "FirstPlace")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Title Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

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

    private let tripNameTextField = CreateTripViewController.createRoundedTextField(placeholder: "Write a trip name")
    private let locationTextField = CreateTripViewController.createRoundedTextField(placeholder: "Write location")
    private let dateTextField = CreateTripViewController.createRoundedTextField(placeholder: "Enter Date")

    private let aboutDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "About Destination"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.backgroundColor = .quaternaryLabel
        textView.layer.opacity = 0.4
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()

    private let addFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(hex: "F7F7F9")
        button.addTarget(self, action: #selector(didTapAddFile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = UIColor(hex: "24BAEC")
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var containerHeightConstraint: NSLayoutConstraint!
    private var selectedDate: Date?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        
        // Setting delegate for the text field
        dateTextField.delegate = self
    }

    // MARK: - Setup Methods

    private func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        view.addSubview(addFileButton)

        containerView.addSubview(collapseButton)
        containerView.addSubview(tripNameTextField)
        containerView.addSubview(locationTextField)
        containerView.addSubview(dateTextField)
        containerView.addSubview(aboutDestinationLabel)
        containerView.addSubview(descriptionTextView)
        containerView.addSubview(saveButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Background Image
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),

            // Add File Button
            addFileButton.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10),
            addFileButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            addFileButton.widthAnchor.constraint(equalToConstant: 40),
            addFileButton.heightAnchor.constraint(equalToConstant: 40),

            // Container View
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        containerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 430)
        containerHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            // Collapse Button
            collapseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            collapseButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            collapseButton.widthAnchor.constraint(equalToConstant: 36),
            collapseButton.heightAnchor.constraint(equalToConstant: 5),

            // Trip Name Field
            tripNameTextField.topAnchor.constraint(equalTo: collapseButton.bottomAnchor, constant: 16),
            tripNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            tripNameTextField.widthAnchor.constraint(equalToConstant: 360),
            tripNameTextField.heightAnchor.constraint(equalToConstant: 48),

            // Location Field
            locationTextField.topAnchor.constraint(equalTo: tripNameTextField.bottomAnchor, constant: 12),
            locationTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            locationTextField.widthAnchor.constraint(equalToConstant: 360),
            locationTextField.heightAnchor.constraint(equalToConstant: 48),

            // Date Text Field
            dateTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12),
            dateTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dateTextField.widthAnchor.constraint(equalToConstant: 360),
            dateTextField.heightAnchor.constraint(equalToConstant: 48),

            // About Destination Label
            aboutDestinationLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 12),
            aboutDestinationLabel.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),

            // Description TextView
            descriptionTextView.topAnchor.constraint(equalTo: aboutDestinationLabel.bottomAnchor, constant: 8),
            descriptionTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 360),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),

            // Save Button
            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 25),
            saveButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 360),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapAddFile() {
        // Your code to add file
    }

    // UITextFieldDelegate method to handle manual date input
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == dateTextField, let text = textField.text, !text.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let date = dateFormatter.date(from: text) {
                selectedDate = date
            } else {
                // If the date format is incorrect, show an alert or reset
                print("Invalid date format")
                dateTextField.text = ""
            }
        }
    }

    private static func createRoundedTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = .quaternaryLabel
        textField.layer.opacity = 0.4
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}


struct CreateTripViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let createTripViewController = CreateTripViewController()
        let navigationController = UINavigationController(rootViewController: createTripViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
