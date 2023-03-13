//
//  Shift.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import Foundation

struct Shift:Identifiable{
    let id = UUID()
    var startTime:Date
    var endTime:Date
    var breakStart:Date
    var breakDuration:String //storing as 15min or 30min, as a string. Picker to handle cases...
}
