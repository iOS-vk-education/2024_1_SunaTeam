import Foundation
import FirebaseAuth
class AppState {
    static let shared = AppState()

    let profileViewModel: ProfileViewModel

    private init() {
        let initialProfile = ProfileData(
            name: "",
            email: "",
            location: "",
            phoneNumber: "",
            rewardPointsCount: 0,
            travelTipsCount: 0,
            bucketListCount: 0
        )
        self.profileViewModel = ProfileViewModel(profile: initialProfile)

        if let uid = Auth.auth().currentUser?.uid {
            profileViewModel.loadProfileData(for: uid)
        }
    }
}

