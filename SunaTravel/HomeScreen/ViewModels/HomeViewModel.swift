//
//  HomeViewModel.swift
//  SunaTravel
//
//  Created by salfetka on 21.12.2024.
//

import Foundation

class HomeViewModel {
    // Данные пользователя
    //let user: User = User(name: "Leonardo", profileImageName: "profile_placeholder")
    
    // Данные популярных направлений
    let places: [Place] = [
        Place(title: "Niladri Reservoir", subtitle: "Tekergat, Sunamgnj", imageName: "FirstPlace"),
        Place(title: "Darma Valley", subtitle: "Darma, India", imageName: "SecondPlace")
    ]
}
