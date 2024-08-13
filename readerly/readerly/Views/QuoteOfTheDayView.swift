//
//  QuoteOfTheDayView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/6/24.
//

import SwiftUI
import SwiftData

struct QuoteOfTheDayView: View {
    @Query var quotes: [Quote]
    @State private var qotd: Quote?
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                if quotes.isEmpty {
                    Text("You have no quotes...")
                        .font(.title)
                } else {
                    if let qotd = qotd {
                        Text(qotd.text)
                            .font(.title)
                    }
                    Button {
                        newQuote()
                    } label: {
                        HStack {
                            Image(systemName: "shuffle")
                                .bold()
                                .padding(-5)
                            Text("Shuffle")
                                .bold()
                        }
                    }
                }
                Spacer()
                NavigationLink {
                    HomeNavView()
                } label: {
                    HStack {
                        Text("Proceed to App")
                        Image(systemName: "chevron.right")
                    }
                    .font(.title3)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Quote of the Day")
        }
        .onAppear {
               newQuote()
           }
    }
    
    private func newQuote() {
        if let quote = quotes.randomElement() {
            qotd = quote
        }
    }
}

#Preview {
    QuoteOfTheDayView()
}
