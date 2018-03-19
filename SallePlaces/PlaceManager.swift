//
//  PlaceManager.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class PlaceManager: PlaceDAO {
    func read(_ database: FMDatabase) -> Array<Place> {
        var places: Array<Place> = Array()
        
        if database.open() {
            let sentence = "SELECT * FROM place"
            
            let result: FMResultSet = try! database.executeQuery(sentence, values: nil)
            while (result.next()) {
                let place = Place(name: result.string(forColumnIndex: 0)!, location: result.string(forColumnIndex: 1)!, schedule: result.string(forColumnIndex: 2)!, price: Int(result.int(forColumnIndex: 3)), description: result.string(forColumnIndex: 4)!)
                places.append(place)
            }
            result.close()
            database.close()
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return places
    }
}
