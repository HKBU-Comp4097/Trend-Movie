import SwiftUI
import LocalAuthentication

struct Login : View {
    
    @StateObject var LoginModel = LoginViewModel()
    // when first time user logged in via email store this for future biometric login....
    @State private var emailString = ""
    @State private var password = ""
    
    @AppStorage("status") var logged = false
    
    @State var startAnimate = false
    
    var body: some View{
        
        ZStack{
            
            VStack{
                
                Spacer(minLength: 10)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Please sign in to continue")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
                
                HStack{
                    
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("EMAIL", text: $LoginModel.email)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack{
                    
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    SecureField("PASSWORD", text: $LoginModel.password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(LoginModel.password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    
                    Button(action: LoginModel.verifyUser, label: {
                        Text("LOGIN")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("blue"))
                            .clipShape(Capsule())
                    })
                    .opacity(LoginModel.email != "" && LoginModel.password != "" ? 1 : 0.5)
                    .disabled(LoginModel.email != "" && LoginModel.password != "" ? false : true)
                    .alert(isPresented: $LoginModel.alert, content: {
                        Alert(title: Text("Error"), message: Text(LoginModel.alertMsg), dismissButton: .destructive(Text("Ok")))
                    })
                    
                    if LoginModel.getBioMetricStatus(){
                        
                        Button(action: LoginModel.authenticateUser, label: {
                            
                            // getting biometrictype...
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color("blue"))
                                .clipShape(Circle())
                        })
                    }
                }
                .padding(.top)
                

                
                // SignUp...
                
                Spacer(minLength: 0)
                
                NavigationLink(destination: SignUp()){
                    HStack(spacing: 5){
                        
                        Text("Don't have an account? ")
                            .foregroundColor(Color.white.opacity(0.6))
                        
                        Button(action: {}, label: {
                            Text("Signup")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("blue"))
                        })
                    }
                    .padding(.vertical)
                    .animation(startAnimate ? .easeOut : .none)
                }
            }
            
            if LoginModel.isLoading{
                
                Loading_Screen()
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startAnimate.toggle()
            }
        })
    }
}

