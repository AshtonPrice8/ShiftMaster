//
//  RosterListView.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import SwiftUI

struct RosterListView: View {
    @EnvironmentObject var myData:MyDataModel
    @Binding var isLoggedIn:Bool
    @State var showAddShiftView = false
    
    func myDateFormatter() -> DateFormatter {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button(action:{
                        isLoggedIn = false
                    }){
                        Text("Log Out")
                    }.buttonStyle(.bordered)
                    
                    Spacer()
                }
                
                Text("Hello, \(myData.me.name.components(separatedBy: " ")[0])")
                    .font(.largeTitle)
                
                HStack{
                    Text("Roster")
                        .font(.largeTitle)
                    Spacer()
                    Text("\(myData.me.position)")
                    if myData.me.position.contains("Business Owner") || myData.me.position.contains("Manager"){
                        
                        
                        Button(action:{
                            showAddShiftView = true
                        }){
                            Text("Add a Shift")
                        }.buttonStyle(.bordered)
                        
                    }
                    
                    
                }
                List{
                    
                    if myData.roster.count > 1 {
                        ForEach(myData.roster){thisLine in
                            VStack{
                                HStack{
                                    Text("START").font(.subheadline)
                                    Spacer()
                                    Text(myDateFormatter().string(from: thisLine.startTime))
                                }
                                HStack{
                                    Text("END").font(.subheadline)
                                    Spacer()
                                    Text(myDateFormatter().string(from: thisLine.endTime))
                                }
                                HStack{
                                    Text("BREAK").font(.subheadline)
                                    Spacer()
                                    Text(myDateFormatter().string(from: thisLine.breakStart))
                                }
                                HStack{
                                    Text("BREAK DURATION").font(.subheadline)
                                    Spacer()
                                    Text("[\(thisLine.breakDuration)]")

                                }
                            }
                        }
                    } else {
                        Text("No Shifts")
                            .foregroundColor(.secondary)
                    }
                }
               
            }
           
            
        }.navigationTitle("My Roster")
            .padding()
        
            .fullScreenCover(isPresented: $showAddShiftView){
                AddShiftView()
            }
    }
}

struct RosterListView_Previews: PreviewProvider {
    static var previews: some View {
        RosterListView(isLoggedIn: .constant(true)).environmentObject(MyDataModel())
    }
}
