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
import ObjectMapper

enum Child: String {
    case categories = "categories"
    case passages = "passages"
    case passageDetails = "passage_details"
}

class APIManager {
    
    static let shared = APIManager()
    
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
            
            for categoryData in data.values {
                guard let unwrappedData = categoryData as? [String: Any] else { continue }
                guard let category = Mapper<Category>().map(JSON: unwrappedData) else { continue }
                
                categories.append(category)
            }
            
            completion?(categories)
        }
    }
    
    func getPassages() {
        ref.child(Child.passages.rawValue).observe(.value) { snapshot in
            var categories: [Category] = []
            guard let data = snapshot.value as? [String: AnyObject] else {
                return
            }
            for key in data.keys {
                guard let value = data[key] as? [[String : AnyObject]] else { continue }
                
                let passages = Mapper<Passage>().mapArray(JSONArray: value)
                let category = Category(JSON: [:])!
                category.passages = passages
                category.name = key
                categories.append(category)
            }
        }
    }
    
    func getPassagesForCategory(_ name: String, completion: (([Passage]) -> ())? = nil) {
        ref.child(Child.passages.rawValue).child(name).observe(.value) { snapshot in
            var passages: [Passage] = []
            guard let data = snapshot.value as? [[String: AnyObject]] else {
                return
            }
            
            passages = Mapper<Passage>().mapArray(JSONArray: data)
            completion?(passages)
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


