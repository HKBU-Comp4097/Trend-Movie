//
//  SignUp.swift
//  Trend Movie
//
//  Created by Wesley chin on 10/12/2020.
//

import SwiftUI
import Firebase

struct SignUp: View {
    @State private var emailString = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        
            VStack {
                HStack{
                    VStack(alignment: .leading, spacing: 12, content: {
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Hello, nice to meet you!")
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
                    TextField("Email", text: $emailString)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(emailString == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack(){
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                    
                }
                .padding()
                .background(Color.white.opacity(password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15){
                    Button(action: {
                        self.addUserToServer()
                    })
                    {
                        Text("Sign up now")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color("blue"))
                            .clipShape(Capsule())
                    }.padding()
                        .alert(isPresented: $showAlert) {
                            return Alert(title: Text(alertMessage))
                        }
                    }
                .padding(.top)
            }
    }

    func addUserToServer() {
        Auth.auth().createUser(withEmail: emailString, password: password) { authResult, error in

            if error != nil {
                self.alertMessage = error!.localizedDescription
            }else {
                self.alertMessage = "\(authResult!.user.email!) created"
                self.emailString = ""
                self.password = ""
            }
            self.showAlert = true

        }
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
