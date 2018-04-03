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
    }
}
