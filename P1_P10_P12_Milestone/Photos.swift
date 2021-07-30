//
//  Photos.swift
//  P1_P10_P12_Milestone
//
//  Created by Łukasz Nycz on 29/07/2021.
//

import Foundation

class Photos: Codable {
    var name:String
    var image:String
    
    init(name:String, image:String) {
        self.name = name
        self.image = image
    }
}
