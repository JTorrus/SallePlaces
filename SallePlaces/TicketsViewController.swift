//
//  TicketsViewController.swift
//  SallePlaces
//
//  Created by Alumne on 15/3/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class TicketsViewController: UITableViewController {
    var tickets: TicketManager = TicketManager()
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
        return tickets.read(database).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
