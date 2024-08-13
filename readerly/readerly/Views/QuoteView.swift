//
//  QuoteView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/6/24.
//

import SwiftData
import SwiftUI

struct QuoteView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var libraryVm: LibraryViewModel
    @Query var quotes: [Quote]

    var body: some View {
        VStack {
            if quotes.isEmpty {
                Text("You have no quotes...")
            } else {
                List {
                    ForEach(quotes) { quote in
                        NavigationLink(destination: CameraPromptView(scannedText: quote.text, viewTitle: "Edit", title: quote.source?.title ?? "Unknown", author: quote.source?.author ?? "Unknown", pages: quote.pages ?? "", quote: quote)) {
                            QuoteRowView(quote: quote.text, title: quote.source?.title ?? "Unknown", author: quote.source?.author ?? "Unknown", pages: quote.pages ?? "")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.map { quotes[$0] }.forEach { quote in
                            libraryVm.deleteQuote(quote: quote, context: context)
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuoteView()
            .environmentObject(LibraryViewModel())
    }
}
