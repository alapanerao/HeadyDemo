//
//  CategoryTableCell.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var variantsCollectionView: UICollectionView!
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var taxLabel: UILabel!
    @IBOutlet var dateAddedLabel: UILabel!
    
    var variantList: [Variant]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.variantsCollectionView.dataSource = self
        self.variantsCollectionView.register(UINib.init(nibName: "VariantCell", bundle: nil), forCellWithReuseIdentifier: "variantsCell")
        
    }
    
    func setData(data: [Variant]) {
        variantList = data
    }
}

extension ProductCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return variantList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "variantsCell", for: indexPath as IndexPath) as! VariantCell
        
        
        if let variantData = variantList?[indexPath.row] {
            cell.colorView.backgroundColor = UIColor.colorWith(name: variantData.color.lowercased())
            
            if let size = variantData.size {
                cell.labelSize.text = String(size)
            } else {
                cell.labelSize.text = "NA"
            }
            
            if let price = variantData.price {
                cell.labelPrice.text = String(price)
            } else {
                cell.labelPrice.text = "NA"
            }
        }
        return cell
    }
}
