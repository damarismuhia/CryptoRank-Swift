//
//  ViewExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import SwiftUICore
import Combine


extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value).removeDuplicates()) { (value) in
                onChange(value)
            }
        }
    }
}
