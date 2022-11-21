//
//  Home.swift
//

import SwiftUI
import Charts

struct Home: View {
    //MARK: State Chart Data for Animation Changes
    @State var sampleAnalytics: [SiteView] = sample_analytics
    @State var currentTab: String = "7 Days"
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Views")
                            .fontWeight(.semibold)
                        
                        Picker("", selection: $currentTab) {
                            Text("7 Days")
                                .tag("7 Days")
                            Text("Week")
                                .tag("Week")
                            Text("Month")
                                .tag("Month")
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    let totalValue = sampleAnalytics.reduce(0.0) { partialResult, item in item.views + partialResult } ?? 0.0
                    
                    Text(totalValue.stringFormat)
                        .font(.largeTitle.bold())
                    
                    AnimatedChart()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
            .onChange(of: currentTab) { newValue in
                sampleAnalytics = sample_analytics
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart() -> some View {
        let max = sampleAnalytics.max { item1, item2 in return item2.views > item1.views }?.views ?? 0
        
        Chart {
            ForEach(sampleAnalytics) { item in
                //MARK: bar graph
                //MARK: Animation graph
                BarMark (
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Views", item.animate ? item.views : 0)
                )
            }
        }
        //MARK: Customizing Y-Axis Length
        .chartYScale(domain: 0...(max + 10000))
        .frame(height: 250)
        .onAppear {
            for (index, _) in sampleAnalytics.enumerated() {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                    withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                        sampleAnalytics[index].animate = true
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension Double {
    var stringFormat: String {
        if self >= 1000 && self < 999999 {
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", self / 1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "0.f", self)
    }
}
