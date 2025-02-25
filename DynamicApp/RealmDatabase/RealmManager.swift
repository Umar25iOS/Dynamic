//
//  RealmManager.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//
import RealmSwift

class RealmManager {
    static let shared = RealmManager()

    private init() {}

    private var schemaVersion: UInt64 {
        return 2
    }

    // Realm Configuration with Migration Handling
    private var realm: Realm {
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: Post.className()) { _, newObject in
                        newObject?["userId"] = 0  // Default value for existing records
                    }
                }
            }
        )
        return try! Realm(configuration: config)
    }

    // Save a post to Realm
    func save(post: Post) {
        try! realm.write {
            realm.add(post, update: .modified)
        }
    }

    // Get all posts from Realm
    func getPosts() -> [Post] {
        return Array(realm.objects(Post.self))
    }

    // Toggle the favorite status of a post
    func toggleFavorite(for post: Post) {
        try! realm.write {
            post.isFavorite.toggle()
        }
    }

    // Get favorite posts
    func getFavoritePosts() -> [Post] {
        return Array(realm.objects(Post.self).filter("isFavorite == true"))
    }

    // Delete a post from favorites
    func deletePostFromFavorites(post: Post) {
        try! realm.write {
            post.isFavorite = false
        }
    }
}
