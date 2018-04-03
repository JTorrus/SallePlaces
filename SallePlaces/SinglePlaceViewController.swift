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
    var ticketManager: TicketManager = DAOFactory.createTicketManager() as! TicketManager
    var userManager: UserManager = DAOFactory.createUserManager() as! UserManager
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
            let userToBuy: User = self.userManager.getCurrentUser(self.database)
            
            if userToBuy.wallet >= self.singlePlace!.price {                
                if self.userManager.updateWallet(self.database, userEmail: userToBuy.email, quantityToAdd: self.singlePlace!.price * (-1)) {
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yyyy hh:mm:ss"
                    let result = dateFormatter.string(from: date)
                    
                    let ticketIdGeneration: String = userToBuy.email + result
                    let generatedTicket: Ticket = Ticket(ticketId: ticketIdGeneration, userEmail: userToBuy.email, placeName: self.singlePlace!.name, totalPrice: self.singlePlace!.price, date: result)
                    
                    if self.ticketManager.insert(self.database, itemToInsert: generatedTicket) {
                        let alert = UIAlertController(title: "Compra realizada con éxito", message: "Se ha generado tu ticket, lo podrás consultar en el apartado de Tickets", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
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
