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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result: Bool = true
        
        if identifier == "segue_logoff" {
            let logOffConfirmation = UIAlertController(title: "Cerrar sesión", message: "¿Estás seguro/a de que quieres cerrar sesión?", preferredStyle: UIAlertControllerStyle.alert)
            
            logOffConfirmation.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive, handler: { action in
                self.performSegue(withIdentifier: "segue_logoff", sender: self)
            }))
            logOffConfirmation.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { action in
                result = false
            }))
            
            self.present(logOffConfirmation, animated: true, completion: nil)
        }
        
        return result
    }
    
    @IBAction func actionPerformed(_ sender: Any) {
        if sender is UIButton {
            let deletionConfirmation = UIAlertController(title: "Eliminar cuenta", message: "¿Estás seguro/a de que quieres eliminar tu cuenta?", preferredStyle: UIAlertControllerStyle.alert)
            let currentUser = userManager.getCurrentUser(self.database)
            
            deletionConfirmation.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action: UIAlertAction) in
                if self.userManager.delete(self.database, itemToDelete: currentUser) {
                    let alert = UIAlertController(title: "Cuenta eliminada", message: "Se ha eliminado tu cuenta con éxito", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.performSegue(withIdentifier: "segue_del", sender: self)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Ha habido un error al eliminar tu cuenta", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }))
            deletionConfirmation.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            
            self.present(deletionConfirmation, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {}
}
