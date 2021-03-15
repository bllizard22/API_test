//
//  MessageStruct.swift
//  API_test
//
//  Created by nick on 3/15/21.
//

import Foundation

struct FinnhubMessage: Codable {
    let tradeData: [TradeData]
    let type: String
}

struct TradeData {
    let c: [String]
    let p: Float
    let s: String
    let t: Int
    let v: Int
    
}

extension FinnhubMessage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.type)
//        hasher.combine(Tr)
    }
}

extension TradeData: Hashable

/*
{
 "data":[
     {
         "c":["1","24","12"],
         "p":121.38,
         "s":"AAPL",
         "t":1615809975482,
         "v":1
     },
     {
         "c":["1","24","12"],
         "p":121.38,
         "s":"AAPL",
         "t":1615809975482,
         "v":1
     }
 ],
 "type":"trade"
}
*/
