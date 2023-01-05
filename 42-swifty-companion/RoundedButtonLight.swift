//
//  RoundedButtonLight.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 05/01/2023.
//

import SwiftUI

struct RoundedButtonLight: View {
    @Binding var displayProjects : Bool
    var buttonText : String
    var body: some View {
        Button(action: {
            self.displayProjects = true
        })
        {
            Text(buttonText).padding(.vertical, 7).frame(minWidth: 80)
        }.foregroundColor(Color(.white))
            .background(self.displayProjects ? Color("LightBlue") : Color("noColor")).cornerRadius(25)
            .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                    )
    }
}

//struct RoundedButtonLight_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundedButtonLight()
//    }
//}
