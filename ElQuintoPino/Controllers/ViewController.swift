//
//  ViewController.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 2/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var speciesPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func exitFromCurrentView(segue: UIStoryboardSegue) {
//        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveNewBonsai(segue: UIStoryboardSegue) {
        
    }
}

