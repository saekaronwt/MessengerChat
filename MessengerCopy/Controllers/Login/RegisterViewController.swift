//
//  RegisterViewController.swift
//  MessengerCopy
//
//  Created by Paul Torres on 30/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftUI

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameViewCorner: UIView!
    @IBOutlet weak var lastnameViewCorner: UIView!
    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var passwordViewCorner: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornersRegister()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToPickerImage(_ sender: Any) {
        presentPhotoActionSheet()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let name = nameField.text, let lastname = lastnameField.text, let email = emailField.text, let password = passwordField.text,
              !name.isEmpty, !lastname.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            self.showAlertCancelError("Woops", message: "Por favor rellene todos los campos correctamente", accept: "OK")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let result = authDataResult, error == nil else {
                self.showAlertCancelError("Woops", message: "Datos incorrectos", accept: "OK")
                return
            }
            
            let chatUser = ChatAppUser(id: result.user.uid,
                                          firstName: name,
                                          lastName: lastname,
                                          emailAdress: email,
                                          password: password,
                                       profilePicture: "\(result.user.uid)_picture_image.png")
            
            DatabaseUser.shared.insertUser(with: chatUser) { success in
                if success {
                    guard let image = self.imageProfile.image,
                          let data = image.pngData() else {
                        return
                    }
                    let fileName = chatUser.profilePictureFileName
                    StorageManager.shared.uploadPorfilePicture(with: data, fileName: fileName, completion: { result in
                        switch result {
                            case .success(let downloadUrl):
                            UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case .failure(let error):
                                print("Storage manager error \(error)")
                        }
                    })
                }
            }
            
            let alert = UIAlertController(title: "Congratulations", message: "User created", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
            //self.showAlertCancelError("Congratulations", message: "User created", accept: "OK")
        }
    }
    
    func cornersRegister(){
        nameViewCorner.layer.cornerRadius = 15
        lastnameViewCorner.layer.cornerRadius = 15
        emailViewCorner.layer.cornerRadius = 15
        passwordViewCorner.layer.cornerRadius = 15
        imageProfile.layer.cornerRadius = 50
        imageProfile.layer.borderWidth = 10
        imageProfile.layer.borderColor = CGColor.init(red: 140, green: 10, blue: 120, alpha: 1)
        imageProfile.isUserInteractionEnabled = true
        viewContainer.roundedCorners(corners: .topRight, radius: 100)
        
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile picture", message: "How wowuld you like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.presentPhotoPicker()
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func presentPhotoPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        self.imageProfile.image = selectedImage
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
