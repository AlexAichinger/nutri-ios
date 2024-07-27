//
//  ScannerView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI
import SwiftData
import VisionKit

struct ScannerView: View {
    @Environment(TodayNutritionViewModel.self) private var vm
    @Environment(\.modelContext) private var modelContext
    @State var scannedText: String = ""
    @State private var eaten = 50
    @State private var barcode = "20083892"
    @State private var selectedOption: MealType = .LUNCH
    @State private var eatenAt: Date = Date.now
    @State private var isPerformingTask = false
    
    var body: some View {
        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            VStack{
                if scannedText.isEmpty {
                    ZStack(alignment: .bottom) {
                        DataScannerRepresentable(
                            scannedText: $scannedText,
                            dataToScanFor: [.barcode()]
                        )
                    }.background(Color.black)
                }
                TextField("leave for testing", text: $scannedText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .submitLabel(.next)
                
                TextField("Enter in grams how much was eaten", value: $eaten, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .submitLabel(.next)
                
                Picker("Meal", selection: $selectedOption) {
                    ForEach(MealType.allCases) { option in
                        Text(String(describing: option))
                        
                    }
                }
                .pickerStyle(.wheel)
                
                DatePicker("Please enter a date", selection: $eatenAt)
                
                AsyncButtonView(action: {
                    let code = if(scannedText.isEmpty) {barcode} else { scannedText }
                    scannedText = ""
                    await vm.sendMealLog(
                        mealType: selectedOption,
                        eatenInGrams: eaten,
                        loggingDate: eatenAt,
                        barcode: code
                    )
                    await vm.getTodaysNutrients(modelContext: modelContext)
                }, label: {
                    Image(systemName: "hand.thumbsup.fill")
                })
                .disabled(false)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(Color.red)
        } else if !DataScannerViewController.isSupported {
            Text("It looks like this device doesn't support the DataScannerViewController")
            TextField("leave for testing", text: $scannedText)
                .textFieldStyle(.roundedBorder)
                .padding()
                .submitLabel(.next)
            
            TextField("Enter in grams how much was eaten", value: $eaten, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
                .submitLabel(.next)
            
            Picker("Meal", selection: $selectedOption) {
                ForEach(MealType.allCases) { option in
                    Text(String(describing: option))
                    
                }
            }
            .pickerStyle(.wheel)
            
            DatePicker("Please enter a date", selection: $eatenAt)
            
            AsyncButtonView(action: {
                let code = if(scannedText.isEmpty) {barcode} else { scannedText }
                scannedText = ""
                await vm.sendMealLog(
                    mealType: selectedOption,
                    eatenInGrams: eaten,
                    loggingDate: eatenAt,
                    barcode: code
                )
                await vm.getTodaysNutrients(modelContext: modelContext)
            }, label: {
                Image(systemName: "hand.thumbsup.fill")
            })
            .disabled(false)
        } else {
            Text("It appears your camera may not be available")
        }
    }
}

#Preview {
    let nutriModel = TodayNutritionViewModel()
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NutritionData.self, configurations: config)
    ScannerView()
        .environment(nutriModel)
        .modelContainer(container)
}
