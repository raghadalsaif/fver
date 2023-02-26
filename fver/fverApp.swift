//
//  fverApp.swift
//  fver
//
//  Created by raghad khalid alsaif on 04/08/1444 AH.
//

import SwiftUI
import Firebase

@main
struct fverApp: App {
    
    init(){
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HometView()
        }
    }
}
