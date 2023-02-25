//
//  Model.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import Foundation

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
