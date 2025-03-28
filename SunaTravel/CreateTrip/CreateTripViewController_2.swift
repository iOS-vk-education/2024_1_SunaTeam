////
////  Untitled.swift
////  SunaTravel
////
////  Created by Lilia Chechina on 28.03.2025.
////
//import UIKit
//
//class CreateTripViewController: UIViewController {
//    
//    private let backgroundImageView = BackgroundImageView(imageName: "background")
//    private let titleLabel = TitleLabel(text: "Создание поездки")
//    private let tripNameTextField = RoundedTextField(placeholder: "Название поездки")
//    private let createButton = PrimaryButton(title: "Создать")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupActions()
//    }
//
//    private func setupUI() {
//        view.addSubview(backgroundImageView)
//        view.addSubview(titleLabel)
//        view.addSubview(tripNameTextField)
//        view.addSubview(createButton)
//
//        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            tripNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            tripNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tripNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            tripNameTextField.heightAnchor.constraint(equalToConstant: 44),
//            
//            createButton.topAnchor.constraint(equalTo: tripNameTextField.bottomAnchor, constant: 20),
//            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            createButton.widthAnchor.constraint(equalToConstant: 150),
//            createButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    private func setupActions() {
//        createButton.addTarget(self, action: #selector(createTrip), for: .touchUpInside)
//    }
//
//    @objc private func createTrip() {
//        guard let tripName = tripNameTextField.text, !tripName.isEmpty else {
//            showAlert(title: "Ошибка", message: "Введите название поездки")
//            return
//        }
//        
//        // TODO: Добавить сохранение поездки в базу данных или API-запрос
//        print("Создана поездка: \(tripName)")
//        dismiss(animated: true, completion: nil)
//    }
//
//    private func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//}
//
