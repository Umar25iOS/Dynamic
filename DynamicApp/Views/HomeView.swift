//
//  HomeView.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//
import SwiftUI

struct HomeView: View {
    
    //MARK: Properties and Variables
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            // Posts Tab
            VStack {
                if viewModel.isLoading {
                    ProgressView(StringConstant.loadingPosts)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text("\(StringConstant.error): \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List(viewModel.posts) { post in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(post.title)
                                        .font(.headline)
                                    Text(post.body)
                                        .font(.body)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.toggleFavorite(for: post)
                                }) {
                                    Image(systemName: post.isFavorite ? "star.fill" : "star")
                                        .foregroundColor(post.isFavorite ? .yellow : .gray)
                                }
                            }
                        }
                    }
                }
            }
            .tabItem {
                Label(StringConstant.posts, systemImage: "house.fill")
            }
            
            // Favorites Tab
            List {
                ForEach(viewModel.favoritePosts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deletePostFromFavorites(post: post)
                        } label: {
                            Label(StringConstant.delete, systemImage: "trash.fill")
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let post = viewModel.favoritePosts[index]
                        viewModel.deletePostFromFavorites(post: post)
                    }
                }
            }
            .tabItem {
                Label(StringConstant.favorites, systemImage: "star.fill")
            }
        }
        .onAppear {
            viewModel.fetchPosts()
            viewModel.fetchFavoritePosts()
        }
    }
}
