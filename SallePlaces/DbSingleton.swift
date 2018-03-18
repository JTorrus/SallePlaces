//
//  DbSingleton.swift
//  SallePlaces
//
//  Created by Javier Torrus on 18/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

private let databaseFileName: String = "salleplaces.db"
private var databasePath: String = String()
private var database: FMDatabase?

class DbSingleton {
    class func getInstance() -> FMDatabase {
        if database == nil {
            let fileManager = FileManager()
            
            if let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let databaseUrl = docsDir.appendingPathComponent(databaseFileName)
                
                databasePath = databaseUrl.absoluteString
                database = FMDatabase(path: databasePath)
            }
        }
        
        return database!
    }
}
