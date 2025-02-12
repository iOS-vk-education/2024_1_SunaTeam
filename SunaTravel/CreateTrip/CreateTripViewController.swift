import UIKit
import PhotosUI  // for multiply photo selection
import SwiftUI

class CreateTripViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UI Elements

    // Background Image
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
//        label.text = "Create a trip"
        label.textColor = .systemBackground
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.removeConstraints(label.constraints)
        label.textAlignment = .center
        return label
    }()


    // Main Container View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]  //only top corners
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

    private let aboutDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "About Destination"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Write description"
        textView.textColor = .lightGray
//        textView.backgroundColor = .quaternaryLabel
        textView.backgroundColor = UIColor(hex: "F7F7F9")
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()

    private let addFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)  // bold type
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(hex: "F7F7F9")
        button.addTarget(self, action: #selector(didTapAddFile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.contentVerticalAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 0)
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
    private var selectedFile: UIImage?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupDescriptionTextView()  // for the modified UITextView
        addCollapseButtonGesture() // Add gesture for collapse button
    }

    // MARK: - Setup Methods

    private func setupView() {
        view.addSubview(backgroundImageView)
        //view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        view.addSubview(addFileButton)

        containerView.addSubview(collapseButton)
        containerView.addSubview(tripNameTextField)
        containerView.addSubview(locationTextField)
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

            // Back Button
//            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            backButton.widthAnchor.constraint(equalToConstant: 40),
//            backButton.heightAnchor.constraint(equalToConstant: 40),

            
            // Title Label
            // MARK: - Maybe somehow fix it in a different way, not from the Back button
            //titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor), // Центр по вертикали относительно кнопки "Назад"
            //
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8), // 80% of screen

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
            tripNameTextField.heightAnchor.constraint(equalToConstant: 38),

            // Location Field
            locationTextField.topAnchor.constraint(equalTo: tripNameTextField.bottomAnchor, constant: 12),
            locationTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            locationTextField.widthAnchor.constraint(equalToConstant: 360),
            locationTextField.heightAnchor.constraint(equalToConstant: 38),

            // About Destination Label
            aboutDestinationLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12),
            aboutDestinationLabel.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),

            // Description TextView
            descriptionTextView.topAnchor.constraint(equalTo: aboutDestinationLabel.bottomAnchor, constant: 8),
            descriptionTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 360),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 140),

            // Save Button
            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 360),
            saveButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }

    private func setupDescriptionTextView() {
        descriptionTextView.delegate = self
    }

    private func addCollapseButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCollapseButton))
        collapseButton.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapAddFile() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0 // 0 means unlimited choice
        config.filter = .images // limit the choice to images only

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    @objc private func didTapCollapseButton() {
        let isCollapsed = containerHeightConstraint.constant == 430
        containerHeightConstraint.constant = isCollapsed ? 200 : 430
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    // Helper: Create text fields and views
    private static func createRoundedTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = UIColor(hex: "F7F7F9")
//        textField.backgroundColor = .quaternaryLabel
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

// MARK: - UITextViewDelegate
extension CreateTripViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.text.isEmpty {
            textView.text = "Write description"
//            textView.textColor = .quaternaryLabel
            textView.textColor = .lightGray
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
// The code works on devices with iOS 14 and higher
extension CreateTripViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard !results.isEmpty else { return }

        let firstItem = results.first
        firstItem?.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            guard let self = self, let image = object as? UIImage, error == nil else {
                 assertionFailure()
                 return
            }

            DispatchQueue.main.async {
                self.backgroundImageView.image = image // set the first file as background
            }
        }
    }
}

// Swift-UI wrapper for UIKit by using UIViewControllerRepresentable
struct CreateTripViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let createTripViewController = CreateTripViewController()
        let navigationController = UINavigationController(rootViewController: createTripViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}
