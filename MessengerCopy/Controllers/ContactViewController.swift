//
//  ViewController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 30/06/22.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var viewSearchContact: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var RoundProfileImage: UIImageView!
    
    @IBOutlet weak var RoundImageBackgPerson: UIImageView!
    @IBOutlet weak var RoundImageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornersContact()
        
    }

    func cornersContact(){
        viewSearchContact.layer.cornerRadius = 12;
        viewContent.roundedCorners(corners: [.topLeft, .topRight], radius: 25)
        RoundProfileImage.layer.cornerRadius = 28;
        RoundImageProfile.layer.cornerRadius = 30;
        RoundImageBackgPerson.layer.cornerRadius = 15;
    }
}

