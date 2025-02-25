//
//  Post.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 17/02/25.
//
import Foundation
import RealmSwift

class Post: Object, Identifiable, Decodable {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userId: Int  
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var isFavorite: Bool = false  // New property for favorite status

    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case id, userId, title, body
    }
}
