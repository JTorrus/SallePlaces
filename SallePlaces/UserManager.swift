//
//  UserManager.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class UserManager: UserDAO {
    func userExistsWithCorrectInfo(_ database: FMDatabase, userEmail: String, userPassword: String) -> Bool {
        var exists: Bool = false
        
        if database.open() {
            let sentence = "SELECT * FROM user WHERE email = ? AND password = ?"
            let data: Array = [userEmail, userPassword]
            
            if let result: FMResultSet = database.executeQuery(sentence, withArgumentsIn: data) {
                if result.next() {
                    exists = true
                }
                result.close()
                database.close()
            }
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return exists
    }
    
    func getInfo(_ database: FMDatabase, userEmail: String) -> User {
        var user: User?
        
        if database.open() {
            let sentence = "SELECT * FROM user WHERE email = ?"
            let data: Array = [userEmail]
            
            if let result: FMResultSet = database.executeQuery(sentence, withArgumentsIn: data) {
                while (result.next()) {
                    user = User(email: result.string(forColumnIndex: 0)!, name: result.string(forColumnIndex: 1)!, password: result.string(forColumnIndex: 2)!, wallet: Int(result.int(forColumnIndex: 3)), isLogged: result.bool(forColumnIndex: 4))
                }
                result.close()
                
                database.close()
            }
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return user!
    }
    
    func getCurrentUser(_ database: FMDatabase) -> User? {
        var user: User?
        
        if database.open() {
            let sentence = "SELECT * FROM user WHERE is_logged = true"
            
            if let result: FMResultSet = try? database.executeQuery(sentence, values: nil) {
                while (result.next()) {
                    user = User(email: result.string(forColumnIndex: 0)!, name: result.string(forColumnIndex: 1)!, password: result.string(forColumnIndex: 2)!, wallet: Int(result.int(forColumnIndex: 3)), isLogged: result.bool(forColumnIndex: 4))
                }
                result.close()
                
                database.close()
            }
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return user
    }
    
    func updateWallet(_ database: FMDatabase, userEmail: String, quantityToAdd: Int) -> Bool {
        var result: Bool = false
        let user: User = getInfo(database, userEmail: userEmail)
        let operation = user.wallet + quantityToAdd
        
        if database.open() {
            let sentence = "UPDATE user SET wallet = ? WHERE email = ?"
            let data: Array<Any> = [operation, userEmail]
            
            result = database.executeUpdate(sentence, withArgumentsIn: data)
            
            database.close()
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return result
    }
    
    func insert(_ database: FMDatabase, itemToInsert: Any) -> Bool {
        var result: Bool = false
        
        if database.open() {
            let sentence = "INSERT INTO user (email, name, password, wallet, is_logged) VALUES(?, ?, ?, ?, ?)"
            let data: Array = ["\((itemToInsert as! User).email)", "\((itemToInsert as! User).name)", "\((itemToInsert as! User).password)", "\((itemToInsert as! User).wallet)", "\((itemToInsert as! User).isLogged)"]
            
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
            let sentence = "DELETE FROM user WHERE email = ?"
            let data: Array = ["\((itemToDelete as! User).email)"]
            
            result = database.executeUpdate(sentence, withArgumentsIn: data)
        } else {
            print("Error opening database: \(database.lastErrorMessage())")
        }
        
        return result
    }
}
