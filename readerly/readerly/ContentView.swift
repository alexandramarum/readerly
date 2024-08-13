//
//  ContentView.swift
//  readerly
//
//  Created by Alexandra Marum on 7/30/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        QuoteOfTheDayView()
    }
}

#Preview {
    ContentView()
}
