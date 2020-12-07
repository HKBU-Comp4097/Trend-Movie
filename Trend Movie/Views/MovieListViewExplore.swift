import SwiftUI

struct MovieListViewExplore: View {
    
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        NavigationView {
            List {

                Group {
                    if upcomingState.movies != nil {
                        MoviePosterCarouselView(title: "Upcoming", movies: upcomingState.movies!)
                    } else {
                        LoadingView(isLoading: self.upcomingState.isLoading, error: self.upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                

                
                Group {
                    if popularState.movies != nil {
                        MoviePosterCarouselView(title: "Most view", movies: popularState.movies!)

                    } else {
                        LoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))

            }
            .navigationBarTitle("Explore more")
        }
        .onAppear {
            self.upcomingState.loadMovies(with: .upcoming)
            self.popularState.loadMovies(with: .popular)
        }
        
    }
}

struct MovieListViewExplore_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

