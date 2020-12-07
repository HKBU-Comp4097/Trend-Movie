import SwiftUI
import Firebase

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @AppStorage("status") var logged = false
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))


                Group {
                    if topRatedState.movies != nil {
                        MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!)
                        
                    } else {
                        LoadingView(isLoading: self.topRatedState.isLoading, error: self.topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                VStack(alignment: .center, spacing: 12){
                    
                    Text("User Logged In As \(Auth.auth().currentUser?.email ?? "")")
                        .fontWeight(.heavy)
                    
                    Text("User UID \(Auth.auth().currentUser?.uid ?? "")")
                    
                    Button(action: {
                        try! Auth.auth().signOut()
                        withAnimation{logged = false}
                    }, label: {
                        Text("LogOut")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                        
                    })
                }
                .padding(.horizontal,50)
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .navigationBarTitle("Today's Hit")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.topRatedState.loadMovies(with: .topRated)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

