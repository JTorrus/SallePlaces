//
//  DAOFactory.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class DAOFactory {
    class func createUserManager() -> UserDAO {
        return UserManager()
    }
    
    class func createPlaceManager() -> PlaceDAO {
        return PlaceManager()
    }
    
    class func createTicketManager() -> TicketDAO {
        return TicketManager()
    }
}
