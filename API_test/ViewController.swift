//
//  ViewController.swift
//  API_test
//
//  Created by Nikolay Kryuchkov on 11.03.2021.
//

import UIKit
import CoreData

struct StockTableCard: Codable {
    // Data from Company Profile 2 request
    let name: String
    let logo: URL
    let ticker: String
    let industry: String
    
    // Data from Quote request
    var currentPrice: Float
    var previousClosePrice: Float
    
    var isFavourite: Bool
    
}

class ViewController: UIViewController {

    let headers = [
        "X-Finnhub-Token": "c0vhf5748v6pqdk9hmq0"
//                "X-Finnhub-Token": "sandbox_c0vhf5748v6pqdk9hmqg"
    ]
    let session = URLSession.shared
    
    var dadta = [Data]()
    var dataStockInfo = Array<Data>()
    var stockCards = Dictionary<String, StockTableCard>()
    var stockTickerList = Array<String>()
    
//    var stockCardsData = [Data]()
    var stockCardsData = [StockCardData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        readData(company: "AAPL")
        mboum(stockSymbol: "AAPL") { (dataIn) in
            self.dataStockInfo.append(dataIn)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { [self] in
//            if dataStockInfo[0].count == 0 {
//                dataStockInfo.removeFirst()
//            }
//
//            parseStocksDataToJSON()
            
            let str = StockTableCard(name: "Apple",
                                     logo: URL(string: "apple_logo.png")!,
                                     ticker: "AAPL",
                                     industry: "Tech",
                                     currentPrice: 120.0,
                                     previousClosePrice: 116.0,
                                     isFavourite: false)
            let codedStr = try? JSONEncoder().encode(str)
            
            saveCoreData(withStringTitle: codedStr!)
            readCoreData()
//            clearCoreData()
            print(stockCardsData[0].cardData!)
            print(type(of: stockCardsData[0].cardData!))
            parseDataToJSON(data: stockCardsData[0].cardData!)
        }
    }
    
    //func getStockList(completion: @escaping ([Data]) -> ()) {
    //
    //    //
    //    for company in StockList().stockList {
    //        getStockInfo(stockSymbol: company) { (dataIn) -> () in
    //            self.dadta.append(dataIn)
    //            print(self.dadta.count)
    //        }
    //    }
    ////        print("get \(dadta.count) elements")
    //    dadta.removeFirst()
    //    completion(dadta)
    //}

    func getStockInfo(stockSymbol symbol: String, completion: @escaping (Data) -> ()) {
        
        let request = NSMutableURLRequest(
            url: NSURL(string: "https://finnhub.io/api/v1/stock/metric?symbol=\(symbol)&metric=all")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                completion(data!)
            }
        }
        )
        dataTask.resume()
    }

    func getStockProfile(stockSymbol symbol: String, completion: @escaping (Data) -> ()) {
        
        let request = NSMutableURLRequest(
            url: NSURL(string: "https://finnhub.io/api/v1/stock/profile?symbol=\(symbol)")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                completion(data!)
            }
        }
        )
        dataTask.resume()
    }

    func readData(company: String) {
            getStockInfo(stockSymbol: company) { (dataIn) -> () in
                self.dataStockInfo.append(dataIn)
            }
    }

    func parseStocksDataToJSON () {
        print(dataStockInfo.count)
        print("data for JSON", dataStockInfo)
    //        var json: [String: Any]
        for data in dataStockInfo {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]

                print(json)
//                print(json["longBusinessSummary"]!)
//                print(json["metric"]!)
                // TODO: - Set price and logo URL
//                var stringLogoURL = json["logo"] as? String
//                if stringLogoURL == "" {
//                    stringLogoURL = "https://finnhub.io/api/logo?symbol=AAPL"
//                }
    //                print(stringLogoURL!)
//                let card = StockTableCard(name: json["name"] as! String,
//                                          logo: (URL.init(string: stringLogoURL!)!),
//                                          ticker: json["ticker"] as! String,
//                                          industry: json["finnhubIndustry"] as! String,
//                                          currentPrice: 0.0,
//                                          previousClosePrice: 0.0,
//                                          isFavourite: false)
//                stockCards[card.ticker] = card
//                stockTickerList.append(card.ticker)
            } catch let error {
                print(error)
            }
        }
    //    for (key, data) in dataStockPrice {
    //        do {
    //            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    //            print(key, json)
    //            stockCards[key]?.currentPrice = Float(truncating: json["c"] as! NSNumber)
    //            stockCards[key]?.previousClosePrice = Float(truncating: json["pc"] as! NSNumber)
    //        } catch let error {
    //            print(error)
    //        }
        }

    func parseDataToJSON (data: Data) {
        print(data.count)
        print("data for JSON", data)
        let decoded = String(data: data, encoding: .utf8)
        print(decoded!)
    //        var json: [String: Any]
//        for data in inputData {
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

                print(json)
                print(json["logo"] as! String)
//                print(json["longBusinessSummary"]!)
//                print(json["metric"]!)
                // TODO: - Set price and logo URL
//                var stringLogoURL = json["logo"] as? String
//                if stringLogoURL == "" {
//                    stringLogoURL = "https://finnhub.io/api/logo?symbol=AAPL"
//                }
    //                print(stringLogoURL!)
//                let card = StockTableCard(name: json["name"] as! String,
//                                          logo: (URL.init(string: stringLogoURL!)!),
//                                          ticker: json["ticker"] as! String,
//                                          industry: json["finnhubIndustry"] as! String,
//                                          currentPrice: 0.0,
//                                          previousClosePrice: 0.0,
//                                          isFavourite: false)
//                stockCards[card.ticker] = card
//                stockTickerList.append(card.ticker)
            } catch let error {
                print(error)
            }
//        }
    //    for (key, data) in dataStockPrice {
    //        do {
    //            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    //            print(key, json)
    //            stockCards[key]?.currentPrice = Float(truncating: json["c"] as! NSNumber)
    //            stockCards[key]?.previousClosePrice = Float(truncating: json["pc"] as! NSNumber)
    //        } catch let error {
    //            print(error)
    //        }
        }
    
    func mboum(stockSymbol symbol: String, completion: @escaping (Data) -> ()) {
        let headers = [
            "X-Mboum-Secret": "demo"
        ]

        let request = NSMutableURLRequest(
            url: NSURL(string: "https://mboum.com/api/v1/qu/quote/profile/?symbol=AAPL")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let data = data as? Data
                print(data)
                self.dataStockInfo.append(data!)
            }
        })

        dataTask.resume()
    }
    
    // Get context for app
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func clearCoreData() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<StockCardData> = StockCardData.fetchRequest()
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError  {
            print(error.localizedDescription)
        }
        print("All likes deleted")
    }
    
    // Reload data from CoreData
    private func saveCoreData(withStringTitle title: Data) {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "StockCardData", in: context) else {return}
        
        // Create new task
        let taskObject = StockCardData(entity: entity, insertInto: context)
        taskObject.cardData = title
        
        // Save new task in memory at 0 position
        do {
            try context.save()
            print(taskObject.cardData)
            //            tasks.append(taskObject)
//            imageLikes.insert(taskObject, at: 0)
        } catch let error as NSError  {
            print(error.localizedDescription)
        }
    }
    
    func readCoreData() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<StockCardData> = StockCardData.fetchRequest()
        // Sorting of tasks list
        let sortDescriptor = NSSortDescriptor(key: "cardData", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // Obtain data from context
        
        do {
            try stockCardsData = context.fetch(fetchRequest)
            print(stockCardsData.count)
//            print(imageLikes, "likes")
//            print(imageLikes[2].imageURL)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}


