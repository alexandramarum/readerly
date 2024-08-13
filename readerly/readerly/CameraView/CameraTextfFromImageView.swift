//
//  CameraTextfFromImageView.swift
//  readerly
//
//  Created by Alexandra Marum on 7/31/24.
//

import SwiftUI

struct CameraTextfFromImageView: View {
    @Environment(\.dismiss) var dismiss
    private let pasteboard = UIPasteboard.general
    let imageToScan: UIImage
    @Binding var scannedText: String
    
    @State private var currentPasteboard = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                LiveTextUIImageView(image: imageToScan)
                Text("Select and copy text")
                Button("Dismiss") {
                    if let string = pasteboard.string {
                        if !string.isEmpty {
                            scannedText = string
                        }
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Copy Text")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                pasteboard.string = ""
            }
        }
    }
}

#Preview {
    CameraTextfFromImageView(imageToScan: UIImage(), scannedText: .constant(""))
}
