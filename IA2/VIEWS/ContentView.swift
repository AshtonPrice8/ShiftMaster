//
//  ContentView.swift
//  IA2
//
//  Created by AJ on 13/3/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var myData:MyDataModel
    @State var me:Worker = MyDataModel().workers.first!
    
    
    @State var enteredPassword = ""
    
    @State var isLoggedIn = false
    @State var showPasswordAlert = false
    
    var body: some View {
        VStack(spacing:16){
            Text("Log In")
                .font(.largeTitle)
            
            Picker("Select person", selection: $me){
                ForEach(myData.workers){thisPerson in
                    Text(thisPerson.name).tag(thisPerson)
                }
            }
            SecureField("Password", text:$enteredPassword)
                .textFieldStyle(.roundedBorder)
            
            Button(action:{
                if enteredPassword == me.password {
                    //save me to the myData for access elsewhere...
                    myData.me = me
                    
                    //go to next view
                    isLoggedIn = true
                    
                } else {
                    showPasswordAlert = true
                }
            }){
                Text("Log In")
            }.buttonStyle(.bordered)
        }
        .padding()
        
        .onAppear{
            self.me = myData.workers.first!
        }
        .alert("Incorrect password, please try again.", isPresented: $showPasswordAlert){
            Button("OK", role: .cancel){}
        }
        .fullScreenCover(isPresented: $isLoggedIn){
            RosterListView(isLoggedIn: $isLoggedIn)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MyDataModel())
    }
}
