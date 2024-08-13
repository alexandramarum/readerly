//
//  HomeNavView.swift
//  readerly
//
//  Created by Alexandra Marum on 8/6/24.
//

import SwiftUI

struct HomeNavView: View {
    var body: some View {
        TabView {
            NavigationStack {
                QuoteView()
            }
                .tabItem {
                    Image(systemName: "message")
                    Text("Quotes")
                }
            CameraPromptView(scannedText: "", viewTitle: "Create", title: "", author: "", pages: "")
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add Quote")
                }
            LibraryView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Library")
                }
        }
    }
}

#Preview {
    HomeNavView()
}
