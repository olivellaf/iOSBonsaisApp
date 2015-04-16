//
//  VC_CollectionView.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 19/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

    var selected_photo: UIImage = UIImage()
    var photos: [UIImage] = [UIImage]()

class VC_CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var collectionView: UICollectionView!
    var imagePicker: UIImagePickerController!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadThePhotos()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        loadThePhotos()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bonsais.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("colCell", forIndexPath: indexPath) as MyCollectionViewCell
        cell.imageCell.image = photos[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if (indexPath.row <= bonsais.count) {
            println(bonsais[indexPath.row].name)
            selected_photo = UIImage(named: bonsais[indexPath.row].photos)!
        }
        
        return true
    }
    
    //
    
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        showActionSheet("Choose whatever you want")
    }
    
    func showActionSheet(title: String)
    {
        let actionSheet = UIActionSheet(title: title, delegate: self, cancelButtonTitle: "cancel", destructiveButtonTitle: nil, otherButtonTitles: "Use camera", "Open library")
        actionSheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            NSLog(actionSheet.buttonTitleAtIndex(buttonIndex))
            let delay = 1.0 * Double(NSEC_PER_SEC) // This will ready the delay in seconds. This example, delay will be 1 sec
            
            var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay)) // Preparing the dispatch time based on the delay value
            
            dispatch_after(time, dispatch_get_main_queue(), { // Dispatching a new thread selector after delay
                
                NSThread.detachNewThreadSelector(Selector("takeAPhoto"), toTarget:self, withObject: nil) // Setting the target selector with one String parameter
            })
            break
            
        case 2:
            NSLog(actionSheet.buttonTitleAtIndex(buttonIndex))
            break
            
        default:
            NSLog("Default: " + actionSheet.buttonTitleAtIndex(buttonIndex))
            break
        }
    }
    
    func takeAPhoto() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        imagePicker.allowsEditing = true
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        photos.append((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
    }
    
    func loadThePhotos() {
        for bonsai in bonsais {
            photos.append(UIImage(named: bonsai.photos)!)
        }
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
}
