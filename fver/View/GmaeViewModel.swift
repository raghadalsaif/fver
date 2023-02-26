//
//  GmaeViewModel.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import SwiftUI
import Combine

final class GmaeViewModel: ObservableObject {
    @AppStorage("user") private var userData: Data?
    
    var colums: [GridItem] = [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible()),]
    
    @Published var game : Game? {
        didSet{
            checkIfGameIsOver()
            //check the game state
        }
    }
    @Published var currentUser : User!
    @Published var alertItem : AlertItem?
    
    private var cancellables: Set<AnyCancellable> = []
    
   
    
    private let winPatterns: Set<Set<Int>> = [   [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
    
    
    init(){
        retriveUser()
        
        if currentUser == nil{
            saveUser()
        }
        print("we have user with id:", currentUser.id)
    }
    
    
    func getTheGame(){
        //this will start the game
        FirebaseService.shared.startGame(with: currentUser.id)
        //create i var to contane all the data that will be retrive from the firebase
        FirebaseService.shared.$game
            .assign(to: \.game, on: self)
            .store(in: &cancellables)
        
    }
    
    func processPlayerMove(for position : Int){
        
        guard game != nil else{return}
        
        //check if the position is occupied
        if isSquareOcupied(in: game!.moves, forIndex: position) { return }
        
        game!.moves[position] = Move(isPlayer1: isplayerOne(), boardIndex: position)
       
        
        //block the move
        game!.blockMoveForPlayerId = currentUser.id
        
        FirebaseService.shared.updateGame(game!)
        
        
        //check for win
        if checkForWinCondition(for: isplayerOne(), in: game!.moves){
            game!.winningPlayerId = currentUser.id
            FirebaseService.shared.updateGame(game!)
            print("you have won!")
            return
        }
        
        //check for draw
        if checkForDraw(in: game!.moves){
            game!.winningPlayerId = "0"
            FirebaseService.shared.updateGame(game!)
            print("Draw!")
            return
        }
        
    }
    
    func isSquareOcupied(in moves: [Move?], forIndex index: Int) ->Bool{
        return moves.contains(where: { $0?.boardIndex == index })
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
    
    
    func quitGame(){
        FirebaseService.shared.quiteTheGame()
    }
    
    
    
    func checkForGameBoardStatus() -> Bool{
        return game != nil ? game!.blockMoveForPlayerId == currentUser.id : false
    }
    
    func isplayerOne() -> Bool{
        return game != nil ? game!.player1Id == currentUser.id : false
    }
    
    
    
    func checkIfGameIsOver(){
        alertItem = nil
        
        guard game != nil else{return}
        
        if game!.winningPlayerId == "0"{
            //draw
            alertItem = AlertContext.draw
        }else if game!.winningPlayerId != ""{
            //one of the player had win
            if game!.winningPlayerId == currentUser.id{
                //we won
                alertItem = AlertContext.youWin
            }else {
                //we lost
                alertItem = AlertContext.youLost
            }
        }
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
