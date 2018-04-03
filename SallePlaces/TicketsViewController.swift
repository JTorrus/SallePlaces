//
//  TicketsViewController.swift
//  SallePlaces
//
//  Created by Alumne on 15/3/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class TicketsViewController: UITableViewController {
    var tickets: TicketManager = DAOFactory.createTicketManager() as! TicketManager
    var users: UserManager = DAOFactory.createUserManager() as! UserManager
    var database: FMDatabase = DbSingleton.getInstance()
    var arrayOfTickets: Array<Ticket> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfTickets = tickets.read(database, userEmail: users.getCurrentUser(database).email)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrayOfTickets = tickets.read(database, userEmail: users.getCurrentUser(database).email)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTickets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticket_cell", for: indexPath)
        let ticket = arrayOfTickets[indexPath.row]
        
        cell.textLabel?.text = ticket.placeName
        cell.detailTextLabel?.text = ticket.date
        
        return cell
    }
}
