//
//  String+Extension.swift
//  JSONParser
//
//  Created by Bohdan Dankovych on 08.02.2023.
//

import Foundation

extension String {
    func clearedLeadingTrailingBrackets() -> String? {
        var str = self
        
//        str = str.trimmingCharacters(in: CharacterSet([#"""#]))
        if let openBracketPosition = str.firstIndex(of: #"""#) {
            let range = Range(uncheckedBounds: (str.startIndex, openBracketPosition))
            str.removeSubrange(range)
        }

        while str.first == "\"" {
            str.removeFirst()
        }

        if let closeBracketPosition = str.lastIndex(of: #"""#) {
            let range = Range(uncheckedBounds: (closeBracketPosition, str.endIndex ))
            str.removeSubrange(range)
        }
        
        return str.isEmpty ? nil : str
    }
}
