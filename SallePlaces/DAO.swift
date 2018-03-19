//
//  DAO.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

protocol DAO {
    func insert(_ database: FMDatabase, itemToInsert: AnyObject) -> Bool
    func delete(_ database: FMDatabase, itemToDelete: AnyObject) -> Bool
}
