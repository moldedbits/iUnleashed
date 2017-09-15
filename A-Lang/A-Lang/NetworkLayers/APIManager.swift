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
    
    static let defaultInstance = APIManager()
    
    var ref = Database.database().reference()
    var remoteConfig: RemoteConfig!
    fileprivate var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    
    func getCategories(completion: (([Category]) -> ())? = nil) {
        ref.child(Child.categories.rawValue).observe(.value) { snapshot in
            
            var categories: [Category] = []
            guard let data = snapshot.value as? [String: AnyObject] else {
                return
            }
            for value in data.values {
                guard let categoryName = (value as? [String : String])?.values.first else { continue }
                
                let categoryData: Category = Category(name: categoryName)
                categories.append(categoryData)
            }
            completion?(categories)
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


