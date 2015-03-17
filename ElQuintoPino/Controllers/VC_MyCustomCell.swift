//
//  VC_MyCustomCell.swift
//  ElQuintoPino
//
//  Created by Ferran Olivella on 12/3/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class VC_MyCustomCell: UITableViewCell {

    @IBOutlet weak var bonsai_image: UIImageView!
    @IBOutlet weak var lbl_bname: UILabel!
    @IBOutlet weak var lbl_specie: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(bname: String, bspecie: String, avatar: UIImage) {
        lbl_bname.text = bname
        lbl_specie.text = bspecie
        bonsai_image.image = avatar
    }

}
