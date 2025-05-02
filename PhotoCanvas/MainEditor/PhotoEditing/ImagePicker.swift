//
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI
import PhotosUI

struct UIImagePickerRepresentable: UIViewControllerRepresentable {
    @Binding private var selectedImage: UIImage?
    private let sourceType: UIImagePickerController.SourceType

    init(
        sourceType: UIImagePickerController.SourceType = .photoLibrary,
        selectedImage: Binding<UIImage?>
    ) {
        self.sourceType = sourceType
        self._selectedImage = selectedImage
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { .init(self) }
}

extension UIImagePickerController.SourceType: @retroactive Identifiable {
    public var id: String {
        switch self {
        case .camera: return "camera"
        case .photoLibrary: return "photoLibrary"
        case .savedPhotosAlbum: return "savedPhotosAlbum"
        @unknown default: fatalError("Unknown source type")
        }
    }
}

extension UIImagePickerRepresentable {
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private let parent: UIImagePickerRepresentable

        init(_ parent: UIImagePickerRepresentable) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            picker.dismiss(animated: true) { [weak self] in
                if let image = info[.editedImage] as? UIImage {
                    self?.parent.selectedImage = image
                } else if let image = info[.originalImage] as? UIImage {
                    self?.parent.selectedImage = image
                }
            }
        }
    }
}
