//
//  VC_LogsTableView.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 6/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

    // GLOBAL VARIABLES
    var logs = [String]()


class VC_LogsTableView: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableLogsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if NSUserDefaults.standardUserDefaults().objectForKey("logs") != nil
        {
            logs = NSUserDefaults.standardUserDefaults().objectForKey("logs") as [String]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        tableLogsView.reloadData()
        for log in logs {
            println(log)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return logs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell_log = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell_Log")
        cell_log.textLabel?.text = logs[indexPath.row]
        
        
        
        return cell_log
    }
    
    

}
