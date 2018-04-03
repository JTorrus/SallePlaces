//
//  SinglePlaceViewController.swift
//  SallePlaces
//
//  Created by Javier Torrus on 03/04/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class SinglePlaceViewController: UIViewController {
    var singlePlace: Place?
    var ticketManager: TicketManager = TicketManager()
    var userManager: UserManager = UserManager()
    var database: FMDatabase = DbSingleton.getInstance()

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeUbication: UILabel!
    @IBOutlet weak var placeSchedule: UILabel!
    @IBOutlet weak var placeDescription: UITextView!
    @IBOutlet weak var placePrice: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeName?.text = singlePlace?.name
        placeUbication?.text = singlePlace?.location
        placeSchedule?.text = singlePlace?.schedule
        placeDescription?.text = singlePlace?.description
        placePrice.setTitle(String(describing: "Consigue un ticket por \(singlePlace!.price)€"), for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionPerformed(_ sender: UIButton) {
        let buyConfirmation = UIAlertController(title: "Compra de ticket", message: "Estás seguro/a de que quieres comprar una entrada para \(String(describing: singlePlace!.name))", preferredStyle: UIAlertControllerStyle.alert)
        
        buyConfirmation.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let userToBuy: User = self.userManager.getInfo(self.database, userEmail: "test@gmail.com")

            if userToBuy.wallet >= self.singlePlace!.price {                
                if self.userManager.updateWallet(self.database, userEmail: userToBuy.email, quantityToAdd: self.singlePlace!.price * (-1)) {
                    let alert = UIAlertController(title: "Compra realizada con éxito", message: "Se ha generado tu ticket, lo podrás consultar en el apartado de Tickets", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error en la compra", message: "Ha habido un problema a la hora de realizar la compra", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Fondos insuficientes", message: "No tienes fondos suficientes para comprar esta entrada", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }))
        
        buyConfirmation.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(buyConfirmation, animated: true, completion: nil)
    }
}
