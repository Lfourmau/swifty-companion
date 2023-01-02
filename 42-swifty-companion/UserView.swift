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
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(color: Color("Shadow"), radius: 30, x:0, y: 0)
                } placeholder: {
                    Image("avatar")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(color: Color("Shadow"), radius: 30, x:0, y: 0)
                }
                Text(userInfos!.displayname)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                Text("(\(userInfos!.login))")
                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                Text("Level \(String(userInfos!.cursus_users[1].level))")
                    .font(.system(size: 15, design: .monospaced))
                    .foregroundColor(Color("Numbers"))
                    .padding(.top, 5)
                HStack(alignment: .center, spacing: 30){
                    Label(String(userInfos!.campus[0].name), systemImage: "mappin.and.ellipse")
                    HStack{
                        Text("Wallets")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.wallet))
                            .foregroundColor(Color("Numbers"))
                    }
                    HStack{
                        Text("Corr. points")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.correction_point))
                            .foregroundColor(Color("Numbers"))
                    }
                }
                .padding(.vertical)
                ScrollView(.vertical){
                    VStack (spacing: 5){
                        Grid{
                            ForEach((self.userInfos!.projects_users), id : \.id) { project in
                                    ProjectView(project: project)
                                Divider()
                            }
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
