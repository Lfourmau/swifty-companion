//
//  UserNotFoundView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 09/01/2023.
//

import SwiftUI

struct UserNotFoundView: View {
    var body: some View{
        ZStack{
            Color("Primary").ignoresSafeArea()
            Image("avatar")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(color: Color("LightBlue"), radius: 30, x:0, y: 0)
            Text("can't find user")
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(Color("Secondary"))
                
            }.padding()
        }
}


struct UserNotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        UserNotFoundView()
    }
}
