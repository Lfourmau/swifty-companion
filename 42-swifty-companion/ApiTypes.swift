//
//  ApiTypes.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 09/01/2023.
//

import Foundation

struct campus : Codable{
    var id : Int
    var name : String
}
struct skill : Codable{
    var id : Int
    var name : String
    var level : Float
}
struct intraToken: Codable{
    var access_token : String
    var token_type : String
    var scope : String
    var created_at : Int
    var expires_in : Int
}

struct sizes:Codable{
    var large : String
    var medium : String
    var small : String
    var micro : String
}

struct userImage: Codable{
    var link : String
    var versions : sizes
}
struct project: Codable{
    var id : Int
    var name : String
}
struct projectInfo: Codable{
    var id : Int
    var final_mark : Int?
    var status : String
    var project : project
}

struct cursus : Codable{
    var level : Float
    var skills : [skill]
}
