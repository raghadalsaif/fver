//
//  PlayerIndicatorView.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import SwiftUI


struct PlayerIndicatorView: View {
    var systemimagename : String
    var body: some View {
        Image(systemName: systemimagename)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
            .opacity(systemimagename == "applelogo" ? 0 : 1)
    }
}

struct PlayerIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIndicatorView(systemimagename: "applelogo")
    }
}
