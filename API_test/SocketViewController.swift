//
//  SocketViewController.swift
//  API_test
//
//  Created by nick on 3/15/21.
//

import UIKit
import Starscream

class SocketViewController: UIViewController {

    let priceSocket = PriceSocket()
    
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UIDevice().name)
        if UIDevice().name == "iPhone 8" {
            connectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        } else {
            connectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }

        priceSocket.createConnection()
    }
    
//    var iteration = 2
//    func updateLabel() {
//        iteration = iteration == Int.max ? 0 : (iteration+1)
//        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
//            self.priceLabel.text = "\(self.iteration)"
//            self.updateLabel()
//        })
//    }
    
    @IBAction func connectButtonDidPressed(_ sender: UIButton) {
        if priceSocket.isConnected {
            connectionButton.titleLabel?.text = "Connect"
            priceSocket.webSocket.disconnect()
        } else {
//            connectionButton.titleLabel?.text = "Disconnect"
            priceSocket.webSocket.connect()
        }
    }
    
    @IBAction func writeButtonDidPressed(_ sender: UIButton) {
//        let stringToWrite = "hello there!"
//        print("Writed text: \(stringToWrite)")
//        priceSocket.webSocket.write(string: stringToWrite)
        let json = ["type":"subscribe", "symbol":"AAPL"]
        let data = try! JSONEncoder().encode(json)
        print("Writed text: \(json)")
        priceSocket.webSocket.write(data: data)
    }
    
    

}

