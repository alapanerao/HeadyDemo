//
//  ViewController.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 23/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

let reuseIdentifier = "categoryCell";
var categoryArray: NSArray = []

class ViewController: UIViewController {
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    private var request: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
}

extension ViewController {
    func fetchData() {
        
        let categoryRequest = APIRequest(resource: DataResource())
        request = categoryRequest
        categoryRequest.load { [weak self] (categories: [Category]?) in
            guard let categories = categories else {
                return
            }
            categoryArray = categories as NSArray
            print(categories)
            self!.categoryCollectionView.reloadData()
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = categoryArray[indexPath.row] as! Category
        
        cell.categoryName!.text = category.name
        
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
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 50
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
}

