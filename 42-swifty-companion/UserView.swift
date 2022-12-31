//
//  UserView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 22/12/2022.
//

import SwiftUI

struct UserView: View {
    var userInfos : user?
    var body: some View {
        ZStack{
            Color("Primary").ignoresSafeArea()
            VStack{
                AsyncImage(url: URL(string: (userInfos!.image.link))) { Image in
                    Image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .shadow(color: Color("Shadow"), radius: 30, x:0, y: 0)
                } placeholder: {
                    Image("avatar")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                }
                Text(userInfos!.displayname)
                    .font(.system(size: 27, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                Text("(\(userInfos!.login))")
                    .font(.system(size: 25, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                HStack(alignment: .center, spacing: 40.0){
                    HStack{
                        Text("Wallets")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.wallet))
                            .foregroundColor(Color.yellow)
                    }
                    HStack{
                        Text("Corr. points")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.correction_point))
                            .foregroundColor(Color.yellow)
                    }
                }
                .padding(.top)
                ScrollView(.vertical){
                    VStack (spacing: 5){
                        ForEach((self.userInfos!.projects_users), id : \.id) { project in
                            ProjectView(project: project)
                        }
                    }
                }
            }.padding()
        }
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
