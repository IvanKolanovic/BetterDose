//
//  LoginView.swift
//  BetterDose
//
//  Created by bit4bytes on 13.11.2022..
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View{
        VStack{
            Image("betterDose")
            Text("SIGN IN").font(.title).padding(.top,30)
            CustomTextField(placeHolder: "Email", value: $email, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Password",value: $password, isSecured: true, lineColor: .black, width: 2).padding(.bottom,20)
            Button {} label: {
                Text("Sign in")
                    .frame(maxWidth: 300,maxHeight: 50)
            }
            }
            .buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.bottom,20)
            
            Text("Don't have an account?").font(.subheadline)
            Text("Sign up").font(.subheadline).foregroundColor(Color("betterRed"))

        }
    }

