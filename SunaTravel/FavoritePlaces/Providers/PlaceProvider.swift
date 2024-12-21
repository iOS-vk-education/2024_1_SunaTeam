//
//  PlaceProvider.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 21.12.2024.
//

protocol IPlaceProvider {
    func getModel() -> PlaceModel
}

struct ExamplePlaceProviderImpl: IPlaceProvider {
    func getModel() -> PlaceModel {
        return PlaceModel(title: "Casa Las Tirtugas", subtitle: "Av Damero, Mexico", imageName: "FirstPlace")
    }
}
