//
//  SourceRowView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/7/24.
//

import SwiftUI
import SwiftData

struct SourceRowView: View {
    var title: String
    var author: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            Text("by \(author)")
                .italic()
        }
    }
}

#Preview {
    SourceRowView(title: "Hamlet", author: "Shakespeare")
}
