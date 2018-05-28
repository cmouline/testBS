//
//  SocketManager.swift
//  TestBS
//
//  Created by hackintosh4 on 23/05/2018.
//  Copyright © 2018 chloemoulinet. All rights reserved.
//

import Starscream
import SwiftyJSON

class SocketManager {

    let socket = WebSocket(url: URL(string: "ws://pbbouachour.fr:8080/openSocket")!)
    let userToken = 42

    init() {
        socket.connect()
    }

    deinit {
        socket.disconnect()
    }

    func sendData(json: JSON) {
        do {
            let data = try JSONSerialization.data(withJSONObject: json.object)
            socket.write(data: data, completion: nil)
        } catch let error {
            print("Sending data to WS failed : \(error)")
        }
    }

    func getCarList() {
        let json: JSON = [
            "Type" : "infos",
            "UserToken" : userToken
        ]

        sendData(json: json)
    }

    func startCar(name: String) {
        let payload: JSON = [ "Name" : name ]
        let json: JSON = [
            "Type" : "start",
            "UserToken" : userToken,
            "Payload" : payload,
            ]

        sendData(json: json)
    }

    func stopCar() {
        let json: JSON = [
            "Type" : "stop",
            "UserToken" : userToken
        ]

        sendData(json: json)
    }
}
