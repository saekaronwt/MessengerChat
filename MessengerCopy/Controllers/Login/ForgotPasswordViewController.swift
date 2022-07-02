//
//  ForgotPasswordViewController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 30/06/22.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var viewHeaderCorner: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornersForgotPassword()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButton(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty else {
            self.showAlertCancelError("Woops", message: "Ingrese el campo correctamente", accept: "OK")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error != nil else {
                self.showAlertCancelError("Send Password", message: "Observer message gmail", accept: "OK")
                return
            }
        }
    }
    
    private func cornersForgotPassword(){
        emailViewCorner.layer.cornerRadius = 15
        viewHeaderCorner.roundedCorners(corners: [.bottomLeft, .bottomRight], radius: 70)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
