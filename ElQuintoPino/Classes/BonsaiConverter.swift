//
//  BonsaiConverter.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 13/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import Foundation

class BonsaiConverter: NSObject {
    
//    var name: String!
//    var photos: [String]!
//    var specie: String!
//    var style: String!
//    var datePlanted: String!
//    var age: Int!
//    var source: String!
//    var dateAcquired: String!
//    var price: Double!
//    var pot: String!
//    var height: String!
//    var trunkWidth: String!
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bonsais, forKey: "bonsais")
//        aCoder.encodeObject(name, forKey: "name")
//        aCoder.encodeObject(photos, forKey: "photos")
//        aCoder.encodeObject(specie, forKey: "specie")
//        aCoder.encodeObject(datePlanted, forKey: "datePlanted")
//        aCoder.encodeObject(age, forKey: "age")
//        aCoder.encodeObject(source, forKey: "source")
//        aCoder.encodeObject(dateAcquired, forKey: "dateAcquired")
//        aCoder.encodeObject(price, forKey: "price")
//        aCoder.encodeObject(pot, forKey: "pot")
//        aCoder.encodeObject(height, forKey: "heigth")
//        aCoder.encodeObject(trunkWidth, forKey: "trunkWidth")
    }
    
    init(coder aDecoder: NSCoder) {
        bonsais = aDecoder.decodeObjectForKey("bonsais") as [CBonsai]
//        name = aDecoder.decodeObjectForKey("name") as String
//        photos = aDecoder.decodeObjectForKey("photos") as [String]
//        specie = aDecoder.decodeObjectForKey("specie") as String
//        style = aDecoder.decodeObjectForKey("style") as String
//        datePlanted = aDecoder.decodeObjectForKey("datePlanted") as String
//        age = aDecoder.decodeObjectForKey("age") as Int
//        source = aDecoder.decodeObjectForKey("source") as String
//        dateAcquired = aDecoder.decodeObjectForKey("dateAcquired") as String
//        price = aDecoder.decodeObjectForKey("price") as Double
//        pot = aDecoder.decodeObjectForKey("pot") as String
//        height = aDecoder.decodeObjectForKey("height") as String
//        trunkWidth = aDecoder.decodeObjectForKey("trunkWidth") as String
    }
    
    override init() {
        
    }
}

class ArchiveBonsaiItems: NSObject {
    var documentDirectories: NSArray = []
    var documentDirectory: String = ""
    var path: String!
    
    
    func ArchiveBonsaisArr(#bonsaiConverter: BonsaiConverter) {
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as String
        path = documentDirectory.stringByAppendingPathComponent("bonsais.data")
        
        if NSKeyedArchiver.archiveRootObject(bonsaiConverter, toFile: path) {
            println("Success writing to file!")
        } else {
            println("Unable to write to file!")
        }
    }
    
    func RetrieveBonsaisArr() -> NSObject {
        var dataToRetrieve = BonsaiConverter()
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as String
        path = documentDirectory.stringByAppendingPathComponent("bonsais.data")
        if let dataToRetrieve2 = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? BonsaiConverter {
            dataToRetrieve = dataToRetrieve2 as BonsaiConverter
        }
        return(dataToRetrieve)
    }
}
