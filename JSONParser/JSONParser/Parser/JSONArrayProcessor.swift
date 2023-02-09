//
//  JSONArrayProcessor.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 09.02.2023.
//

import Foundation

class JSONArrayProcessor {
    func readArray(file: String) -> [String]? {
        guard let jsonURl = Bundle(for: type(of: self)).path(forResource: file, ofType: "json"),
              var dataString = try? String(contentsOfFile: jsonURl, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        dataString = dataString.replacingOccurrences(of: #"\/"#, with: "/")
        
        clearBrackets(dataString: &dataString)
                
        let arr = dataString.components(separatedBy: "\n").compactMap {
            $0.clearedLeadingTrailingBrackets()
        }
        
        return arr
    }
    
    private func clearBrackets(dataString: inout String) {
        if let openBracketPosition = dataString.firstIndex(of: "[") {
            dataString.remove(at: openBracketPosition)
        }
        
        if let closeBracketPosition = dataString.lastIndex(of: "]") {
            let range = Range(uncheckedBounds: (closeBracketPosition, dataString.endIndex ))
            dataString.removeSubrange(range)
        }
    }
}
