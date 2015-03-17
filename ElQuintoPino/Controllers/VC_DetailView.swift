//
//  VC_DetailView.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 6/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class VC_DetailView: UIViewController {

    @IBOutlet weak var btn_newSpecie: UIButton!
    @IBOutlet var allTextFields: [UITextField]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func btn_done_newBonsai(sender: AnyObject)
    {
        var newBonsaiVariables: [String] = getBonsaiVarsFrom(allTextFields)

        if allTextFields[0].text != "" {
            // Bonsai action
            addNewBonsai(newBonsaiVariables)
            
            // Log action
            logs.append("New bonsai added: " + newBonsaiVariables[0])
            
            cleanAllTextFields()
        }
        
        
//        NSUserDefaults.standardUserDefaults().setObject(bonsais, forKey: "bonsais")
        NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
    }
    
    @IBAction func newSpecie(sender: AnyObject)
    {
        
    }
    
    func addNewBonsai(newBonsaiVariables: [String]) {
        bonsais.append(CBonsai(newBonsaiVariables: newBonsaiVariables))
    }

    func getBonsaiVarsFrom(allTextFields: [UITextField])->[String] {
        var vars_arr = [String]()
        for field in allTextFields {
            vars_arr.append(field.text)
        }
        return vars_arr
    }
    
    
    
    func cleanAllTextFields() {
        for tf in allTextFields {
            tf.text = ""
        }
    }
}
