//
//  SocketViewController.swift
//  API_test
//
//  Created by nick on 3/15/21.
//

import UIKit
import Starscream

class SocketViewController: UIViewController {
    
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var connectionLabel: UILabel!
    
    @objc let priceSocket = PriceSocket()
    var priceObservation: NSKeyValueObservation?
    var tickerObservation: NSKeyValueObservation?
    var tickerKVO: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceLabel.text = ""
        
        print(UIDevice().name)
        if UIDevice().name == "iPhone 8" {
            connectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        } else {
            connectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        
        priceObservation = observe(\SocketViewController.priceSocket.currentPrice, options: [.new], changeHandler: { (vc, change) in
            guard let updatedPrice = change.newValue else { return }
            print("New price \(updatedPrice)")
            self.priceLabel.text = "\(self.tickerKVO!) $\(String(updatedPrice))"
        })
        tickerObservation = observe(\SocketViewController.priceSocket.currentTicker, options: [.new], changeHandler: { (vc, change) in
            guard let updatedTicker = change.newValue as? String else { return }
            print("New ticker \(updatedTicker)")
            self.tickerKVO = updatedTicker
        })

        priceSocket.createConnection()
    }
    
    @IBAction func connectButtonDidPressed(_ sender: UIButton) {
        if priceSocket.isConnected {
            connectionButton.setTitle("Connect", for: .normal)
            priceSocket.webSocket.disconnect()
        } else {
            connectionButton.setTitle("Disconnect", for: .normal)
            priceSocket.webSocket.connect()
        }
    }
    
    @IBAction func writeButtonDidPressed(_ sender: UIButton) {
        subscribe(symbol: "AAPL")
        subscribe(symbol: "TSLA")
        subscribe(symbol: "YNDX")
        subscribe(symbol: "KO")
//        subscribe(symbol: "BINANCE:BTCUSDT")
    }
    
    func subscribe(symbol: String) {
        let json = ["type": "subscribe", "symbol": symbol]
        let data = try! JSONEncoder().encode(json)
        print("Subscribed at \(symbol)")
        priceSocket.webSocket.write(data: data)
    }
    
    func updatePriceLabel(price: Float, ticker: String) {
//        print(priceSocket.currentTicker)
//        print(priceSocket.currentPrice)
        print(price)
        print(ticker)
        priceLabel.text = "\(ticker) = \(price))"
//        priceLabel.text = "\(String(describing: priceSocket.currentTicker)) = \(String(describing: priceSocket.currentPrice))"
    }

}

