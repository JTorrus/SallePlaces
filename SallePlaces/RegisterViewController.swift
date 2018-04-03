//
//  RegisterViewController.swift
//  SallePlaces
//
//  Created by Javier Torrus on 19/03/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textName: UITextField!
    
    var database: FMDatabase = DbSingleton.getInstance()
    let userManager: UserManager = DAOFactory.createUserManager() as! UserManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_reg" {
            if textEmail.text != "" && textPassword.text != "" && textName.text != "" {
                let newUser: User = User(email: textEmail.text!, name: textName.text!, password: textPassword.text!, wallet: 1000, isLogged: true)
                let result = userManager.insert(database, itemToInsert: newUser)
                
                if !result {
                    let alert = UIAlertController(title: "Error", message: "El correo que has introducido ya está en uso.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Aviso", message: "Debes rellenar todos los datos para poder registrarte", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
