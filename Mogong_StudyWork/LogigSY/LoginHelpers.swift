//
//  LoginHelpers.swift
//  Mogong_StudyWork
//
//  Created by 박서연 on 2023/07/06.
//

import SwiftUI

struct SignInButton: View {
    var body: some View {
        Text("Sign in")
            .fontWeight(.bold)
            .frame(width: 360, height: 50)
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
    }
}

struct RemoveId: View {
    @Binding var id: String
    var body: some View {
        HStack {
            Spacer()
            if !id.isEmpty {
                Button {
                    id = "" // Clear the text field when the button is tapped
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }.padding(.trailing, 9)
            }
        }
    }
}

struct RemovePassword: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack {
            Spacer()
            if !password.isEmpty {
                Button {
                    password = "" // Clear the text field when the button is tapped
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }.padding(.trailing, 9)
            }
        }
    }
}
