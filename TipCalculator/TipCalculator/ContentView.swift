//
//  ContentView.swift
//  TipCalculator
//
//  Created by Ben Scheirman on 6/14/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State private var totalInput: Double? = 18.94
    @State private var selectedTipPercentage = 1
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        f.isLenient = true
        f.numberStyle = .currency
        return f
    }()
    
    private let tipPercentages = [0.15, 0.2, 0.25]
    
    private let percentageFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        return f
    }()
    
    private var tipAmount: Double {
        let total = totalInput ?? 0
        let tipPercent = tipPercentages[selectedTipPercentage]
        return total * tipPercent
    }
    
    private var formattedTipAmount: String {
        currencyFormatter.string(for: tipAmount) ?? "--"
    }
    
    private var finalTotal: Double {
        (totalInput ?? 0) + tipAmount
    }
    
    private var formattedFinalTotal: String {
        currencyFormatter.string(from: finalTotal) ?? "--"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()

                TextField("Total", value: $totalInput, formatter: currencyFormatter)
                    .font(.largeTitle)
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                segmentedTipPercentages
                    .padding()
                
                Divider()
                
                summaryLine(label: "Tip:", amount: formattedTipAmount, color: .gray)
                summaryLine(label: "Total:", amount: formattedFinalTotal, color: .green)
                
                
                Spacer()
            }
            .background(Color(white: 0.85, opacity: 1.0))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Tip Calculator"))
        }
    }
    
    private func summaryLine(label: String, amount: String, color: Color) -> some View {
        HStack {
            Spacer()
            Text(label)
                .font(.title)
                .foregroundColor(color)
            Text(amount)
                .font(.title)
                .foregroundColor(color)
            }.padding(.trailing)
    }
    
    private var segmentedTipPercentages: some View {
        Picker(selection: $selectedTipPercentage, label: Text("")) {
            ForEach(0..<tipPercentages.count) { index in
                Text(self.formatPercent(self.tipPercentages[index])).tag(index)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    private func formatPercent(_ p: Double) -> String {
        percentageFormatter.string(for: p) ?? "-"
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
