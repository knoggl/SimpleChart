//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/SimpleChart
//

import SwiftUI
import SwiftPlus

/// Returns a Chart View
public struct Chart: View {
    
    public enum ChartType {
        case bar(_ spacing: Double = 8, withSidebar: Bool = true)
    }
    
    var data: Array<ChartData>
    var type: ChartType
    var height: Double
    var color: Color
    var showValue: Bool
    var backgroundColor: Color
    var showBorderLines: Bool
    
    /// - Parameters:
    ///   - data: The `ChartData` array
    ///   - type: The `ChartType`, default is `.bar()`
    ///   - height: The chart height, default is `250`
    ///   - color: The representation color, default is `.green`
    ///   - showValue: Should the value be shown?, default is `true`
    ///   - backgroundColor: The backgroundColor for the unfilled area, default is `.gray.opacity(0.14)`
    ///   - showBorderLines: Should the top and bottom line indicator be shown?, default is `true`
    public init(_ data: Array<ChartData>,
         type: ChartType = .bar(),
         height: Double = 250,
         color: Color = .green,
         showValue: Bool = true,
         backgroundColor: Color = .gray.opacity(0.14),
         showBorderLines: Bool = true
    ) {
        self.data = data
        self.type = type
        self.height = height
        self.color = color
        self.showValue = showValue
        self.backgroundColor = backgroundColor
        self.showBorderLines = showBorderLines
    }
    
    public var body: some View {
        VStack {
            switch type {
            case .bar(let spacing, let withSidebar):
                barChart(spacing, withSidebar: withSidebar)
            }
        }
        .frame(height: height)
    }
    
    private func barChart(_ spacing: Double, withSidebar: Bool) -> some View {
        VStack(spacing: 0) {
            if showBorderLines {
                Divider()
            }
            
            HStack {
                if withSidebar {
                    VStack {
                        Text(data.max.stringRepresentation)
                        Spacer()
                        Text(Double(data.max / 2).stringRepresentation)
                        Spacer()
                        Text("0")
                    }
                    .padding(4)
                    
                    Divider()
                }
                
                HStack(spacing: spacing) {
                    ForEach(data, id: \.id) { _data in
                        BarChart(_data, allData: data, chartHeight: height, color: color, showValue: showValue, backgroundColor: backgroundColor)
                    }
                }
            }
            
            if showBorderLines {
                Divider()
            }
        }
        .font(.caption2)
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 16) {
                Chart([
                    ChartData(label: "Mon", value: 300.34),
                    ChartData(label: "Tue", value: 93),
                    ChartData(label: "Wed", value: 634),
                    ChartData(label: "Thu", value: -82.1),
                    ChartData(label: "Fri", value: 380),
                    ChartData(label: "Sat", value: 222),
                    ChartData(label: "Sun", value: 132)
                ])
                
                Chart([
                    ChartData(label: "Mon", value: 300.34),
                    ChartData(label: "Tue", value: 93),
                    ChartData(label: "Wed", value: 634),
                    ChartData(label: "Thu", value: -82.1),
                    ChartData(label: "Fri", value: 380),
                    ChartData(label: "Sat", value: 222),
                    ChartData(label: "Sun", value: 132, overrideColor: .blue)
                ], height: 120, color: .cyan, showBorderLines: false)
                
                Chart([
                    ChartData(label: "Mon", value: 300.34, overrideColor: .cyan),
                    ChartData(label: "Tue", value: 93, overrideColor: .secondary),
                    ChartData(label: "Wed", value: 634, overrideColor: .red),
                    ChartData(label: "Thu", value: -82.1),
                    ChartData(label: "Fri", value: 380, overrideColor: .pink),
                    ChartData(label: "Sat", value: 222, overrideColor: .gray),
                    ChartData(label: "Sun", value: 132, overrideColor: .mint)
                ], type: .bar(2, withSidebar: false), showBorderLines: false)
            }
            .padding()
        }
    }
}
