//
//  APIManager.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 15/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

enum Child: String {
    case categories = "categories"
    case passages = "passages"
    case passageDetails = "passage_details"
}

class APIManager {
    var ref = Database.database().reference()
    var remoteConfig: RemoteConfig!
    fileprivate var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    
    var categories: [DataSnapshot]! = []
    
    
    func getCategories() {
        ref.child(Child.categories.rawValue).observe(.value) { snapshot in
            for category in snapshot.children {
                // TODO: Map this data to category model
            }
        }
    }
    
    func getPassages() {
        ref.child(Child.passages.rawValue).observe(.value) { snapshot in
            for passage in snapshot.children {
                // TODO: Map this data to passage model
            }
        }
    }
    
    func getPassageDetails() {
        ref.child(Child.passageDetails.rawValue).observe(.value) { snapshot in
            for passageDetail in snapshot.children {
                // TODO: Map this data to passageDetails model
            }
        }
    }
}


