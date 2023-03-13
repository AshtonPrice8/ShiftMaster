//
//  Worker.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import Foundation

struct Worker:Identifiable, Hashable{
    let id = UUID()
    var name:String
    var age:String
    var position:String
    var password = "letmein"
}

