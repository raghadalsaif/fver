//
//  FirebaseService.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.


import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine



final class FirebaseService: ObservableObject{
    
    static let shared = FirebaseService()
    
    @Published var game : Game!
    
    init() { }
    
    
   
    func createOnlineGame(){
        //save the game online
        do{
            //try to save any thing in the firebase
            try FirebaseReference(.Game).document(self.game.id).setData(from: self.game)
        }catch{
            print("Error createing online game", error.localizedDescription)
        }
    }
    

    // join a ready session for game
    //done 👍🏻
    func startGame(with userId: String){
        
        //check if there is game to join, if no, we create new game. if yes, we will join and start listening for any changes in the game
        FirebaseReference(.Game).whereField("player2Id", isEqualTo: "").whereField("player1Id", isNotEqualTo: userId).getDocuments { querySnapshot, error in
            if error != nil{
                print("erorr start game", error?.localizedDescription)
                //create new game
                self.createNewGame(with: userId)
                return
            }
            
            if let gameData = querySnapshot?.documents.first{
                self.game = try? gameData.data(as: Game.self)
                self.game.player2Id = userId
                self.game.blockMoveForPlayerId = userId
                
                self.updateGame(self.game)
                //lesining for all the changes
                self.listenForGameChanges()
            } else {
                self.createNewGame(with: userId)
            }
        }
    }
    
    // listen for the changes in the game session
    func listenForGameChanges(){
        FirebaseReference(.Game).document(self.game.id).addSnapshotListener { documentSnapshot , error in
            print("changes received from firebase")
            
            if error != nil{
                print("Error listening to changes", error?.localizedDescription)
                return
            }
            if let snapshot = documentSnapshot {
                self.game = try? snapshot.data(as: Game.self)
            }
        }
    }
    
    
    // this function will create a new game if there is no games
    //done 👍🏻
    func createNewGame(with userId: String){
        // create game object
       print("create game for userid", userId)
        
        self.game = Game(id: UUID().uuidString, player1Id: userId, player2Id: "", blockMoveForPlayerId: userId, winningPlayerId: "", rematchPlayerId: [], moves: Array(repeating: nil, count: 9))
        
        self.createOnlineGame()
        self.listenForGameChanges()

    }
    
    
    func updateGame(_ game: Game){
        print("ubdate the game ")
        
        do{
            //try to save any thing in the firebase
            try FirebaseReference(.Game).document(game.id).setData(from: game)
        }catch{
            print("Error updating online game", error.localizedDescription)
        }

        
    }
    
    // to quit the game
    func quiteTheGame(){
        guard game != nil else {return}
        FirebaseReference(.Game).document(self.game.id).delete()
    }
    
}
