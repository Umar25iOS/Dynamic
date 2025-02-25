//
//  NetworkManager.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 17/02/25.
//
import Alamofire
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // Fetch posts
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        return AF.request(url)
            .validate()
            .publishDecodable(type: [Post].self)
            .tryMap { response in
                return try response.result.get()
            }
            .mapError { error in
                print("Error: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
