//
//  CarListView.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import UIKit

class CarListView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: CarListViewModel!

    var selectedCar: Car?
    var carList: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        viewModel = CarListViewModel(view: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.socketManager.socket.disconnect()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell
        cell.car = carList[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCar = carList[indexPath.row]
        performSegue(withIdentifier: "toCar", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCar" {
            if let carView = segue.destination as? CarView {
                carView.car = selectedCar
            }
        }
    }
}
