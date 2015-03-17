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
var JOC_DE_PROVES = [CBonsai]()
let server: String = "kintoncloud.com"

func saveBonsaisToDocument() {
    ArchiveBonsaiItems().ArchiveBonsaisArr(bonsaiConverter: bonsaisConverted)
}

func loadBonsaisFromDocument() {
    bonsaisConverted = ArchiveBonsaiItems().RetrieveBonsaisArr() as BonsaiConverter
}


class VC_BonsaiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    /* Other local class variables */
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListView()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // Guardando archivos y cambios
        
    }
    
    
    /* TABLES issues */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bonsais.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: VC_MyCustomCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as VC_MyCustomCell
        cell.setCell(bonsais[indexPath.row].name, bspecie: bonsais[indexPath.row].specie, avatar: UIImage(named: "default.png")!)
        return cell
    }
    
    // This method just do things when the user are trying to do something to the table (like swipe for deleting)
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            bonsais.removeAtIndex(indexPath.row)
            //  TODO: Substituir pel propi conversor! --> NSUserDefaults.standardUserDefaults().setObject(bonsais, forKey: "bonsais")
            
            // Log action
            logs.append("Bonsai called '\(tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!)' has been deleted")
            NSUserDefaults.standardUserDefaults().setObject(logs, forKey: "logs")
            
            tableView.reloadData()
        }
    }
    
    func setupListView() {
        // 1
        bonsais = [CBonsai]()
        let urlAsString = "http://kintoncloud.com/5Pino/getBonsais.php"
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

                    bonsais.append(CBonsai(id: id, name: name, specie: species))
                    println(String(id) + " " + name + " " + species)
                }
            }

            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView!.reloadData()
            })
        })
        // 5
        jsonQuery.resume()
    }
    
    func removeCurrentBonsai(index: Int) {
        var url: NSURL = NSURL(string: "http://\(server)/5Pino/deleteBonsaiByID.php")!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        var senderData = "id=\(bonsais[index].id)"
        request.HTTPMethod = "POST"
        request.HTTPBody = senderData.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) in
            println(response)
            if let HTTPResponse = response as? NSHTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 {
                    // Successuflly delete
                    println("Ok! Removed properly!")
                }
            }
        }
        
    }
}