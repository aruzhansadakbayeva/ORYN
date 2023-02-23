//
//  RegistrationDetail.swift
//  BCR
//
//  Created by Aruzhan  on 15.12.2022.
//

import Foundation
struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var occupation: String
}

extension RegistrationDetails {
   static var new: RegistrationDetails {
        RegistrationDetails( email: "",password: "", firstName: "", lastName: "", occupation: "")
    
    }
}
