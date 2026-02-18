//
//  PhotoPicker.swift
//  Util
//
//  Created by kim sunchul on 5/26/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import SwiftUI
import PhotosUI

public struct PhotoPicker: UIViewControllerRepresentable {
  
  // MARK: - Define
  
  public class Coordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: PhotoPicker
    
    init(_ parent: PhotoPicker) {
      self.parent = parent
    }
    
    public func picker(
      _ picker: PHPickerViewController,
      didFinishPicking results: [PHPickerResult]
    ) {
      picker.dismiss(animated: true)
      
      if results.isEmpty {
        DispatchQueue.main.async {
          self.parent.onCancel = true
        }
        return
      }
      
      guard let provider = results.first?.itemProvider else { return }
      self.parent.onCancel = false
      
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { (image, _) in
          DispatchQueue.main.async {
            if let image {
              self.parent.selectedImage = image as? UIImage
            }
          }
        }
      }
    }
  }
  
  // MARK: - Property
  
  @Binding
  var selectedImage: UIImage?
  
  @Binding
  var onCancel: Bool
  
  // MARK: - Init
  
  public init(selectedImage: Binding<UIImage?>, onCancel: Binding<Bool>) {
    self._selectedImage = selectedImage
    self._onCancel = onCancel
  }
  
  // MARK: - Method
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public func makeUIViewController(context: Context) -> PHPickerViewController {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = context.coordinator
    return picker
  }
  
  public func updateUIViewController(
    _ uiViewController: PHPickerViewController,
    context: Context
  ) {}
}
