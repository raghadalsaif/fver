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
                Text(viewModel.gameNotification)
                
//                //loding view
//                if viewModel.game?.player2Id == ""{
//                    LodingView()
//                }
              
                Spacer()
                
                VStack{
                    
                    LazyVGrid(columns: viewModel.colums
                              , spacing: 5) {
                        ForEach(0..<9){ i in
                         
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.black).cornerRadius(15)
                                    .frame(width: geometry.size.width/3 - 15, height: 80)
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
                 
                Spacer()
                Button{
                   // mode.wrappedValue.dismiss() or
                    
                    dismiss()
                    viewModel.quitGame()
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Orange"))
                            .frame(width: 300 , height: 50)
                        Text("Exit Game")
                            .foregroundColor(.white)
                            .font(.title)
                        
                        
                    }
                }
                
            }.background(Color("XOBoard"))
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
