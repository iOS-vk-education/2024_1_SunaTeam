//
//  SearchPlaceViewModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 15.12.2024.
//
import Foundation

class SearchPlacesViewModel {
    
    @Published private(set) var places: [PlaceModel] = [
        PlaceModel(title: "Niladri Reservoir", subtitle: "Tekergat, Sunamganj", imageName: "FirstPlace"),
        PlaceModel(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "SecondPlace"),
        PlaceModel(title: "Aonang Villa Resort", subtitle: "Bastola, Islampur", imageName: "ThirdPlace"),
        PlaceModel(title: "Rangauti Resort", subtitle: "Sylhet, Airport Road", imageName: "FourthPlace"),
        PlaceModel(title: "Kachura Resort", subtitle: "Vellima, Island", imageName: "FifthPlace"),
        PlaceModel(title: "Shakardu Resort", subtitle: "Shakartu, Pakistan", imageName: "SixthPlace")
    ]
    
    @Published private(set) var filteredPlaces: [PlaceModel] = []
    @Published var isSearchActive: Bool = false
    
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
