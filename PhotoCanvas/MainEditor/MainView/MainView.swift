//
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

enum ActiveAlert: Identifiable {
    case delete, save

    var id: Int {
        hashValue
    }
}

struct MainView: View {
    @State private var image: UIImage?
    @State private var showSelection = false
    @State private var pickerSourceType: UIImagePickerController.SourceType?
    @State private var ciFileterShow = false
    @State private var mgRShow = false
    @State private var textShow = false
    @State private var penShow = false
    @State private var activeAlert: ActiveAlert?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("No image")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding()
                        .overlay {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                }
                
                Spacer()
                
                toolBar
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if image != nil {
                        Button {
                            activeAlert = .delete
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if let image {
                        ShareImage(image: image)
                        .padding()
                    }
                }
            }
        }
        .alert(item: $activeAlert) { alert in
            switch alert {
            case .delete:
                return Alert(
                    title: Text("Delete Photo"),
                    message: Text("Are you sure you want to delete this photo?"),
                    primaryButton: .destructive(Text("Delete")) {
                        withAnimation {
                            image = nil
                        }
                    },
                    secondaryButton: .cancel()
                )
            case .save:
                return Alert(
                    title: Text("Save Photo"),
                    message: Text("Do you want to save this image to your gallery?"),
                    primaryButton: .default(Text("Save")) {
                        if let image {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .confirmationDialog(
            "Select source",
            isPresented: $showSelection,
            titleVisibility: .visible
        ) {
            Button("Take a photo") {
                pickerSourceType = .camera
            }
            Button("Choose from gallery") {
                pickerSourceType = .photoLibrary
            }
        }

        .fullScreenCover(item: $pickerSourceType) { type in
            UIImagePickerRepresentable(
                sourceType: type,
                selectedImage: $image
            )
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $ciFileterShow) {
            if let selectedImage = Binding($image) {
                ImageEditorView(image: selectedImage, isVisible: $ciFileterShow)
            }
        }
        .fullScreenCover(isPresented: $mgRShow) {
            if let selectedImage = Binding($image) {
                ScaleAndRotationView(image: selectedImage, isVisible: $mgRShow)
            }
        }
        .fullScreenCover(isPresented: $textShow) {
            if let selectedImage = Binding($image) {
                TextEffect(image: selectedImage, isVisible: $textShow)
            }
        }
        .fullScreenCover(isPresented: $penShow) {
            if let selectedImage = Binding($image) {
                DrawingView(image: selectedImage, isVisible: $penShow)
            }
        }
    }
    
    private var toolBar: some View {
        HStack {
            Button {
                showSelection.toggle()
            } label: {
                Image(systemName: "photo.badge.plus")
                    .padding()
            }
            
            Button {
                ciFileterShow.toggle()
            } label: {
                Image(systemName: "camera.filters")
                    .padding()
            }
            .disabled(image == nil)
            
            Button {
                penShow.toggle()
            } label: {
                Image(systemName: "pencil.tip.crop.circle")
                    .padding()
            }
            .disabled(image == nil)
            
            Button {
                mgRShow.toggle()
            } label: {
                Image(systemName: "crop.rotate")
                    .padding()
            }
            .disabled(image == nil)
            
            Button {
                textShow.toggle()
            } label: {
                Image(systemName: "textformat.alt")
                    .padding()
            }
            .disabled(image == nil)
            
            Button {
                activeAlert = .save
            } label: {
                Image(systemName: "photo.badge.arrow.down")
                    .padding()
            }
            .disabled(image == nil)
        }
        .font(.system(size: 20))
        .padding(.horizontal, 10)
    }
}

