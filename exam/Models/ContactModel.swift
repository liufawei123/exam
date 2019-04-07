//
//  ContactModel.swift
//  exam
//
//  Created by Liu Fan Wei on 7/4/19.
//  Copyright © 2019 Liu Fan Wei. All rights reserved.
//

import Foundation

class ContactModel {
    var id :String?
    var firstName :String?
    var lastName :String?
    var email :String?
    var phone :String?
    
    var fullName :String{
        let _firstName = firstName ?? ""
        let _lastName = lastName ?? ""
        return _firstName + " " + _lastName
    }
    init() {
    }
    init(json :Dictionary<String, String>) {
        id = json["id"]
        firstName = json["firstName"]
        lastName = json["lastName"]
        phone = json["phone"]
    }
}
