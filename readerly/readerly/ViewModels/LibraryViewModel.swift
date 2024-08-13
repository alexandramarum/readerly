//
//  LibraryViewModel.swift
//  readerly
//
//  Created by Alexandra Marum on 8/6/24.
//

import SwiftUI
import SwiftData
import CoreData

class LibraryViewModel: ObservableObject {
    
    let tagColors = [
        "red": Color.red,
        "yellow": Color.yellow,
        "blue": Color.blue,
        "purple": Color.purple,
        "orange": Color.orange,
        "green": Color.green,
        "gray": Color.gray
    ]
    
    func addQuote(text: String, source: String, author: String, pages: String, context: ModelContext) {
        let quote = pages.isEmpty ? Quote(id: UUID(), text: text) : Quote(id: UUID(), text: text, pages: pages)
        if let source = addSource(title: source, author: author, context: context) {
            quote.source = source
        }
        context.insert(quote)
    }
    
    func addSource(title: String, author: String, context: ModelContext) -> Source? {
        // If no title or author is provided, return nil
           guard !title.isEmpty || !author.isEmpty else {
               return nil
           }
           
           // Create a new source with provided title and author
        let source = Source(title: title.isEmpty ? "Unknown" : title,
                               author: author.isEmpty ? "Unknown" : author)
           context.insert(source)
           return source
    }
    
    func deleteQuote(quote: Quote, context: ModelContext) {
        context.delete(quote)
        if let source = quote.source {
            if let quotes = source.quotes {
                if quotes.count == 1 {
                    deleteSource(source: source, context: context)
                }
            }
        }
        try? context.save()
    }
    
    func deleteSource(source: Source, context: ModelContext) {
        context.delete(source)
        try? context.save()
    }
}
