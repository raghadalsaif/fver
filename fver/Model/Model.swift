//
//  Model.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift

struct Move: Codable {
    let isPlayer1 : Bool
    var boardIndex : Int
    
    var indicater : String {
        return isPlayer1 ? "xmark" : "circle"
    }
    
}

struct Game : Codable {
    
    let id : String
    var player1Id : String
    var player2Id : String
    
    // we need to block the player, the one that is not his turn to play
    var blockMoveForPlayerId: String
   // depending on the player idea if the player ID one he is the winner he will receive a notification of a one message and if he loses he will receive in a lose message
    var winningPlayerId : String
    
    var rematchPlayerId: [String]
    
    
    var moves : [Move?]
    
}

//struct Session: Codable {
//    @DocumentID var id: String? = ""
//    var player1: DocumentReference
//    var player2: DocumentReference?
//    var isGameOver: Bool = false
//    var gameRef: DocumentReference
//    var winner: String
//    }


//func a(){
//    let newUser = User(id: <#T##String#>, nickname: <#T##String#>, gender: <#T##String#>)
//    let newUserRef = Firestore.firestore().collection("Users").document("asdc123")
//    try? newUser.setData(from: newUser)
//    let session = Session(player1: Firestore.firestore().collection("Users").document("asdc123"), gameRef: <#T##DocumentReference#>, winner: <#T##String#>)
//}

