//
//  AddShiftView.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import SwiftUI

struct AddShiftView: View {
    @EnvironmentObject var myData:MyDataModel
    @State var selectedPersonIndex = 0
    @State var selectedStartDate = Date()
    @State var selectedFinishDate = Date()
    @State var selectedBreakStart = Date()
    @State var selectedBreakDuration = "No Break"
    let breakList = ["No Break", "15 min", "30 min", "45 min", "1 hour"]
    
    @Environment(\.dismiss) var dismissMe
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button(action:{
                        dismissMe()
                    }){
                        Text("< Back to Roster View")
                    }.buttonStyle(.bordered)
                    
                    Spacer()
                }
                
                Text("Add Shift")
                    .font(.largeTitle)
                    
                Form{
                    Section ("Select Employee"){
                        Picker("", selection: $selectedPersonIndex){
                            ForEach(myData.workers){thisPerson in
                                HStack{
                                    Text(thisPerson.name)
                                    Spacer()
                                    Text(thisPerson.position)
                                }.tag(myData.workers.firstIndex(where: {$0.id == thisPerson.id})!)
                            }
                        }.pickerStyle(.navigationLink)
                    }
                    Section("Shift Details"){
                        DatePicker("Start", selection: $selectedStartDate)
                        DatePicker("End", selection: $selectedFinishDate)
                        DatePicker("Break", selection: $selectedBreakStart)
                        Picker("Break Duration", selection: $selectedBreakDuration){
                            ForEach (breakList, id:\.self) {thisBreak in
                                Text(thisBreak)
                            }
                        }
                    }
                    Section{
                        Button(action:{
                            let thisShift = Shift(
                                startTime: selectedStartDate,
                                endTime: selectedFinishDate,
                                breakStart: selectedBreakStart,
                                breakDuration: selectedBreakDuration)
                            
                            myData.roster.append(thisShift)
                            
                            dismissMe()
                        }){
                            HStack{
                                Spacer()
                                Text("💾 Save Shift")
                                Spacer()
                            }
                        }
                    }
                }
               
            }
           
            
        }.navigationTitle("My Roster")
            .padding()
    }
}

struct AddShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AddShiftView().environmentObject(MyDataModel())
    }
}
