//
//  SkillView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 04/01/2023.
//

import SwiftUI

struct SkillView: View {
    var skillInfo : skill
    var body: some View {
        GridRow{
            Text(skillInfo.name).foregroundColor(Color("Secondary")).gridColumnAlignment(.leading)
            ProgressView(value: skillInfo.level * 0.1).tint(Color("Numbers"))
            Text(String(skillInfo.level)).foregroundColor(Color("Secondary")).gridColumnAlignment(.leading)
        }
    }
}

//struct SkillView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillView()
//    }
//}
