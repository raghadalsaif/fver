//
//  ContentView.swift
//  fver
//
//  Created by raghad khalid alsaif on 04/08/1444 AH.
//

import SwiftUI

struct HometView: View {
   
    @StateObject var viewmodel = HomeViewModel()
    
    var body: some View {
        VStack {
            Button{
                viewmodel.isGameViewPresentded = true
            }label: {
                Text("play")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .fullScreenCover(isPresented: $viewmodel.isGameViewPresentded ) {
            GameView(viewModel: GmaeViewModel())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HometView()
    }
}
