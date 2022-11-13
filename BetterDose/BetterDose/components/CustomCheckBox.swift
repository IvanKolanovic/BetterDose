//
//  CustomCheckBox.swift
//  BetterDose
//
//  Created by bit4bytes on 13.11.2022..
//

import SwiftUI

struct CustomCheckBox: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
