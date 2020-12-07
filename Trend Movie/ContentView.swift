//
//  ContentView.swift
//  Trend Movie
//
//  Created by Wesley chin on 4/12/2020.
//


import SwiftUI

struct ContentView: View {
    @AppStorage("status") var logged = false
    var body: some View {
        NavigationView{
            if logged{
                TabView {
                    MovieListView()
                        .tabItem {
                            VStack {
                                Image(systemName: "tv")
                                Text("Today")
                            }
                    }
                
                    
                    MovieListViewExplore()
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
                    
                    
                }
            }
            else{
                Login()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
