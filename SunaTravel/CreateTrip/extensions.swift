//import UIKit
//import PhotosUI
//
//// MARK: - UITextViewDelegate
//extension CreateTripViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView == descriptionTextView && textView.textColor == .lightGray {
//            textView.text = ""
//            textView.textColor = UIColor.label
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView == descriptionTextView && textView.text.isEmpty {
//            textView.text = "Write description"
//            textView.textColor = .lightGray
//        }
//    }
//}
//
//// MARK: - PHPickerViewControllerDelegate
//// The code works on devices with iOS 14 and higher
//extension CreateTripViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true, completion: nil)
//
//        guard !results.isEmpty else { return }
//
//        let firstItem = results.first
//        firstItem?.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
//            guard let self = self, let image = object as? UIImage, error == nil else {
//                 assertionFailure()
//                 return
//            }
//
//            DispatchQueue.main.async {
//                self.backgroundImageView.image = image // set the first file as background
//            }
//        }
//    }
//}
//
//extension CreateTripViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField.textColor == .lightGray {
//            textField.text = ""
////            textField.textColor = .black
//            textField.textColor = UIColor.label // auto adaptation to themes
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.isEmpty == true {
//            if textField == tripNameTextField {
//                textField.text = "Write a trip name"
//            } else if textField == locationTextField {
//                textField.text = "Write location"
//            }
//            textField.textColor = .lightGray
//        }
//    }
//}
