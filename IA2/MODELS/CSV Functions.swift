//
//  CSV Functions.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import Foundation


//MARK: CLEAN ROWS
func cleanRows(file:String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

