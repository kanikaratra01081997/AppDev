//
//  PostData.swift
//  HackerNews
//
//  Created by Kanika Ratra on 30/08/20.
//  Copyright © 2020 Kanika Ratra. All rights reserved.
//

import Foundation



struct Results:Decodable{
    let hits:[Post]
    
    
    
}
struct Post:Decodable,Identifiable{
    let objectID:String
    let points:Int
    let title:String
    let url:String?
    var id:String{
        return objectID
    }
    
    
}
