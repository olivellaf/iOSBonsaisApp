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


class VC_LogsTableView: UIViewController, UITableViewDelegate, UIActionSheetDelegate {
    
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
//        for log in logs {
//            println(log)
//        }
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
    
    @IBAction func clearAllLogTable(sender: AnyObject)
    {
        // remove all directly TODO: try to show a dialog alert
        showActionSheet("¿Are you sure?", cancelButtonTitle: "cancel", destructiveButtonTitle: "Remove all")
    }
    
    func showActionSheet(title: String, cancelButtonTitle: String, destructiveButtonTitle: String)
    {
        var actionSheet = UIActionSheet(
            title: title,
            delegate: self,
            cancelButtonTitle: cancelButtonTitle,
            destructiveButtonTitle: destructiveButtonTitle
            //            otherButtonTitles: otherButtonsTitles
        )
        actionSheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex{
            
        case 0:
            NSLog("Done");
            logs.removeAll(keepCapacity: false)
//            NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
            tableLogsView.reloadData()
            break;
        case 1:
            NSLog("Cancel");
            break;
        case 2:
            NSLog("Yes");
            break;
        case 3:
            NSLog("No");
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
        }
    }
}
