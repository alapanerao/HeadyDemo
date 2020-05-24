//
//  CategoryTableCell.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    //    @IBOutlet var image: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var dateAddedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
