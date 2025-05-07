import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileData
    
    private let db = Firestore.firestore()
    
    init(profile: ProfileData) {
        self.profile = profile
    }

    func loadProfileData(for uid: String) {
        db.collection("userData").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data(), error == nil {
                DispatchQueue.main.async {
                    self.profile.name = data["name"] as? String ?? ""
                    self.profile.email = data["email"] as? String ?? ""
                    self.profile.phoneNumber = data["phoneNumber"] as? String ?? ""
                    self.profile.location = data["location"] as? String ?? ""
                    self.profile.rewardPointsCount = data["rewardPointsCount"] as? Int ?? 0
                    self.profile.travelTipsCount = data["travelTipsCount"] as? Int ?? 0
                    self.profile.bucketListCount = data["bucketListCount"] as? Int ?? 0
                }
            } else {
                print("Ошибка загрузки профиля: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func saveChanges(name: String, email: String, location: String, phoneNumber: String, avatar: UIImage?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "location": location,
            "phoneNumber": phoneNumber
        ]

        db.collection("userData").document(uid).setData(userData) { error in
            if let error = error {
                print("Ошибка сохранения: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.profile.name = name
                    self.profile.email = email
                    self.profile.location = location
                    self.profile.phoneNumber = phoneNumber
                    self.profile.avatar = avatar
                }
            }
        }
    }
}
