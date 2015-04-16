//
//  CBonsai.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 3/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//


import Foundation
import UIKit

class CBonsai {
    var id: String!
    var name: String!
    var specie: String!
    var style: String!
    var age: Int!
    var price: Double!
    var height: String!
    var trunkWidth: String!
    var photos: String!
//    var datePlanted: String!
//    var source: String!
//    var dateAcquired: String!
//    var pot: String!
    
    init(id: String, name: String, specie: String, photos: String) {
        self.id = id
        self.name = name
        self.specie = specie
        self.photos = photos //only one
    }
    
    init(newBonsaiVariables: [String]) {
        self.name = newBonsaiVariables[0]
        self.specie = newBonsaiVariables[1]
        self.age = newBonsaiVariables[2].toInt()
        self.price = parseToDouble(newBonsaiVariables[3])
        self.height = newBonsaiVariables[4]
        self.trunkWidth = newBonsaiVariables[5]
        
//        self.style = newBonsaiVariables[2]
//        self.datePlanted = newBonsaiVariables[3]
//        self.source = newBonsaiVariables[5]
//        self.dateAcquired = newBonsaiVariables[6]
//        self.photos = getAllImages(photos)
//        self.pot = newBonsaiVariables[X]
    }

    
    private func getAllImages(str_images: [String])->[UIImage]
    {
        var allImages:[UIImage]!
        for image in str_images {
            allImages.append(UIImage(named: image)!)
        }
        return allImages
    }
    
    private func parseToDouble(value: String)->Double {
        return (value as NSString).doubleValue
    }
    
    
}
