//
//  LibraryView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/6/24.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Query var sources: [Source]
    
    var body: some View {
        VStack(alignment: .leading){
            if sources.isEmpty {
                Text("Your library is empty...")
            } else {
                List {
                    ForEach(sources) { source in
                        SourceRowView(title: source.title, author: source.author)
                    }
                }
            }
        }
    }
}

#Preview {
    LibraryView()
}
