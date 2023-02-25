//
//  GmaeViewModel.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import SwiftUI

final class GmaeViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?
    
    var colums: [GridItem] = [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible()),]
    
    @Published var game = Game(id: UUID().uuidString, player1Id: "playrid1", player2Id: "playerid2", blockMoveForPlayerId: "playerid2", winningPlayerId: "", rematchPlayerId: [], moves: Array(repeating: nil, count: 9))
    
    @Published var currentUser : User!
    
    private let winPatterns: Set<Set<Int>> = [   [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
    
    
    init(){
        retriveUser()
        
        if currentUser == nil{
            saveUser()
        }
        
        print("we have user with id:", currentUser.id)
    }
    
    func processPlayerMove(for position : Int){
        
        
        
        //check if the position is occupied
        if isSquareOcupied(in: game.moves, forIndex: position) { return }
        
        game.moves[position] = Move(isPlayer1: true, boardIndex: position)
        game.blockMoveForPlayerId = "player2"
        
        //block the move
        
        
        //check for win
        if checkForWinCondition(for: true, in: game.moves){
            print("you have won!")
            return
        }
        
        //check for draw
        if checkForDraw(in: game.moves){
            print("Draw!")
            return
        }
        
    }
    
    func isSquareOcupied(in moves: [Move?], forIndex index: Int) ->Bool{
        return moves.contains (where: { $0?.boardIndex == index })
    }
    
    func checkForWinCondition(for player1: Bool, in moves: [Move?]) -> Bool{
        //remove all nils because it's useless to count the nill values
        let playerMoves = moves.compactMap{$0}.filter{ $0.isPlayer1 == player1}
        let playerPositions = Set(playerMoves.map{$0.boardIndex})
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){return true}
        
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool{
        return moves.compactMap{$0}.count == 9
    }
    
    
    //MARK: user object
    
    func saveUser(){
        
        currentUser = User()
        do{
            print("encoding user object")
            let data = try JSONEncoder().encode(currentUser)
            userData = data
        }catch{
            print("couldnt save user object")
        }
    }
    
    
    
    func retriveUser(){
        
        guard let userData = userData else {return}
        
        do{
            print("decoding user")
            currentUser = try JSONDecoder().decode(User.self, from: userData)

        }catch{
            print("no user saved")
        }
    }
    
    
    
    
    
    
    
    
    
}
