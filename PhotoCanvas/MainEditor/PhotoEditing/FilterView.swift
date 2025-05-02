//
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageEditorView: View {
    @State private var filteredImage: UIImage?
    @State private var filterIntensity: Float = 0.5
    @State private var selectedFilter: CIFilter = CIFilter.sepiaTone()
    
    @Binding var image: UIImage
    @Binding var isVisible: Bool

    @Environment(\.dismiss) private var dismiss
    
    let context = CIContext()
    
    let filters: [(String, CIFilter)] = [
        ("Sepia", CIFilter.sepiaTone()),
        ("Noir", CIFilter.photoEffectNoir()),
        ("Mono", CIFilter.photoEffectMono()),
        ("Chrome", CIFilter.photoEffectChrome()),
        ("Blur", CIFilter.gaussianBlur()),
        ("Invert", CIFilter.colorInvert()),
        ("Vignette", CIFilter.vignette()),
        ("Pixelate", CIFilter.pixellate())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if let filteredImage {
                    Image(uiImage: filteredImage)
                        .resizable()
                        .scaledToFit()
                } else  {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filters, id: \.0) { filter in
                            Button(action: {
                                selectedFilter = filter.1
                                applyFilter()
                            }) {
                                Text(filter.0)
                                    .padding()
                                    .background(selectedFilter == filter.1 ? Color.green : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
                
                if selectedFilter.inputKeys.contains(kCIInputIntensityKey) {
                    Slider(value: $filterIntensity, in: 0...1) {
                        Text("Intensity")
                    }
                    .padding()
                    .onChange(of: filterIntensity) { _, _ in
                        applyFilter()
                    }
                }
            }
            .padding()
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
                    Button {
                        applyFilter()
                        
                        if let filteredImage {
                            image = filteredImage
                        }
                        
                        isVisible = false
                    } label: {
                        Text("Apply")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
    
    private func applyFilter() {
        guard let ciImage = CIImage(image: image) else { return }
        
        selectedFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        if selectedFilter.inputKeys.contains(kCIInputIntensityKey) {
            selectedFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if let outputImage = selectedFilter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            filteredImage = UIImage(cgImage: cgImage)
        }
    }
}
