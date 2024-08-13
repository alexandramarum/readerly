//
//  CameraPromptView.swift
//  readerly
//
//  Created by Alexandra Marum on 7/31/24.
//

import PhotosUI
import SwiftUI
import VisionKit
import SwiftData

struct CameraPromptView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var libraryVm: LibraryViewModel
    // quote
    @StateObject var imagePicker = ImagePicker()
    @State var scannedText: String = ""
    @FocusState var focusState: Bool
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    // information
    @State var viewTitle: String = "Create"
    @State var title: String = ""
    @State var author: String = ""
    @State var pages: String = ""
    @State private var isShowing = false
    @FocusState private var areTextFieldsFocused: Bool
    @State private var tags: [Tag] = []
    // view state
    @State var quote: Quote?

    var body: some View {
        VStack {
            Text("\(viewTitle) Quote")
                .font(.largeTitle)
                .bold()
                .padding(-60)
            ScrollView {
                VStack {
                    TextEditor(text: $scannedText)
                        .frame(height: 200)
                        .border(Color.gray)
                        .focused($focusState)
                    HStack {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            Button {
                                showCamera.toggle()
                                focusState = false
                            } label: {
                                Image(systemName: "camera")
                                    .bold()
                                    .padding(-5)
                                Text("Take Photo")
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Text("Unavailable")
                        }
                        Text("OR")
                            .bold()
                        if ImageAnalyzer.isSupported {
                            PhotosPicker(selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared()) {
                                Image(systemName: "photo")
                                    .bold()
                                    .padding(-5)
                                Text("Choose Image")
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Text("Unavailable")
                        }
                    }
                    .padding(.top)
                    .padding(.bottom)
                    
                    Section("Information") {
                        Button {
                            isShowing.toggle()
                        } label: {
                            Image(systemName: "book")
                                .bold()
                                .padding(-5)
                            Text("Choose Source")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        HStack {
                            TextField("Add title", text: $title)
                                .padding(5)
                                .border(.secondary)
                                .focused($areTextFieldsFocused)
                        }
                        
                        HStack {
                            TextField("Add author", text: $author)
                                .padding(5)
                                .border(.secondary)
                        }
                        HStack {
                            TextField("Add pages, i.e. 30-32", text: $pages)
                                .padding(5)
                                .border(.secondary)
                        }
                    }
                }
                
                Section("Tags") {
                    HStack {
                        ForEach(tags) { tag in
                            TagItemView(color: libraryVm.tagColors[tag.color] ?? Color.gray, title: tag.title)
                        }
                    }
                }
                
                Spacer()
            }
            Button {
                if let quote = quote {
                    quote.text = formattedText(string: scannedText)
                    quote.pages = pages
                    quote.source?.title = title
                    quote.source?.author = author
                    dismiss()
                } else {
                    libraryVm.addQuote(text: formattedText(string: scannedText), source: title, author: author, pages: pages, context: context)
                }
                scannedText = ""
                title = ""
                author = ""
                pages = ""
                // TODO: add focus state to turn off keyboard
            } label: {
                Text("Submit")
            }
            .disabled(isInvalid(string: scannedText))
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .sheet(isPresented: $showCamera) {
            CameraViewController(image: $capturedImage)
        }
        .sheet(item: $imagePicker.imageToScan) { imageToScan in
            CameraTextfFromImageView(imageToScan: imageToScan.image, scannedText: $scannedText)
        }
        .sheet(isPresented: $isShowing) {
            ChooseSourceSheet(source: $title, author: $author)
        }
        .onChange(of: capturedImage) { newImage in
            if let newImage = newImage {
                imagePicker.imageToScan = ImageToScan(image: newImage)
            }
        }
        .onAppear {
            if let quote = quote {
                
            }
        }
    }
    
    func isInvalid(string: String) -> Bool {
        // TODO: additional conditions:
        // 1. Must contain alphabetic characters
        for char in string {
            if (char.lowercased() >= "a" && char.lowercased() <= "z") {
                return false
            }
        }
        return true
    }
    
    func formattedText(string: String) -> String {
        var formatted = string
        // TODO: format scanned Text for submission
        // 1. remove quotations if they are present at the beginning or end of the string.
        if (string.first == "\"" || string.first == "\'") {
            formatted = String(formatted.dropFirst())
        }
        if (string.last == "\"" || string.last == "\'") {
            formatted = String(formatted.dropLast())
        }
        // 2. remove empty space at the beginning or end of the string
        while formatted.first == " " || formatted.first == "\n" {
            formatted = String(formatted.dropFirst())
        }
        while formatted.last == " " || 
            formatted.last == "\n" {
            formatted = String(formatted.dropLast())
        }
        return formatted
    }
}

#Preview {
    CameraPromptView(scannedText: "", viewTitle: "Create", title: "", author: "", pages: "")
}
