//
//  DataModel.swift
//  IA2
//
//  Created by Oliver Baumeister on 13/3/2023.
//

import Foundation

class MyDataModel:ObservableObject{
    
    init(){
        self.workers = loadWorkers()
        self.payRates = loadPays()
    }
    //MARK: ROSTER
    @Published var roster = [Shift]()
    
    //MARK: ME
    @Published var me:Worker = Worker(name: "", age: "", position: "")
    
    //MARK: WORKERS
    @Published var workers = [Worker]()
    
    private func loadWorkers() -> [Worker] {
        var listOfWorkers = [Worker]()
        
        //locate the CSV file
        guard let filePath = Bundle.main.path(forResource: "Workers", ofType: "csv") else{
            print("Error: File not found.")
            return[]
        }
        
        //convert the contents of the file into one very long string
        var data = ""
        do{
            data = try String(contentsOfFile: filePath)
        } catch{
            print(error)
            return[]
        }
        
        //clean up the \r \n occurences
        data = cleanRows(file: data)
        
        //split the long string into an array of "rows" of data. Each row is a string
        //detect "/n" carraige return, then split
        var rows = data.components(separatedBy: "\n")
        
        //remove header rows
        //count the number of header columns before removing
        let columnCount = rows.first?.components(separatedBy: ",").count
        rows.removeFirst()
        
        //now loop around each row and split into columns
        for row in rows {
            let csvColumns = row.components(separatedBy: ",")
            if csvColumns.count == columnCount {
                
                let thisWorker = Worker(name: csvColumns[0], age: csvColumns[1], position: csvColumns[2])
                listOfWorkers.append(thisWorker)
                
            } else if csvColumns.count == (columnCount!+1) {
                
                //handle owner having two jobs
                let thisWorker = Worker(name: csvColumns[0], age: csvColumns[1], position: "\(csvColumns[2]), \(csvColumns[3])")
                listOfWorkers.append(thisWorker)
                
            }
        }
        
        return listOfWorkers
    }
    //MARK: PayRates
    @Published var payRates = [PayRate]()
    
    private func loadPays() -> [PayRate] {
        var listOfPayRates = [PayRate]()
        
        //locate the CSV file
        guard let filePath = Bundle.main.path(forResource: "PayRates", ofType: "csv") else{
            print("Error: File not found.")
            return[]
        }
        
        //convert the contents of the file into one very long string
        var data = ""
        do{
            data = try String(contentsOfFile: filePath)
        } catch{
            print(error)
            return[]
        }
        
        //clean up the \r \n occurences
        data = cleanRows(file: data)
        
        //split the long string into an array of "rows" of data. Each row is a string
        //detect "/n" carraige return, then split
        var rows = data.components(separatedBy: "\n")
        
        //remove header rows
        //count the number of header columns before removing
        let columnCount = rows.first?.components(separatedBy: ",").count
        rows.removeFirst()
        
        //now loop around each row and split into columns
        for row in rows {
            let csvColumns = row.components(separatedBy: ",")
            if csvColumns.count == columnCount {
                
                let thisRate = PayRate(name: csvColumns[0], rate: csvColumns[1])
                listOfPayRates.append(thisRate)
                
            }
        }
        
        return listOfPayRates
    }
}
