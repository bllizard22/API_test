//
//  MessageStruct.swift
//  API_test
//
//  Created by nick on 3/15/21.
//

import Foundation

//struct FinnhubMessage: Codable {
//    let tradeData: [TradeData]
//    let type: String
//
//    enum CodingKeys: String, CodingKey {
//        case tradeData
//        case type
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.type = try container.decode(String.self, forKey: .type)
//        self.tradeData = try container.decode([TradeData].self, forKey: .tradeData)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: .type)
//        try container.encode(tradeData, forKey: .tradeData)
//    }
//}

struct TradeData: Codable {
    let c: [String]
    let p: Float
    let s: String
    let t: Int
    let v: Int
}

/*
struct Coordinate {
    var latitude: Double
    var longitude: Double
    var elevation: Double
}

extension Coordinate: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        
        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
    }
}

extension Coordinate: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        
        var additionalInfo = container.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
        try additionalInfo.encode(elevation, forKey: .elevation)
    }
}
 
*/

/*
extension FinnhubMessage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.type)
//        hasher.combine(Tr)
    }
}

extension TradeData: Hashable
*/

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
