//
//  CarListViewModel.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import Starscream
import SwiftyJSON

class CarListViewModel: WebSocketDelegate {

    var view: CarListView

    var socketManager = SocketManager()

    init(view: CarListView) {
        self.view = view
        self.socketManager.socket.delegate = self
    }

    func disconnetFromSocket() {
        socketManager.socket.disconnect()
    }

    // MARK: - WebSocketDelegate

    func websocketDidConnect(socket: WebSocketClient) {
        print("didConnect CarListViewModel")
        socketManager.getCarList()
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("didDisconnect CarListViewModel : \(error)")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("didReceiveMessage CarListViewModel : \(text)")

        do {
            if let dataFromString = text.data(using: .utf8) {
                let cars = try JSON(data: dataFromString)
                for (_, car):(String, JSON) in cars {
                    if let brand = car["Brand"].string,
                        let name = car["Name"].string,
                        let speedMax = car["SpeedMax"].int,
                        let cv = car["Cv"].int,
                        let currentSpeed = car["CurrentSpeed"].int {
                        view.carList.append(Car(brand: brand,
                                                name: name,
                                                speedMax: speedMax,
                                                cv: cv,
                                                currentSpeed: currentSpeed
                            )
                        )
                    }
                }
            }
        } catch let error {
            print("Sending data to WS failed : \(error)")
        }
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("didReceiveData CarListViewModel : \(data)")
    }
}
