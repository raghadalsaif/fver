//
//  GameNotifications.swift
//  fver
//
//  Created by raghad khalid alsaif on 06/08/1444 AH.
//

import SwiftUI

enum GameState{
    case started
    case waitingForPlayer
    case finished
}


struct GameNotifications{
    
    static let waitingForplayer = "Waiting for player"
    static let gameHasStarted = "game has Started."
    static let gameFinished = "player left the game"
    
    
}
