//
//  VC_BonsaiViewController.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 5/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

    // GLOBAL VARIABLES
    var bonsais = [String]()



class VC_BonsaiViewController: UIViewController, UITableViewDelegate {
    
    /* Other local class variables */
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        bonsais = ["Bonsai 1", "Bonsai 2", "Bonsai 3"]
        
        // Save the user values. The data always keeps even closing the app
        if NSUserDefaults.standardUserDefaults().objectForKey("bonsais") != nil
        {
           bonsais = NSUserDefaults.standardUserDefaults().objectForKey("bonsais") as [String]
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    
    /* TABLES issues */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return bonsais.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = bonsais[indexPath.row]
        return cell
    }
    
    // This method just do things when the user are trying to do something to the table (like swipe for deleting)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            bonsais.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(bonsais, forKey: "bonsais")
            tableView.reloadData()
        }
        
    }
    
    


}
