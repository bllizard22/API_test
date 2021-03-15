//
//  WebsocketConnection.swift
//  API_test
//
//  Created by nick on 3/15/21.
//

import Foundation
import Starscream

class PriceSocket: WebSocketDelegate {
    
    var isConnected = false
    var webSocket: WebSocket!
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                let dataEncoded = Data(string.utf8)
                let json = try! JSONSerialization.jsonObject(with: dataEncoded, options: .allowFragments) as! [String: String]
                if json["type"] as! String == "trade" {
                    let data = json["data"] as! [String: Any]
                    print(data["p"] as! String)
                }
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                print("websocket diconnected")
                isConnected = false
            case .error(let error):
                isConnected = false
                print(error!)
//                handleError(error)
            }
    }
    
    func createConnection() {
        var request = URLRequest(url: URL(string: "wss://ws.finnhub.io?token=c0vhf5748v6pqdk9hmq0")!)
//        var request = URLRequest(url: URL(string: "wss://echo.websocket.org")!)
        request.timeoutInterval = 5
        
//        let websocket = WebSocket(request: request)
        webSocket = WebSocket(request: request)
        webSocket.delegate = self
        webSocket.connect()
        webSocket.write(string: "Hello!")
//        let json = ["type":"subscribe", "symbol":"AAPL"]
//        let data = try! JSONEncoder().encode(json)
//        websocket.write(data: data)
        
    }
}
