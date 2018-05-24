//
//  CarModel.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

struct Car {
    var brand: String
    var name: String
    var speedMax: Int
    var cv: Int
    var currentSpeed: Int

    init(brand: String, name: String, speedMax: Int, cv: Int, currentSpeed: Int) {
        self.brand = brand
        self.name = name
        self.speedMax = speedMax
        self.cv = cv
        self.currentSpeed = currentSpeed
    }
}
