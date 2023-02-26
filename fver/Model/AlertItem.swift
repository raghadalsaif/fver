//
//  AlertItem.swift
//  fver
//
//  Created by raghad khalid alsaif on 06/08/1444 AH.
//

import SwiftUI


struct AlertItem : Identifiable{
    let id = UUID()
    var isForQuit = false
    var title : Text
    var message : Text
    var buttonTitle : Text
    
}


struct AlertContext{
    
    static let youWin = AlertItem(title: Text("you Win!"), message: Text( "you are good at this game!"), buttonTitle: Text("Rematch"))
    
    static let youLost = AlertItem(title: Text("you lost!"), message: Text( "try Rematch!"), buttonTitle: Text("Rematch"))
    
    
    static let draw = AlertItem(title: Text("Drow!"), message: Text("that was cool!"), buttonTitle: Text("Rematch"))
    
    static let quit = AlertItem(isForQuit: true, title: Text("gameOver!"), message: Text("Othe playr left."), buttonTitle: Text("Quit"))
    
    
    
    
    
}
