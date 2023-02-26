//
//  FirebaseRefrnce.swift
//  fver
//
//  Created by raghad khalid alsaif on 05/08/1444 AH.
//

import Foundation
import Firebase

enum FCollectionReference: String{
    case Game
    //case User
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
