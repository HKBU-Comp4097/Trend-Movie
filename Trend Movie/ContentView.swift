//
//  ContentView.swift
//  Trend Movie
//
//  Created by Wesley chin on 4/12/2020.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Today")
                    }
            }
            .tag(0)
            
            MovieListViewComing()
                .tabItem {
                    VStack{
                        Image(systemName: "safari.fill")
                        Text("Explore")
                    }
                }
            
            
            MovieSearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .tag(1)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
