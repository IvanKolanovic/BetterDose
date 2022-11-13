//
//  RegisterView.swift
//  BetterDose
//
//  Created by bit4bytes on 13.11.2022..
//

import SwiftUI

struct RegisterView: View {
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPass: String = ""
    @State var terms: Bool = false


    
    var body: some View{
        VStack{
            Image("betterDose")
            Text("REGISTER").font(.title).padding(.top,30)
            CustomTextField(placeHolder: "Full name", value: $fullName, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Email", value: $email, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Password",value: $password, isSecured: true, lineColor: .black, width: 2).padding(.bottom,20)
            CustomTextField(placeHolder: "Repeat password",value: $repeatPass, isSecured: true, lineColor: .black, width: 2).padding(.bottom,30)
            HStack{
                CustomCheckBox(checked: $terms)
                Text("I agree to the terms").font(.headline).foregroundColor(Color("betterRed"))
            }
            
            Button {} label: {
                Text("Register")
                    .frame(maxWidth: 300,maxHeight: 50)
            }
            }
            .buttonStyle(.borderedProminent).tint(Color("betterRed")).padding(.top,30)
            
        }
    }

