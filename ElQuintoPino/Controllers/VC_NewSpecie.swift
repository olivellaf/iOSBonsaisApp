//
//  VC_NewSpecie.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 26/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class VC_NewSpecie: UIViewController {

    @IBOutlet weak var tf_specieName: UITextField!
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_doneNewSpecieTapped(sender: AnyObject) {
        var newSpecieName = tf_specieName.text
        
        if (find(species, newSpecieName) == nil) {
            if self.tf_specieName.text != "" {
                species.append(newSpecieName)
                
                // logs
                logs.append("New specie added: '\(newSpecieName)'")
                NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
                println("New specie added")
                self.tf_specieName.text = ""
                
            } else {
                println("Something has ocurred. Name field is empty")
            }
        } else {
            println("Something has ocurred. The specie already exists")
        }
    }
}
