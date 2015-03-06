//
//  VC_DetailView.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 6/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class VC_DetailView: UIViewController {

    @IBOutlet weak var tf_name: UITextField!
    
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
    

    @IBAction func btn_done_newBonsai(sender: AnyObject)
    {
        var bonsai_name = tf_name.text
        if bonsai_name != "" && bonsai_name != " " {
            bonsais.append(bonsai_name)
            tf_name.text = ""
            
            // Log action
            logs.append("New bonsai added: " + bonsai_name)
            bonsai_name = ""
            
        } else {
            println("Empty field!")
        }
        
        NSUserDefaults.standardUserDefaults().setObject(bonsais, forKey: "bonsais")
        NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
}
