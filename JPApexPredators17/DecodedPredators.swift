//
//  DecodedPredators.swift
//  JPApexPredators17
//
//  Created by Morgyn Peay on 6/11/24.
//

import SwiftUI

class DecodedPredators {
    var defaultAllPredators: [Predator] = []
    var predators: [Predator] = []
    
    init() {
        decodePredatorData()
    }
    
    func decodePredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                defaultAllPredators = try decoder.decode([Predator].self, from: data)
                predators = defaultAllPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchText: String) -> [Predator] {
        if searchText.isEmpty {
            return predators
        } else {
            return predators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        predators.sort { predatorOne, predatorTwo in
            if alphabetical {
                predatorOne.name < predatorTwo.name
            } else {
                predatorOne.id < predatorTwo.id
            }
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
            predators = defaultAllPredators
        } else {
            predators = defaultAllPredators.filter { predator in
                predator.type == type
            }
        }
    }
}




