//
//  ProfileViewController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 30/06/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ViewContainer: UIView!
    @IBOutlet weak var RadiusDescription: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewContainer.applyGradient();
    }

}
