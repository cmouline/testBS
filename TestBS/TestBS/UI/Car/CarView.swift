//
//  CarView.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import UIKit

class CarView: UIViewController {

    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBAction func startCarAction(_ sender: Any) {
        if let name = car?.name {
            viewModel.startButtonClicked(carName: name)
        }
        print("startButtonIsPressed")
    }

    @IBAction func stopCarAction(_ sender: Any) {
        viewModel.stopButtonClicked()
        print("stopButtonIsPressed")
    }

    var viewModel: CarViewModel!

    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CarViewModel(view: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.socketManager.stopCar()
        viewModel.socketManager.socket.disconnect()
    }

    func displayCurrentSpeed(speed: String) {
        currentSpeedLabel.text = speed
    }

}
