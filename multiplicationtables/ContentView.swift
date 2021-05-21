//
//  ContentView.swift
//  multiplicationtables
//
//  Created by Guadoo on 2021/5/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var matrixValue = 10
    let step = 1
    let range = 1...12
    
    @State private var questionNumber = 20
    
    @State private var tables = [(Int, Int)]()

    
    @State private var inputResult = ""
    @State private var adjustment = ""
    
    var body: some View {
       
        VStack {
            Section {
                Stepper(value: $matrixValue, in: range, step: step) {
                    Text("Multiplication Table is \(matrixValue) Up to 12 ")
                }
                .padding(10)

                Picker(selection: $questionNumber, label: Text("Please select question number")) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("All").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if tables.isEmpty {
                    Button(action: {
                        tables = multiplicationTable(matrixValue: matrixValue, questionNumber: questionNumber)
                        inputResult.removeAll()
                    }, label: {
                        Text("Start")
                    })
                        .padding()
                } else {
                    Text("Please complete the questions!")
                        .padding()
                }
            }
            
            HStack{
                if tables.isEmpty {
                    Text("? X ? = ?")
                } else {
                    Text("\(tables.first!.0) X \(tables.first!.1) = ")
                    Text(inputResult)
                }
            }
            Text(adjustment)
            
            VStack {
                HStack{
                    Button("1") {
                        inputResult += "1"
                    }.padding()
                    Button("2") {
                        inputResult += "2"
                    }.padding()
                    Button("3") {
                        inputResult += "3"
                    }.padding()
                }
                HStack{
                    Button("4") {
                        inputResult += "4"
                    }.padding()
                    Button("5") {
                        inputResult += "5"
                    }.padding()
                    Button("6") {
                        inputResult += "6"
                    }.padding()
                }
                HStack{
                    Button("7") {
                        inputResult += "7"
                    }.padding()
                    Button("8") {
                        inputResult += "8"
                    }.padding()
                    Button("9") {
                        inputResult += "9"
                    }.padding()
                }
                HStack{
                    Button("D") {
                        if inputResult.count > 0 {
                            inputResult.removeLast()
                        }
                    }.padding()
                    Button("0") {
                        inputResult += "0"
                    }.padding()
                    Button("=") {
                        if tables.isEmpty {
                            inputResult.removeAll()
                        } else {
                            if Int(inputResult) == tables.first!.0 * tables.first!.1 {
                                inputResult.removeAll()
                                tables.removeFirst()
                                adjustment = ""
                            } else {
                                inputResult.removeAll()
                                adjustment = "X"
                            }
                        }
                    }.padding()
                }
            
                Text("Rest Questions : \(tables.count)")
            }
        }
    }
    
    
    // Generate multiplication table and shuffled it
     func multiplicationTable(matrixValue: Int, questionNumber: Int) -> [(Int, Int)] {
        
        var multiplicationTables = [(Int, Int)]()
        var outputTables = [(Int,Int)]()
        
        for number1 in 1...matrixValue {
            for number2 in 1...matrixValue {
                multiplicationTables.insert((number1, number2), at: 0)
            }
        }
        
        multiplicationTables.shuffle()
        
        // If table element less than question number or question number = 0, then display all table elements
        // Else just display the elements by question number
        if multiplicationTables.count < questionNumber || questionNumber == 0 {
            outputTables = multiplicationTables
        } else {
            for _ in 0 ..< questionNumber {
                outputTables.insert(multiplicationTables.first!, at: 0)
                multiplicationTables.removeFirst()
            }
        }

        return outputTables.shuffled()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


