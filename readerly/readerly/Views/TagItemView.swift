//
//  TagItemView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/13/24.
//

import SwiftUI

struct TagItemView: View {
    var color: Color
    var title: String
    
    var body: some View {
        Text(title)
            .bold()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(color)
                    .opacity(0.3)
            )
    }
}

#Preview {
    TagItemView(color: Color.red, title: "Angry")
}
