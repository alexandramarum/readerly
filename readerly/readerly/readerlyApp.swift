//
//  readerlyApp.swift
//  readerly
//
//  Created by Alexandra Marum on 7/30/24.
//

import SwiftUI
import SwiftData

@main
struct readerlyApp: App {
    @StateObject private var libraryVm = LibraryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(libraryVm)
                .modelContainer(for : [
                    Quote.self,
                    Source.self
                ])
        }
    }
}
