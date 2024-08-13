//
//  ChooseSourceSheet.swift
//  readerly
//
//  Created by Alexandra Marum on 8/4/24.
//

import SwiftData
import SwiftUI

struct ChooseSourceSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query var sources: [Source]
    @Binding var source: String
    @Binding var author: String

    var body: some View {
        VStack {
            List(sources) { item in
                Button {
                    source = item.title
                    author = item.author
                    dismiss()
                } label: {
                    SourceRowView(title: item.title, author: item.author)
                }
            }
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ChooseSourceSheet(source: .constant("Romeo & Juliet"), author: .constant("William Shakespeare"))
}
