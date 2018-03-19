//
//  DAOFactory.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class DAOFactory {
    class func create(_ instanceType: Int) -> DAO {
        switch instanceType {
        case 0:
            return TicketManager()
        case 1:
            return UserManager()
        case 2:
            return PlaceManager()
        default:
            break
        }
    }
}
