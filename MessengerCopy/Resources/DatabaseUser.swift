//
//  DatabaseUser.swift
//  MessengerCopy
//
//  Created by Paul Torres on 1/07/22.
//

import Foundation
import FirebaseDatabase
import UIKit

final class DatabaseUser{
    static let  shared = DatabaseUser()
    
    private let database = Database.database().reference()
    
    
}
// MARK: - Account Mgmt

extension DatabaseUser {
    
    /// Inserts new user to database
    public func insertUser(with user:ChatAppUser, completion: @escaping (Bool) -> Void){
        database.child(user.id).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email_adress": user.emailAdress,
            "password": user.password,
            "profile_picture": user.profilePicture
        ], withCompletionBlock: { error, _ in
            guard error == nil else{
                print("failed ot write to database")
                return
            }
            completion(true)
        })
    }
}

struct ChatAppUser{
    let id: String
    let firstName: String
    let lastName: String
    let emailAdress: String
    let password: String
    let profilePicture: String
    
    var profilePictureFileName: String{
        //UID_profile_picture.png
        return "\(id)_picture_image.png"
    }
    //let yearsOld: Int?
    //let descriptionUser: String?
    //let languages: String?
    //let gallery: String?
}
