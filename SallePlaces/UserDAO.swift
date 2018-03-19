//
//  UserDAO.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

protocol UserDAO: DAO {
    func getInfo(_ database: FMDatabase, userEmail: String) -> User
    func updateWallet(_ database: FMDatabase, userEmail: String, quantityToAdd: Int) -> Bool
}
