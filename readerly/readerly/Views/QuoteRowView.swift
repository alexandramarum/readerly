//
//  QuoteRowView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/8/24.
//

import SwiftUI

struct QuoteRowView: View {
    var quote: String
    var title: String
    var author: String
    var pages: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\"\(quote)\"")
                .font(.title)
            Text("\(author)")
            Text("\(title)")
                .italic()
                .bold()
        }
    }
}

#Preview {
    QuoteRowView(quote: "To be or not to be. That is the question. I don't know how to conitnue living like this. I don't think I want to.", title: "Hamlet", author: "William Shakespeare", pages: "1-30")
}
