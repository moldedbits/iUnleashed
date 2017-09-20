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

struct Child {
    static let categories = "categories"
    static let passages = "passages"
    static let passageDetails = "passage_details"
    static let passageText = "passage_text"
    static let passageQuestions = "questions"
    static let passageSentences = "sentences"
}

class APIManager {
    
    static let shared = APIManager()
    
    var ref = Database.database().reference()
    var remoteConfig: RemoteConfig!
    fileprivate var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    
    // MARK: Providers categories and their names for Category Screen
    func getCategories(completion: (([Category]) -> ())? = nil) {
        ref.child(Child.categories).observe(.value) { snapshot in
            var categories: [Category] = []
            guard let data = snapshot.value as? [String: Any] else {
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
    
    // MARK: Providers all the basic passages information for a particular category
    func getPassagesForCategory(_ name: String, completion: (([Passage]) -> ())? = nil) {
        ref.child(Child.passages).child(name).observe(.value) { snapshot in
            var passages: [Passage] = []
            guard let data = snapshot.value as? [[String: Any]] else {
                return
            }
            
            passages = Mapper<Passage>().mapArray(JSONArray: data)
            let _ = passages.map { $0.categoryName = name }
            completion?(passages)
        }
    }
    
    // MARK: Provider pessage text based on a passage id and category name
    func getPassageText(for id: String, inCategory category: String, completion: ((BilingualText) -> ())? = nil) {
        ref.child(Child.passageDetails).child(category).child(id).child(Child.passageText).observe(.value) { snapshot in
            guard let data = snapshot.value as? [String: Any] else {
                return
            }
            
            guard let passageText = Mapper<BilingualText>().map(JSON: data) else { return }
            completion?(passageText)
        }
    }
    
    // MARK: Provider pessage text based on a passage id and category name
    func getPassageSentences(for id: String, in category: String, completion: (([BilingualText]) -> ())? = nil) {
        ref.child(Child.passageDetails).child(category).child(id).child(Child.passageSentences).observe(.value) { snapshot in
            var sentences: [BilingualText] = []
            guard let data = snapshot.value as? [[String: Any]] else {
                return
            }
            
            sentences = Mapper<BilingualText>().mapArray(JSONArray: data)
            completion?(sentences)
        }
    }
    
    // MARK: Provider pessage text based on a passage id and category name
    func getPassageQuestions(for id: String, in category: String, completion: (([Question]) -> ())? = nil) {
        ref.child(Child.passageDetails).child(category).child(id).child(Child.passageQuestions).observe(.value) { snapshot in
            var questions: [Question] = []
            guard let data = snapshot.value as? [[String: Any]] else {
                return
            }
            
            questions = Mapper<Question>().mapArray(JSONArray: data)
            completion?(questions)
        }
    }
}


