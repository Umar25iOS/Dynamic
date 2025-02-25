//
//  HomeViewModel.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 17/02/25.
//
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK: Properties and Variables
    @Published var posts: [Post] = []
    @Published var favoritePosts: [Post] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false  // Loader state
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPosts()
        fetchFavoritePosts()
    }

    //MARK: Fetch posts and store them
    func fetchPosts() {
        isLoading = true  // Start loading
        
        NetworkManager.shared.fetchPosts()
            .sink { completion in
                DispatchQueue.main.async {
                    self.isLoading = false  // Stop loading on completion
                    switch completion {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    case .finished:
                        break
                    }
                }
            } receiveValue: { posts in
                DispatchQueue.main.async {
                    self.posts = posts
                    self.savePostsToRealm(posts: posts)
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: Save posts to Realm
    private func savePostsToRealm(posts: [Post]) {
        for post in posts {
            RealmManager.shared.save(post: post)
        }
    }

    //MARK: Fetch favorite posts from Realm
    func fetchFavoritePosts() {
        self.favoritePosts = RealmManager.shared.getFavoritePosts()
    }

    //MARK: Toggle favorite status of a post
    func toggleFavorite(for post: Post) {
        RealmManager.shared.toggleFavorite(for: post)
        fetchFavoritePosts()  // Refresh favorite posts list
    }

    //MARK: Delete post from favorites
    func deletePostFromFavorites(post: Post) {
        RealmManager.shared.deletePostFromFavorites(post: post)
        fetchFavoritePosts()  // Refresh favorite posts list
    }
}
