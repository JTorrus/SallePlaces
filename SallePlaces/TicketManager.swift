//
//  TicketManager.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class TicketManager: TicketDAO {
    func read(_ database: FMDatabase) -> Array<Ticket> {
        var tickets: Array<Ticket> = Array()
        
        if database.open() {
            let sentence = "SELECT * FROM ticket"
            
            let result: FMResultSet = try! database.executeQuery(sentence, values: nil)
            while (result.next()) {
                let ticket = Ticket(ticketId: result.string(forColumnIndex: 0)!, userEmail: result.string(forColumnIndex: 1)!, placeName: result.string(forColumnIndex: 2)!, totalPrice: Int(result.int(forColumnIndex: 3)), date: result.string(forColumnIndex: 4)!)
                tickets.append(ticket)
            }
            result.close()
            database.close()
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return tickets
    }
    
    func insert(_ database: FMDatabase, itemToInsert: Any) -> Bool {
        var result: Bool = false
        
        if database.open() {
            let sentence = "INSERT INTO ticket (ticket_id, email, name, total_price, date) VALUES(?, ?, ?, ?, ?)"
            let data: Array = ["\((itemToInsert as! Ticket).ticketId)", "\((itemToInsert as! Ticket).userEmail)", "\((itemToInsert as! Ticket).placeName)", "\((itemToInsert as! Ticket).totalPrice)", "\((itemToInsert as! Ticket).date)"]
            
            result = database.executeUpdate(sentence, withArgumentsIn: data)
            
            database.close()
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return result
    }
    
    func delete(_ database: FMDatabase, itemToDelete: Any) -> Bool {
        var result: Bool = false
        
        if database.open() {
            let sentence = "DELETE FROM ticket WHERE ticket_id = ?"
            let data: Array = ["\((itemToDelete as! Ticket).ticketId)"]
            
            result = database.executeUpdate(sentence, withArgumentsIn: data)
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return result
    }
}
