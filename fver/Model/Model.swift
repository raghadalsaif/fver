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
    
    var moves : [Move?]
    
}
