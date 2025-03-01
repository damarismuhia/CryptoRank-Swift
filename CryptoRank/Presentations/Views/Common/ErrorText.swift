//
//  ErrorText.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import SwiftUI

struct ErrorText: View {
    let errMsg: String
    var body: some View {
        Text(errMsg)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    ErrorText(errMsg: "ERRRRR")
}
