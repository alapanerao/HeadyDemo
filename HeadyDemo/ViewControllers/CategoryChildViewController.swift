//
//  CategoryChildViewController.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 24/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

class CategoryChildViewController: CollapsibleTableSectionViewController {
    
    @IBOutlet var categoryChildCollectionView: UICollectionView!
    
    var categoryData: [Category]?
    var rankingsArray: [Ranking]?
    var displayDataArray: [Category]?
    var selectedCategory: Category?
    
    private let reuseIdentifier = "categoryCell";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        displayDataArray = categoryData?.filter { (selectedCategory?.child_categories.contains($0.id))! }
        self.title = selectedCategory?.name
    }

}

extension CategoryChildViewController: CollapsibleTableSectionDelegate {
    func numberOfSections(_ tableView: UITableView) -> Int {
        return displayDataArray?.count ?? 0
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categoryData = displayDataArray?[section] else {
            return 0
        }
        return categoryData.child_categories.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        if let data = displayDataArray?[indexPath.section] {
            let displayCategoryID = data.child_categories[indexPath.row]
            let category = categoryData?.filter{$0.id == displayCategoryID}
            cell.textLabel?.text = category?.first?.name
        }
        
        cell.textLabel?.textColor = UIColor.init(hex: 0x064B73)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return true
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let categoryData = displayDataArray?[section] else {
            return ""
        }
        return categoryData.name
    }
    
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = displayDataArray?[indexPath.section] {
            let displayCategoryID = data.child_categories[indexPath.row]
            let category = categoryData?.filter{$0.id == displayCategoryID}
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController
            vc?.categoryData = category?.first
            vc?.rankingsArray = rankingsArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }
}
