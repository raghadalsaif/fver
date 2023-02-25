//
//  LodingView.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import SwiftUI

struct LodingView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground)
            // this will put the loading area on top of the screen
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
        }
    }
}

