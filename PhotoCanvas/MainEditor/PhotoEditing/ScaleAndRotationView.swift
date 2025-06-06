//
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

struct ScaleAndRotationView: View {
    
    @State private var rotationAngle: Angle = .zero
    @State private var finalRotation: Angle = .zero
    @State private var scale = 1.0
    @State private var finalScale = 1.0
    
    @Binding var image: UIImage
    @Binding var isVisible: Bool
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .rotationEffect(rotationAngle + finalRotation)
                    .scaleEffect(scale * finalScale)
                    .gesture(
                        SimultaneousGesture(
                            RotationGesture()
                                .onChanged { value in
                                    rotationAngle = value
                                }
                                .onEnded { value in
                                    finalRotation += rotationAngle
                                    rotationAngle = .zero
                                },
                            
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = value
                                }
                                .onEnded { value in
                                    finalScale *= scale
                                    scale = 1.0
                                }
                        )
                    )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .imageScale(.large)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Button("Reset") {
                            finalRotation = .zero
                            finalScale = 1.0
                        }
                        .padding()
                        
                        Button("Apply Changes") {
                            applyTransformations()
                            isVisible = false
                        }
                    }
                }
            }
        }
    }

    private func applyTransformations() {
        let rotatedAndScaledImage = transformedImage(image, by: finalRotation.degrees, scale: finalScale)
        image = rotatedAndScaledImage
        finalRotation = .zero
        finalScale = 1.0
    }

    private func transformedImage(_ image: UIImage, by degrees: CGFloat, scale: CGFloat) -> UIImage {
        let radians = degrees * .pi / 180
        let scaledSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        
        UIGraphicsBeginImageContext(scaledSize)
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        
        context.translateBy(x: scaledSize.width / 2, y: scaledSize.height / 2)
        context.rotate(by: radians)
        context.scaleBy(x: scale, y: scale)
        context.translateBy(x: -image.size.width / 2, y: -image.size.height / 2)

        image.draw(in: CGRect(origin: .zero, size: image.size))

        let transformedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return transformedImage ?? image
    }
}
