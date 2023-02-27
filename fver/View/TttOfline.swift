//
//  TttOfline.swift
//  fver
//
//  Created by raghad khalid alsaif on 07/08/1444 AH.
//

import SwiftUI

struct TttOfline: View {
    var body: some View {
        VStack{
            Image("Image")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 400, height:500)
          
            Text("wite for upcoming updates!")
                .font(.largeTitle)
            
            
        }}
}

struct TttOfline_Previews: PreviewProvider {
    static var previews: some View {
        TttOfline()
    }
}
