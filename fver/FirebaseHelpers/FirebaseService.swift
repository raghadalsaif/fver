//
//  FirebaseService.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

final class FirebaseService: ObservableObject{
    
    static let shared = FirebaseService()
    
    @Published var game : Game!
    
    init() {}
    
    
   
    func createOnlineGame(){
        //save the game online
    }
    

    // join a ready session for game
    func startGame(with userId: String){
        
        //check if there is game to join, if no, we create new game. if yes, we will join and start listening for any changes in the game
        FirebaseReference(.Game).whereField("player2Id", isEqualTo: "").whereField("player1Id", isNotEqualTo: userId).getDocuments { snap, error in
            if error != nil{
                print("erorr start game", error?.localizedDescription)
                //create new game
                self.createNewGame(with: userId)
                return
            }
            
            if let gameData = snap?.documents.first{
                self.game = try? gameData.data(as: Game.self)
                self.game.player2Id = userId
                self.game.blockMoveForPlayerId = userId
                self.updateGame(self.game)
                //lesining for all the changes
                self.listenForGameChanges()
            }else{
                self.createNewGame(with: userId)
            }
        }
    }
    
    // listen for the changes in the game session
    func listenForGameChanges(){}
    
    // this function will create a new game if there is no games
    func createNewGame(with userId: String){
        // create game object
    }
    
    func updateGame(_ game: Game){}
    
    // to quit the game
    func quiteTheGame(){}
    
}
