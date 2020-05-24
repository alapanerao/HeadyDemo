//
//  ViewController.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let reuseIdentifier = "categoryCell";
    private var categoryArray: NSArray = []
    private var displayDataArray: NSArray = []
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    private var request: AnyObject?
    private var selectedCategory: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.title = "Categories"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CategoryChildViewController {
            if let cell = sender as? CategoryCell,
                let indexPath = self.categoryCollectionView.indexPath(for: cell) {
                guard let categoryData = displayDataArray[indexPath.row] as? Category else {
                    return
                }
                selectedCategory = categoryData
            }
            let vc = segue.destination as? CategoryChildViewController
            vc?.categoryData = categoryArray as? [Category]
            vc?.selectedCategory = selectedCategory
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = displayDataArray[indexPath.row] as! Category
        cell.categoryName!.text = category.name
        cell = getCellWithShadow(cell: cell)
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 50
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
}

extension ViewController {
    func getCellWithShadow(cell: CategoryCell) -> CategoryCell {
        cell.contentView.layer.cornerRadius = 2.0;
        cell.contentView.layer.borderWidth = 1.0;
        cell.contentView.layer.borderColor = UIColor.clear.cgColor;
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.gray.cgColor;
        cell.layer.shadowOffset = CGSize.init(width: 0, height: 2.0)
        cell.layer.shadowRadius = 4.0;
        cell.layer.shadowOpacity = 0.5;
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func fetchData() {
        let categoryRequest = APIRequest(resource: DataResource())
        request = categoryRequest
        categoryRequest.load { [weak self] (categories: [Category]?) in
            guard let categories = categories else {
                return
            }
            
            let arrayOfChild = categories.flatMap{ $0.child_categories}
            self!.displayDataArray = categories.filter { !arrayOfChild.contains($0.id) } as NSArray
            self!.categoryArray = categories as NSArray
            
            self!.categoryCollectionView.reloadData()
        }
    }
}

