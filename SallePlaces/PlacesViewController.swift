//
//  PlacesViewController.swift
//  SallePlaces
//
//  Created by Alumne on 15/3/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
    var places: PlaceManager = DAOFactory.createPlaceManager() as! PlaceManager
    var database: FMDatabase = DbSingleton.getInstance()
    var arrayOfPlaces: Array<Place> = []
    var userManager: UserManager = DAOFactory.createUserManager() as! UserManager
    var currentUserEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfPlaces = places.read(database)
        userManager.updateSessionState(database, isLogged: true, userEmail: userManager.getInfo(database, userEmail: currentUserEmail!).email)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place_cell", for: indexPath)
        let place = arrayOfPlaces[indexPath.row]
        
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.location
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let place = segue.destination as? SinglePlaceViewController {
            place.singlePlace = arrayOfPlaces[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

