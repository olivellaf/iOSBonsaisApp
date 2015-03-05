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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btn_done_newBonsai(sender: AnyObject)
    {
        if tf_name.text != "" {
            bonsais.append(tf_name.text)
            tf_name.text = ""
        }
        
        NSUserDefaults.standardUserDefaults().setObject(bonsais, forKey: "bonsais")
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    

    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
}
