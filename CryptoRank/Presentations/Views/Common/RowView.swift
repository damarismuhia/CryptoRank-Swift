//
//  RowView.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 26/02/2025.
//

import SwiftUI


struct RowView: View {
    let title: String
    let value: String
    var textColor: Color = .primary
    
    var body: some View {
        HStack {
            Text(title)
                .font(.sourceSanRegular())
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.sourceSanMedium())
                .foregroundColor(textColor)
        }
    }
}
#Preview {
    RowView(title: "Current Price:", value: "$769.57", textColor: .green)
}

