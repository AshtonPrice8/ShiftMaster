//
//  IA2App.swift
//  IA2
//
//  Created by AJ on 13/3/2023.
//

import SwiftUI

@main
struct IA2App: App {
    
    @ObservedObject var myData = MyDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(myData)
        }
    }
}
