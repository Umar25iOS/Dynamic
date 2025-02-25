//
//  User.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//
import RealmSwift

class User: Object, Identifiable {
    
    @Persisted(primaryKey: true) var email: String
    //@Persisted(primaryKey: true) → Makes email unique in the database.
    //This ensures that we don’t store duplicate users.
    @Persisted var password: String

    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
