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
        print(categoryData!)
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
            cell.textLabel?.text = productData.name
        }
        
        return cell
    }
}

extension ProductListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
