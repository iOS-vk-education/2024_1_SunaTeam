//
//  SearchPlaceViewModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 15.12.2024.
//
import Foundation

class SearchPlacesViewModel {
    
    private(set) var places: [Place] = [
        Place(title: "Niladri Reservoir", subtitle: "Tekergat, Sunamganj", imageName: "FirstPlace"),
        Place(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "SecondPlace"),
        Place(title: "Aonang Villa Resort", subtitle: "Bastola, Islampur", imageName: "ThirdPlace"),
        Place(title: "Rangauti Resort", subtitle: "Sylhet, Airport Road", imageName: "FourthPlace"),
        Place(title: "Kachura Resort", subtitle: "Vellima, Island", imageName: "FifthPlace"),
        Place(title: "Shakardu Resort", subtitle: "Shakartu, Pakistan", imageName: "SixthPlace")
    ]
    
    private(set) var filteredPlaces: [Place] = []
    var isSearchActive: Bool = false
    
    init() {
        self.filteredPlaces = places
    }
    
    func filterPlaces(by searchText: String) {
        if searchText.isEmpty {
            isSearchActive = false
            filteredPlaces = places
        } else {
            isSearchActive = true
            filteredPlaces = places.filter { place in
                place.title.lowercased().contains(searchText.lowercased()) ||
                place.subtitle.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func resetSearch() {
        isSearchActive = false
        filteredPlaces = places
    }
}
