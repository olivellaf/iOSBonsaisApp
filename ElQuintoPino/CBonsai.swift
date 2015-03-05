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
    
    private var name:String!
    private var photos:[UIImage]!
    private var specie:String!
    private var style:String?
    private var datePlanted:String?
    private var age:Int!
    private var source:String!
    private var dateAcquired:String!
    private var price:Double!
    private var pot:String!
    private var height:String!
    private var trunkWidth:String!
    
    init(name:String, photos: [String], specie: String, style:String, datePlanted:String, age:Int, source:String, dateAcquired:String, price:Double, pot:String, height:String, trunkWidth:String) {
        self.name = name
        self.photos = getAllImages(photos)
        self.specie = specie
        self.style = style
        self.datePlanted = datePlanted
        self.age = age
        self.source = source
        self.dateAcquired = dateAcquired
        self.price = price
        self.pot = pot
        self.height = height
        self.trunkWidth = trunkWidth
    }
    
    init(name: String, photo: UIImage, specie:String, age:Int, price:Double) {
//        self(name, 
    }

    
    private func getAllImages(str_images: [String])->[UIImage] {
        var allImages:[UIImage]!
        for image in str_images {
            allImages.append(UIImage(named: image)!)
        }
        return allImages
    }
}
