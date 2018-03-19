//
//  TicketDAO.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

protocol TicketDAO: DAO {
    func read(_ database: FMDatabase) -> Array<Ticket>
}
