//
//  PlacesViewController.swift
//  SallePlaces
//
//  Created by Alumne on 15/3/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {

    var places: PlaceManager = PlaceManager()
    var database: FMDatabase = DbSingleton.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.read(database).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place_cell", for: indexPath)
        let place = places.read(database)[indexPath.row]
        
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.location
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let place = segue.destination as? SinglePlaceViewController {
            place.singlePlace = places.read(database)[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

