//
//  Models.swift
//  readerly
//
//  Created by Alexandra Marum on 8/3/24.
//

import Foundation
import SwiftData


@Model
class Quote {
    var id: UUID
    var text: String
    weak var source: Source?
    var tags: [Tag]?
    var pages: String?
    
    init(id: UUID, text: String, source: Source? = nil, tags: [Tag]? = nil, pages: String? = nil) {
        self.id = id
        self.text = text
        self.source = source
        self.tags = tags
        self.pages = pages
    }
    
    static let example = Quote(id: UUID(), text: "To be or not to be", tags: [Tag.example], pages: "20-40")
}

@Model
class Source {
    @Attribute(.unique) var title: String
    var author: String
    var quotes: [Quote]? // Maybe add cascade delete here
    
    init(title: String, author: String, quotes: [Quote]? = nil) {
        self.title = title
        self.author = author
        self.quotes = quotes
    }
    
    static let example = Source(title: "Hamlet", author: "William Shakespeare", quotes: [Quote.example])
}

@Model
class Tag {
    @Attribute(.unique) var title: String
    var descript: String?
    var color: String
    
    init(title: String, descript: String? = nil, color: String) {
        self.title = title
        self.descript = descript
        self.color = color
    }
    
    static let example = Tag(title: "Motivational", descript: "To brighten my day", color: "yellow")
}
