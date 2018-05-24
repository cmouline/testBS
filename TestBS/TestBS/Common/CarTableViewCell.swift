//
//  CarTableViewCell.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var brandAndNameLabel: UILabel!
    @IBOutlet weak var speedMaxLabel: UILabel!
    @IBOutlet weak var cvLabel: UILabel!

    var car: Car? {
        didSet {
            if let car = car {
                brandAndNameLabel.text = "\(car.brand) \(car.name)"
                speedMaxLabel.text = "⚡️ \(car.speedMax.description) km/h"
                cvLabel.text = "🐎 \(car.cv.description) CV"
            }
        }
    }
}
