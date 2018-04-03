//
//  ProfileViewController.swift
//  SallePlaces
//
//  Created by Javier Torrus on 03/04/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userWallet: UILabel!
    
    var userManager: UserManager = DAOFactory.createUserManager() as! UserManager
    var database: FMDatabase = DbSingleton.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = userManager.getCurrentUser(database)
        userName.text = currentUser.name
        userEmail.text = currentUser.email
        userWallet.text = "\(currentUser.wallet)€"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = userManager.getCurrentUser(database)
        userWallet.text = "\(currentUser.wallet)€"
    }
}
