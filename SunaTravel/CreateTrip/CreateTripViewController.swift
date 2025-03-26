import UIKit
import PhotosUI  // for multiply photo selection
import SwiftUI

class CreateTripViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - UI Elements

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "FirstPlace")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Create a trip"
        label.textColor = .systemBackground
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.removeConstraints(label.constraints)
        label.textAlignment = .center
        return label
    }()
     
    // for addNoteButton
    private let addNoteContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.adaptiveColor(lightHex: "F7F7F9", darkHex: "2C2C2E")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private let addNoteButton: UIButton = {
//        let button = UIButton(type: .system)
//        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
//        let image = UIImage(systemName: "square.and.pencil", withConfiguration: config)
//        button.setImage(image, for: .normal)
//        button.tintColor = .white
//        button.addTarget(self, action: #selector(didTapAddNote), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    private let addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
//        label.textColor = .black
        label.textColor = UIColor.adaptiveColor(lightHex: "000000", darkHex: "FFFFFF")
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Write description"
        textView.textColor = .lightGray
        textView.backgroundColor = UIColor.adaptiveColor(lightHex: "F7F7F9", darkHex: "2C2C2E")
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()

    private let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select date", for: .normal)
//        button.backgroundColor = UIColor(hex: "F7F7F9")
        button.backgroundColor = UIColor.adaptiveColor(lightHex: "F7F7F9", darkHex: "2C2C2E")
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDateButton), for: .touchUpInside)
        return button
    }()

    private let addFileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.adaptiveColor(lightHex: "F7F7F9", darkHex: "2C2C2E")
//        button.backgroundColor = UIColor(hex: "F7F7F9")
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
//        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitleColor(.white, for: .normal)
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
//        addNoteButton.addTarget(self, action: #selector(didTapAddNote), for: .touchUpInside)
        let noteButton = UIBarButtonItem(
               image: UIImage(systemName: "square.and.pencil"),
               style: .plain,
               target: self,
               action: #selector(didTapAddNote)
           )
        noteButton.tintColor = UIColor.systemRed
           
           navigationItem.rightBarButtonItem = noteButton

    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if descriptionTextView.text == "Write description" {
                descriptionTextView.textColor = .lightGray
            } else {
                descriptionTextView.textColor = UIColor.label
            }
        }
    }

    // MARK: - Setup Methods

    private func setupView() {
        view.addSubview(backgroundImageView)
        //view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(addNoteButton)
        view.addSubview(containerView)
        view.addSubview(addFileButton)
        view.addSubview(dateButton)
        view.addSubview(addNoteContainer)

        addNoteContainer.addSubview(addNoteButton)
        containerView.addSubview(collapseButton)
        containerView.addSubview(tripNameTextField)
        containerView.addSubview(locationTextField)
        containerView.addSubview(aboutDestinationLabel)
        containerView.addSubview(descriptionTextView)
        containerView.addSubview(saveButton)
        
        // Set placeholder text manually, like in UITextView
        tripNameTextField.text = "Write a trip name"
        tripNameTextField.textColor = .lightGray
        tripNameTextField.delegate = self

        locationTextField.text = "Write location"
        locationTextField.textColor = .lightGray
        locationTextField.delegate = self
        
        descriptionTextView.textColor = descriptionTextView.text == "Write description" ? .lightGray : UIColor.label
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
            //titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8), // 80% of screen

            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addNoteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            
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
        
        // Date Button
        NSLayoutConstraint.activate([
            dateButton.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10),
            dateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 9),
            dateButton.widthAnchor.constraint(equalToConstant: 120),
            dateButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            addNoteContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            // расстояние от верха
            addNoteContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNoteContainer.widthAnchor.constraint(equalToConstant: 40),
            addNoteContainer.heightAnchor.constraint(equalToConstant: 40),

            addNoteButton.centerXAnchor.constraint(equalTo: addNoteContainer.centerXAnchor),
            addNoteButton.centerYAnchor.constraint(equalTo: addNoteContainer.centerYAnchor),
        ])
        
        

    }
    private func updateTextViewColor() {
        if descriptionTextView.text == "Write description" {
            descriptionTextView.textColor = .lightGray
        } else {
            descriptionTextView.textColor = UIColor.label
        }
    }

    private func setupDescriptionTextView() {
        descriptionTextView.delegate = self
        updateTextViewColor()
        
        // add left padding
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 8)
    }


    private func addCollapseButtonGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCollapseButton))
        collapseButton.addGestureRecognizer(tapGesture)
    }

    @objc private func didTapBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAddNote() {
        // if addNoteButton – open SwiftUI-screen
        let contentView = NotesView()
        let hostingController = UIHostingController(rootView: contentView)
        let navController = UINavigationController(rootViewController: hostingController)
            navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
        
        // if view on UIKit на UIKit
//        let notesViewController = NotesViewController()
//        let navController = UINavigationController(rootViewController: notesViewController)
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true, completion: nil)
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
    

    @objc private func didTapDateButton() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date() // Forbid to choose future dates

        let alert = UIAlertController(title: "Select Date", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20)
        ])

        let selectAction = UIAlertAction(title: "OK", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let selectedDate = formatter.string(from: datePicker.date)
            self.dateButton.setTitle(selectedDate, for: .normal)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(selectAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    // Helper: Create text fields and views
    private static func createRoundedTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
//        textField.backgroundColor = UIColor(hex: "F7F7F9")
        textField.backgroundColor = UIColor.adaptiveColor(lightHex: "F7F7F9", darkHex: "2C2C2E")
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        
//        // set the placeholder color to gray
//        textField.attributedPlaceholder = NSAttributedString(
//                string: placeholder,
//                attributes: [.foregroundColor: UIColor.lightGray]
//        )
        
        // add left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }
}

// MARK: - UITextViewDelegate
extension CreateTripViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = UIColor.label
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == descriptionTextView && textView.text.isEmpty {
            textView.text = "Write description"
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

extension CreateTripViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == .lightGray {
            textField.text = ""
//            textField.textColor = .black
            textField.textColor = UIColor.label // auto adaptation to themes
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            if textField == tripNameTextField {
                textField.text = "Write a trip name"
            } else if textField == locationTextField {
                textField.text = "Write location"
            }
            textField.textColor = .lightGray
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


