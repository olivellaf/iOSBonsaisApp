//
//  VC_DetailView.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 6/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

var species: [String] = ["Bad Cypress", "Okinawa Holly", "Snowbush", "Shimpaku", "Lavender Star Flower", "Dwarf Pomegranate", "Flowering Crabapple", "Jaboticaba", "Chinese Bird Plum", "Bamboo", "Holly", "Hawaiian Umbrella Tree"]

class VC_DetailView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var btn_newBonsai: UIBarButtonItem!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var pvSpecie: UIPickerView!
    @IBOutlet weak var btn_newSpecie: UIButton!
    @IBOutlet var allTextFields: [UITextField]!
    
    var selected_specie: String = species[0]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pvSpecie.dataSource = self
        self.pvSpecie.delegate = self
        
        if bonsaiSelected != -1 {
            setViewAsUpdateInfo(bonsaiSelected)
        } else {
            setViewAsNewBonsai()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        setViewAsNewBonsai()
    }
    
    @IBAction func btn_done_newBonsai(sender: AnyObject)
    {
        var btn_text: String = sender.title!!
        
        if allTextFields[0].text != "" {
            switch (btn_text) {
            case "Add":
                // Bonsai action & new log
                addNewBonsai(allTextFields[0].text, specie: selected_specie)
                break;
                
            case "Save":
                // Updating bonsai
                updateBonsai(self.allTextFields[0].text, specie: selected_specie, id:
                    bonsais[bonsaiSelected].id)
                break;
            
            default: println("\(sender.title) is not a good value for that switch")
            }
        }
        
        // TODO: Try to pop up some Ok! popUp!! :)
    }
    
    // Picker!!
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return species.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return species[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        println(species[row])
        selected_specie = species[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        let pickerLabel = UILabel()
        let titleData = species[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.frame.size.height = 200.0
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }

    func addNewBonsai(name: String, specie: String)
    {
        var url: NSURL = NSURL(string: "http://\(server)/5Pino/createBonsai.php")!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        var paramsToSend = "name=\(name)&species=\(specie)"
        request.HTTPMethod = "POST"
        request.HTTPBody = paramsToSend.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println(response)
                if let HTTPResponse = response as? NSHTTPURLResponse {
                    let statusCode = HTTPResponse.statusCode
                    
                    if statusCode == 200 {
                        logs.append("New bonsai added: '\(name)'")
                        NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
                        
                        // Appending the new element! :)
                        bonsais.append(CBonsai(id: "", name: name, specie: specie, photos: "default.png"))
                        self.cleanAllTextFields()
                    } else {
                        println("Error. Something happen status code given: \(statusCode)")
                    }
            }
        }
    }
    
    func updateBonsai(name: String, specie: String, id: String)
    {
        var url: NSURL = NSURL(string: "http://\(server)/5Pino/updateBonsaiByID.php")!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        println("Updating params: \(name), \(specie), \(id)")
        var paramsToSend = "name=\(name)&species=\(specie)&id=\(id)"
        request.HTTPMethod = "POST"
        request.HTTPBody = paramsToSend.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
            (response, data, error) in
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            // 4
            let successID: Int! = jsonResult["success"] as Int
            let message: String! = jsonResult["message"] as String
            println("\(successID), \(message)")
            
            if let HTTPResponse = response as? NSHTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 && successID == 1 {
                    logs.append("'\(name)' updated correctly")
                    NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
                    
                    // Updating also the current Bonsai
                    for bonsai in bonsais {
                        if (bonsai.id == id) {
                            bonsai.name = name
                            bonsai.specie = specie
                        }
                    }
                } else {
                    println("Error. Something happen status code given: \(statusCode)")
                }
        }
    }
    }

    func getBonsaiVarsFrom(allTextFields: [UITextField])->[String]
    {
        var vars_arr = [String]()
        for field in allTextFields {
            vars_arr.append(field.text)
        }
        return vars_arr
    }
    
    func cleanAllTextFields()
    {
        for tf in allTextFields {
            tf.text = ""
        }
    }
    
    func setViewAsNewBonsai()
    {
        navBarTitle.title = "New Bonsai"
        btn_newBonsai.title = "Add"
        pvSpecie.selectRow(0, inComponent: 0, animated: true)
        bonsaiSelected = -1
        cleanAllTextFields()
    }
    
    func setViewAsUpdateInfo(index: Int)
    {
        // Set the fields and buttons
        var bonsai_name = bonsais[index].name
        navBarTitle.title = "\(bonsai_name)"
        btn_newBonsai.title = "Save"
        pvSpecie.selectRow(getSpecieIDWith(bonsais[index].specie), inComponent: 0, animated: true)
        allTextFields[0].text = bonsai_name
        
    }
    
    func getSpecieIDWith(name: String)->Int {
        var value = find(species, name)
        if (value == nil) {
            species.append(name)
            return getSpecieIDWith(name)
        } else {
            return value!
        }
    }
}
