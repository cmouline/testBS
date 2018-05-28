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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func startCarAction(_ sender: Any) {
        if let name = car?.name {
            viewModel.startButtonClicked(carName: name)
        }
    }

    @IBAction func stopCarAction(_ sender: Any) {
        viewModel.stopButtonClicked()
    }

    var viewModel: CarViewModel!

    var car: Car?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CarViewModel(view: self)
        setButtonText()
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.socketManager.stopCar()
        viewModel.socketManager.socket.disconnect()
    }

    func displayCurrentSpeed(speed: String) {
        currentSpeedLabel.text = speed
    }

    func resetSpeedBoard() {
        currentSpeedLabel.text = "0"
    }

    // MARK:- Private functions
    
    private func setButtonText() {
        startButton.setTitle("Start \u{f04b}", for: .normal)
        stopButton.setTitle("Stop \u{f04d}", for: .normal)
    }
}
