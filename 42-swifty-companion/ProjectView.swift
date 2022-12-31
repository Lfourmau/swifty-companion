//
//  ProjectView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 29/12/2022.
//

import SwiftUI

struct ProjectView: View {
    var project : projectInfo
    var body: some View {
        ZStack {
            HStack{
                Text(project.project.name).foregroundColor(Color("Secondary")).padding([.leading])
                Spacer()
            }
            HStack{
                Text(project.status).foregroundColor(Color("Secondary"))
                
            }
            HStack{
                Spacer()
                Text(project.final_mark != nil ? String(project.final_mark!) : "--").foregroundColor(Color(.green)).padding([.trailing])
            }
            .foregroundColor(Color(.green))
        }.padding(.bottom, 20)
    }
}

//struct ProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectView()
//    }
//}
