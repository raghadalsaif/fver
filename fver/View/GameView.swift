//
//  GameView.swift
//  fver
//
//  Created by raghad khalid alsaif on 04/08/1444 AH.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel:  GmaeViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                Text("waiting for the player")
                Button{
                   // mode.wrappedValue.dismiss() or
                    dismiss()
                }label: {
                    Text("Quit")
                }
                //
               // LodingView()
                Spacer()
                
                VStack{
                    
                    LazyVGrid(columns: viewModel.colums
                              , spacing: 5) {
                        ForEach(0..<9){ i in
                         
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray.opacity(0.7))
                                    .frame(width: geometry.size.width/3 - 15)
                                PlayerIndicatorView(systemimagename: viewModel.game.moves[i]?.indicater ?? "applelogo")
                                    
                            }.onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
       
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GmaeViewModel())
    }
}
