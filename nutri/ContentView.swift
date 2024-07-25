//
//  ContentView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    struct RatioContainer<Content: View>: View {
        let heightRatio:CGFloat
        let content: Content
        
        init(heightRatio:CGFloat = 0.5,@ViewBuilder content: () -> Content) {
            self.heightRatio = heightRatio
            self.content = content()
        }
        
        var body: some View {
            GeometryReader { geo in
                VStack {
                    Spacer()
                    content.frame(width: geo.size.width, height: geo.size.height*heightRatio, alignment: .center)
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            TodayNutrientsView()
                .tabItem { Text("Nutrition Today") }
                .tag(1)
            
            ScannerView()
                .tabItem { Text("Log Food") }
                .tag(2)
        }
    }
}

#Preview {
    let nutriModel = TodayNutritionViewModel()
    ContentView()
        .environment(nutriModel)
}
