//
//  LoginViewController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 30/06/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var passwordViewCorner: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornersLogin()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateCurrentUser()
    }
    
    private func validateCurrentUser(){
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactIdentifier") as! ContactViewController
        //let nav = UINavigationController(rootViewController: vc)
        //nav.modalPresentationStyle = .fullScreen
        //self.present(nav, animated: true, completion: nil)
    
        if Auth.auth().currentUser != nil {
            let dashboard = self.storyboard?.instantiateViewController(withIdentifier: "ContactIdentifier") as! ContactViewController
            self.navigationController?.pushViewController(dashboard, animated: true)
        }
    }
    
    private func cornersLogin(){
        emailViewCorner.layer.cornerRadius = 15;
        passwordViewCorner.layer.cornerRadius = 15;
        containerView.roundedCorners(corners: .topLeft, radius: 100)
    }
    
    
    @IBAction func signinButton(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            self.showAlertCancelError("Woops", message: "Por favor rellene todos los campos correctamente", accept: "OK")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.showAlertCancelError("Woops", message: "Datos incorrectos", accept: "OK")
                return
            }
            let vc = LoginViewController()
            strongSelf.navigationController?.pushViewController(vc, animated: true)
            //self.showAlertCancelError("Congratulations", message: "User Logged: \(data.user.email ?? "not found")", accept: "OK")
        }
        
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
