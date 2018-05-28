//
//  CarViewModel.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import Starscream
import SwiftyJSON

class CarViewModel: WebSocketDelegate {

    var view: CarView

    var socketManager = SocketManager()

    var isCarStarted = false

    init(view: CarView) {
        self.view = view
        self.socketManager.socket.delegate = self
    }

    func disconnetFromSocket() {
        socketManager.socket.disconnect()
    }

    func startButtonClicked(carName: String) {
        if !socketManager.socket.isConnected {
            socketManager.socket.connect()
            socketManager.socket.onConnect = {
                self.socketManager.startCar(name: carName)
            }
        } else if !isCarStarted {
            socketManager.startCar(name: carName)
        }
    }

    func stopButtonClicked() {
        socketManager.stopCar()
        isCarStarted = false
        view.resetSpeedBoard()
    }

    // MARK: - WebSocketDelegate

    func websocketDidConnect(socket: WebSocketClient) {
        print("didConnect CarViewModel")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("didDisconnect CarViewModel : \(String(describing: error))")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("didReceiveMessage CarViewModel : \(text)")

        do {
            if let dataFromString = text.data(using: .utf8) {
                let car = try JSON(data: dataFromString)
                if let speed = car["CurrentSpeed"].int {
                    isCarStarted = true
                    view.displayCurrentSpeed(speed: speed.description)
                }
            }
        } catch let error {
            print("Sending data to WS failed : \(error)")
        }
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("didReceiveData CarViewModel : \(data)")
    }
}
