//
//  Parser.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import Foundation

class JSONParser {
    
    func parseItems(from array: [String]) -> [Item]? {
        array.compactMap { parseItem(from: $0) }
    }
    
    func parseItem(from json: String) -> Item?  {
        var item: Item?
        for key in Item.CodingKeys.allCases {
            
            var valueEndPosition: String.Index?
            var minimalLength  = json.count
            
            guard let keyPosition = json.range(of: key.keyPattern, options: .regularExpression) else { continue }
            
            for nextKey in Item.CodingKeys.allCases {
                guard let nextKeyPosition = json.range(of: nextKey.keyPattern, options: .regularExpression),
                      nextKey != key else {
                    continue
                }
                
                let count = json.distance(from: keyPosition.upperBound, to: nextKeyPosition.lowerBound)
                
                if count < 0 { continue }
                
                if minimalLength > count {
                    minimalLength = count
                    valueEndPosition = nextKeyPosition.lowerBound
                }
            }
            
            var value: String
            if let valueEndPosition {
                value = String(json[keyPosition.upperBound..<valueEndPosition])
            } else {
                value = String(json[keyPosition.upperBound..<json.endIndex])
            }
            
            value = value.trimmingCharacters(in: .whitespaces.union(CharacterSet([":", ","])))
            
            if item == nil { item = Item() }
            item?.set(value: value, key: key)
        }
        
        return item
    }
}
