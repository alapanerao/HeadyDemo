//
//  CategoryListViewController.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    let reuseIdentifier = "productCell"
    var categoryData: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryData?.name
    }
}

extension ProductListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = categoryData?.products.count else {
            return 0
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        
        if let productData = categoryData?.products[indexPath.row] {
            cell.productName?.text = productData.name
            cell.taxLabel?.text = productData.tax.name + " : " + String(productData.tax.value) + "%"
            
            cell.setData(data: productData.variants)
            cell.dateAddedLabel?.text = self.getFormattedDate(dateToFormat: productData.date_added)
        }
        
        return cell
    }
}

extension ProductListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ProductListViewController {
    func getFormattedDate(dateToFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:dateToFormat)!
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateAdded = dateFormatter.string(from: date)
        return "Added on " + dateAdded
    }
}
