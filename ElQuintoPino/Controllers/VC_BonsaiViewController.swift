//
//  VC_BonsaiViewController.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 5/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

// GLOBAL VARIABLES
var bonsais = [CBonsai]()
var bonsaisConverted = BonsaiConverter()
let server: String = "kintoncloud.com"
var bonsaiSelected = -1


class VC_BonsaiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    /* Other local class variables */
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("logs") != nil
        {
            logs = NSUserDefaults.standardUserDefaults().objectForKey("logs") as [String]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        setupListView()
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
    
    // Selected Row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        bonsaiSelected = indexPath.row
        println("\(bonsaiSelected)")
        performSegueWithIdentifier("addEdit_view", sender: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: VC_MyCustomCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as VC_MyCustomCell
        cell.setCell(bonsais[indexPath.row].name, bspecie: bonsais[indexPath.row].specie, avatar: UIImage(named: bonsais[indexPath.row].photos)!)
        return cell
    }
    
    
    
    
    // This method just do things when the user are trying to do something to the table (like swipe for deleting)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let bonsaiName = bonsais[indexPath.row].name!
            removeBonsai(indexPath.row)
            
            // Log action
            logs.append("Bonsai called '\(bonsaiName)' deleted")
            NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
            
            self.setupListView()
        }
    }
    
    func setupListView()
    {
        // 1
        loader.startAnimating()
        bonsais = [CBonsai]()
        let urlAsString = "http://\(server)/5Pino/getBonsais.php"
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        // 2
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void
            in
            
            if (error != nil) {
                println(error.localizedDescription)
            }
            
            var err: NSError?
            
            // 3
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            
            if (err != nil) {
                println("JSNON Error \(err!.localizedDescription)")
            }
            
            // 4
            let successID: Int! = jsonResult["success"] as Int
            var bonsaisTag: [NSDictionary] = jsonResult["bonsais"] as [NSDictionary]
            
            if (successID == 1) {
                // Show the JSON result!
                //                println(jsonResult)
                for bonsai in bonsaisTag {
                    var id = bonsai["id"] as NSString
                    var name = bonsai["name"] as NSString
                    var species = bonsai["species"] as NSString
                    var photo = "default.png"
                    
                    bonsais.append(CBonsai(id: id, name: name, specie: species, photos: photo))
                    //println(String(id) + " " + name + " " + species)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView!.reloadData()
                self.loader.stopAnimating()
            })
        })
        // 5
        jsonQuery.resume()
    }
    
    func removeBonsai(index: Int)
    {
        var url: NSURL = NSURL(string: "http://\(server)/5Pino/deleteBonsaiByID.php")!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        var senderData = "id=\(bonsais[index].id)"
        request.HTTPMethod = "POST"
        request.HTTPBody = senderData.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) in
            // println(response) // Response
            if let HTTPResponse = response as? NSHTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 {
                    // Successuflly delete
                    println("Ok! Removed properly!")
                    self.tableView.reloadData()
                }
            }
        }
       setupListView()
    }
    
}