//
//  ContentView.swift
//  WeSplit
//
//  Created by Sit, Johnny on 2/25/23.
//

import SwiftUI

struct ContentView: View {
    // State: Allows values to be changed and reflected in UI
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 15
    @State var taxPercentage = 0.08875
    let tipPercentages = [10, 15, 20, 25, 0]

    // FocusState to use for keyboard dismissal
    @FocusState private var amountIsFocused: Bool
    @FocusState private var taxIsFocused: Bool
    @FocusState private var tipIsFocused: Bool

    var currencyFormat: String = Locale.current.currency?.identifier ?? "USD"

    // Computed value
    var tipAmount: Double {
        (checkAmount / 100) * Double(tipPercentage)
    }

    var totalWithTaxAndTip: Double {
        let taxAmt = checkAmount * taxPercentage

        let checkTotal = checkAmount + tipAmount + taxAmt

        return checkTotal
    }

    var totalPerPerson: Double {
        let numPeople = Double(2 + numberOfPeople)

        let checkSplitAmt = totalWithTaxAndTip / numPeople

        return checkSplitAmt
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    // $ denotes that value can be read and set
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyFormat))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Pre-tax amount")
                }

                Section {
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0)")
                        }
                    }
                }

                Section {
                    TextField("Tax Percentage", value: $taxPercentage, format: .percent)
                        .focused($taxIsFocused)
                } header: {
                    Text("Tax Percentage")
                }

                Section {
                    TextField("Tip Percentage", value: $tipPercentage, format: .percent)
                        .focused($tipIsFocused)
                } header: {
                    Text("Tip Percentage")
                }

                Section {
                    Text(tipAmount, format: .currency(code: currencyFormat))
                } header: {
                    Text("Tip Amount")
                }

                Section {
                    Text(totalWithTaxAndTip, format: .currency(code: currencyFormat))
                } header: {
                    Text("Total with Tax + Tip")
                }

                Section {
                    // Initial text can be computed function or placeholder
                    Text(totalPerPerson, format: .currency(code: currencyFormat))
                } header: {
                    Text("Total Per Person")
                }

                // Title of nav
            }.navigationTitle("WeSplit")
                // Makes font smaller
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        // puts done on the right side
                        Spacer()

                        // When Done is pressed, set the values to false
                        Button("Done") {
                            amountIsFocused = false
                            taxIsFocused = false
                            tipIsFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// EXAMPLE CODE:
// struct ContentView: View {
//    @State private var tapCount = 0
//    @State private var name = ""
//
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Enter your name", text: $name)
//                Text("Hello, \(name)!")
//
//                Button("Tap Count: \(tapCount)") {
//                    tapCount += 1
//                }
//
//                Picker("Select your student", selection: $selectedStudent) {
//                    ForEach(students, id: \.self) {
//                        Text($0)
//                    }
//                }
//
//            }.navigationTitle("SwiftUI").navigationBarTitleDisplayMode(.inline)
//        }
//    }
// }
