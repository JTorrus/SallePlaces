//
//  FundsViewController.swift
//  SallePlaces
//
//  Created by Javier Torrus on 08/04/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class FundsViewController: UIViewController {
    @IBOutlet weak var fundsText: UITextField!
    
    var userManager: UserManager = DAOFactory.createUserManager() as! UserManager
    var database: FMDatabase = DbSingleton.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result: Bool = true
        
        if identifier == "un_add" {
            if let text = fundsText.text {
                if text != "" {
                    let quantityInt: Int = Int(text)!
                    
                    if quantityInt > 0 {
                        let currentUser = userManager.getCurrentUser(database)
                        if !userManager.updateWallet(database, userEmail: currentUser.email, quantityToAdd: Int(fundsText.text!)!) {
                            let alert = UIAlertController(title: "Error", message: "Ha habido un error a la hora de añadir fondos", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                            result = false
                        }
                    } else {
                        let alert = UIAlertController(title: "Aviso", message: "Debes añadir una cantidad mayor a 0", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        result = false
                    }
                    
                } else {
                    let alert = UIAlertController(title: "Aviso", message: "Debes añadir una cantidad", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    result = false
                }
            }
        }
        
        return result
    }
}
