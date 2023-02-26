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
                    viewModel.quitGame()
                }label: {
                    Text("Quit")
                }
                //
                if viewModel.game?.player2Id == ""{
                    LodingView()
                }
              
                Spacer()
                
                VStack{
                    
                    LazyVGrid(columns: viewModel.colums
                              , spacing: 5) {
                        ForEach(0..<9){ i in
                         
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray.opacity(0.7))
                                    .frame(width: geometry.size.width/3 - 15)
                                PlayerIndicatorView(systemimagename: viewModel.game?.moves[i]?.indicater ?? "applelogo")
                                    
                            }.onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                            
                            
                        }
                    }
                }.disabled(viewModel.checkForGameBoardStatus())
                 .padding()
                 .alert(item: $viewModel.alertItem) { aleryItem in
                     
                        aleryItem.isForQuit ?
                        
                        Alert(title: aleryItem.title, message: aleryItem.message, dismissButton: .destructive(aleryItem.buttonTitle, action:{
                            self.mode.wrappedValue.dismiss()
                            viewModel.quitGame()
                        }))
                        
                        : Alert(title: aleryItem.title,message: aleryItem.message, primaryButton: .default(aleryItem.buttonTitle, action: {
                            //reset the game
                            viewModel.restGame()
                        }), secondaryButton: .destructive(Text("Quit"), action: {
                            self.mode.wrappedValue.dismiss()
                            viewModel.quitGame()
                        }))
                    }
                
            }
        }
        .onAppear {
            viewModel.getTheGame()
        }
       
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GmaeViewModel())
    }
}
