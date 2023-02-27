//
//  ContentView.swift
//  fver
//
//  Created by raghad khalid alsaif on 04/08/1444 AH.
//

import SwiftUI

struct HometView: View {
   
    @StateObject var viewmodel = HomeViewModel()
    @State var ofline : Bool = false
    
    var body: some View {
        VStack {
            
            Button{
                viewmodel.isGameViewPresentded = true
            }label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("XOBoard"))
                        .frame(width: 300 , height: 50)
                    Text("play Ofline")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    
                }}
                
            Button{
                viewmodel.isGameViewPresentded = true
            }label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("Orange"))
                        .frame(width: 300 , height: 50)
                    Text("play Online")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    
                }
                
            }
        }
        .fullScreenCover(isPresented: $viewmodel.isGameViewPresentded ) {
            GameView(viewModel: GmaeViewModel())
        }
        
        .fullScreenCover(isPresented: $ofline ) {
            GameView(viewModel: GmaeViewModel())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HometView()
    }
}
