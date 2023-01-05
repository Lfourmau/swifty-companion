//
//  UserView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 22/12/2022.
//

import SwiftUI

struct UserView: View {
    var userInfos : user?
    @State var displayProjects : Bool = true
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
                        .shadow(color: Color("LightBlue"), radius: 30, x:0, y: 0)
                } placeholder: {
                    Image("avatar")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(color: Color("LightBlue"), radius: 30, x:0, y: 0)
                }
                Text(userInfos!.displayname)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                Text("(\(userInfos!.login))")
                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("Secondary"))
                Text("Level \(String(userInfos!.cursus_users[1].level))")
                    .font(.system(size: 15, design: .monospaced))
                    .foregroundColor(Color("LightBlue"))
                    .padding(.top, 5)
                HStack(alignment: .center, spacing: 30){
                    Label(String(userInfos!.campus[0].name), systemImage: "mappin.and.ellipse")
                    HStack{
                        Text("Wallets")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.wallet))
                            .foregroundColor(Color("LightBlue"))
                    }
                    HStack{
                        Text("Corr. points")
                            .foregroundColor(Color("Secondary"))
                        Text(String(userInfos!.correction_point))
                            .foregroundColor(Color("LightBlue"))
                    }
                }
                .padding(.vertical)
                HStack(){
                    Button(action: {
                        self.displayProjects = true
                    })
                    {
                        Text("Projects").padding(.vertical, 7).frame(minWidth: 80)
                    }.foregroundColor(Color(.white))
                        .background(self.displayProjects ? Color("LightBlue") : Color("LightBlue").opacity(0)).cornerRadius(25)
                        .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                                )
                    Spacer()
                    Button(action: {
                        self.displayProjects = false
                    }) {
                        Text("Skills").padding(.vertical, 7).frame(minWidth: 80)
                    }.foregroundColor(Color(.white))
                        .background(self.displayProjects ? Color("LightBlue").opacity(0) : Color("LightBlue")).cornerRadius(25)
                        .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                                )
                }.padding(.horizontal, 90).padding(.vertical)
                if (self.displayProjects){
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
                }
                else{
                    ScrollView(.vertical){
                        VStack (spacing: 5){
                            Grid{
                                ForEach((self.userInfos!.cursus_users[1].skills), id : \.id) { skill in
                                        SkillView(skillInfo: skill)
                                    Divider()
                                }
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
