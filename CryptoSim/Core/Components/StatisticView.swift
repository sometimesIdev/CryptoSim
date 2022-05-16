//
//  StatisticView.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-06.
//

import SwiftUI

struct StatisticView: View {
  
  let stat: Statistics
  
    var body: some View {
      VStack(alignment: .leading, spacing: 4) {
        Text(stat.title)
          .font(.caption)
          .foregroundColor(.theme.secondaryText)
        
        Text(stat.value)
          .font(.headline)
          .foregroundColor(.theme.accent)
        
        HStack(spacing: 4) {
          Image(systemName: "triangle.fill")
            .font(.caption2)
            .rotationEffect(
              Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
          Text(stat.percentageChange?.asPercentString() ?? "")
            .font(.caption)
          .bold()
        }
        .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
      }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        StatisticView(stat: dev.stat3)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
        StatisticView(stat: dev.stat2)
          .previewLayout(.sizeThatFits)
        StatisticView(stat: dev.stat1)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    }
}
