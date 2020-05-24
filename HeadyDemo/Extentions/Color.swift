//
//  Color.swift
//  HeadyDemo
//
//  Created by Alap Anerao on 24/05/20.
//  Copyright © 2020 Alap Anerao. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorWith(name:String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as? UIColor)
        } else {
            return nil
        }
    }
}
