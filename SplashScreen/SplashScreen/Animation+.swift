//
//  Animation+.swift


import SwiftUI

extension Animation {
    func `repeatForever`(while expression: Binding<Bool>, autoreverses: Bool = true) -> Animation {
        if expression.wrappedValue {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
