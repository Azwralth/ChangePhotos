//
//  ShareImage.swift
//  PhotoCanvas
//
//  Created by Владислав Соколов on 05.05.2025.
//

import SwiftUI

struct ShareImage: View {
    var image: UIImage

    var body: some View {
        Button {
            shareImage(image)
        } label: {
            Label("Share Image", systemImage: "square.and.arrow.up")
        }
    }

    private func shareImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("shared.jpg")

        do {
            try data.write(to: tempURL)
            let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        } catch {
            print("Error writing temp image: \(error)")
        }
    }
}
