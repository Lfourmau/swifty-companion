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
        GridRow{
            Text(project.project.name).foregroundColor(Color("Secondary")).gridColumnAlignment(.leading)
            Text(project.status).foregroundColor(Color("Secondary")).italic().fontWeight(.thin)
            Text(project.final_mark != nil ? String(project.final_mark!) : "--").foregroundColor(Color("Numbers"))
        }
    }
}

//struct ProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectView()
//    }
//}
