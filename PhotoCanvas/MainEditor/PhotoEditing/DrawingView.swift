//
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI
import UIKit
import PencilKit

struct DrawingView: UIViewControllerRepresentable {
    @Binding var image: UIImage
    @Binding var isVisible: Bool

    func makeUIViewController(context: Context) -> DrawingViewController {
        let viewController = DrawingViewController(image: image) { editedImage in
            self.image = editedImage
            self.isVisible = false
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: DrawingViewController, context: Context) {}
}


final class DrawingViewController: UIViewController {
    
    var image: UIImage
    var onSave: ((UIImage) -> Void)?
    
    private var canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    private let imageView = UIImageView()
    private let saveButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)
    
    init(image: UIImage, onSave: @escaping (UIImage) -> Void) {
        self.image = image
        self.onSave = onSave
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupToolPicker()
    }
    
    @objc private func closeAndSave() {
        let newImage = mergeDrawingWithImage()
        onSave?(newImage)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func closeView() {
        dismiss(animated: true, completion: nil)
    }

    private func setupUI() {
        view.backgroundColor = .white

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        canvasView.drawingPolicy = .anyInput
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvasView)

        saveButton.setTitle("Apply", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(closeAndSave), for: .touchUpInside)
        view.addSubview(saveButton)
        
        closeButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        closeButton.tintColor = .systemBlue
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            canvasView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: imageView.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupToolPicker() {
        guard let window = view.window ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)

        DispatchQueue.main.async {
            self.canvasView.becomeFirstResponder()
        }
    }

    private func mergeDrawingWithImage() -> UIImage {
        let imageSize = image.size
        let displayedImageFrame = calculateDisplayedImageFrame()

        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: imageSize))

            let scaleX = imageSize.width / displayedImageFrame.width
            let scaleY = imageSize.height / displayedImageFrame.height

            context.cgContext.saveGState()
            context.cgContext.translateBy(x: -displayedImageFrame.origin.x * scaleX, y: -displayedImageFrame.origin.y * scaleY)
            context.cgContext.scaleBy(x: scaleX, y: scaleY)

            let drawingImage = canvasView.drawing.image(from: canvasView.bounds, scale: 1)
            drawingImage.draw(in: CGRect(origin: .zero, size: canvasView.bounds.size))

            context.cgContext.restoreGState()
        }
    }

    private func calculateDisplayedImageFrame() -> CGRect {
        guard let actualImage = imageView.image else { return .zero }

        let imageViewSize = imageView.bounds.size
        let imageSize = actualImage.size

        let scaleX = imageViewSize.width / imageSize.width
        let scaleY = imageViewSize.height / imageSize.height
        let scale = min(scaleX, scaleY)

        let displayedWidth = imageSize.width * scale
        let displayedHeight = imageSize.height * scale

        let originX = (imageViewSize.width - displayedWidth) / 2
        let originY = (imageViewSize.height - displayedHeight) / 2

        return CGRect(x: originX, y: originY, width: displayedWidth, height: displayedHeight)
    }
}
