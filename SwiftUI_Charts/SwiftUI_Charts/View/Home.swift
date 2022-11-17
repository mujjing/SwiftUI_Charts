//
//  Home.swift
//

import SwiftUI
import Charts

struct Home: View {
    var body: some View {
        NavigationStack {
            VStack {
                AnimatedChart()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
        }
    }
    
    @ViewBuilder
    func AnimatedChart() -> some View {
        Chart {
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
