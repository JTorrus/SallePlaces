//
//  LoginViewController.swift
//  SallePlaces
//
//  Created by Alumne on 15/3/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    var database: FMDatabase = DbSingleton.getInstance()
    let userManager: UserManager = DAOFactory.createUserManager() as! UserManager
    let databaseFileName: String = "salleplaces.db"
    var databasePath: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpDatabase()
        userManager.everybodyIsLoggedOff(database)
        print(FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.absoluteString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpDatabase() {
        let fileManager = FileManager()
        
        if let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let databaseUrl = docsDir.appendingPathComponent(databaseFileName)
            databasePath = databaseUrl.absoluteString
            
            if !fileManager.fileExists(atPath: databasePath) {
                if let sourceDatabaseUrl = Bundle.main.url(forResource: "salleplaces", withExtension: "db") {
                    do {
                        try fileManager.copyItem(at: sourceDatabaseUrl, to: databaseUrl)
                    } catch {
                        print("Error copying the database to the Document Directory")
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_log" {
            if textEmail.text != "" && textPassword.text != "" {
                if !userManager.userExistsWithCorrectInfo(database, userEmail: textEmail.text!, userPassword: textPassword.text!) {
                    let alert = UIAlertController(title: "Error", message: "El correo o contraseña que has introducido no son válidos.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if let tbvc = segue.destination as? UITabBarController {
                        if let navigationController = tbvc.viewControllers![0] as? UINavigationController {
                            if let view = navigationController.topViewController as? PlacesViewController {
                                view.currentUserEmail = textEmail.text!
                            }
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Aviso", message: "Debes rellenar todos los datos para poder iniciar sesión", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
