//
//  PickerView.swift
//  Util
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import SwiftUI

public struct PickerView: UIViewRepresentable {
  
  // MARK: - Define
  
  public class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Property
    
    var parent: PickerView
    
    // MARK: - Init
    
    init(_ picker: PickerView) {
      self.parent = picker
    }
    
    // MARK: - Method
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
      1
    }
    
    public func pickerView(
      _ pickerView: UIPickerView,
      numberOfRowsInComponent
      component: Int
    ) -> Int {
      self.parent.array.count
    }
    
    public func pickerView(
      _ pickerView: UIPickerView,
      titleForRow row: Int,
      forComponent component: Int
    ) -> String? {
      self.parent.array[row]
    }
    
    public func pickerView(
      _ pickerView: UIPickerView,
      didSelectRow row: Int,
      inComponent component: Int
    ) {
      self.parent.selectedItem = self.parent.array[row]
    }
  }
  
  // MARK: - Property
  
  var array: [String]
  
  @Binding 
  var selectedItem: String
  
  public init(array: [String], selectedItem: Binding<String>) {
    self.array = array
    self._selectedItem = selectedItem
  }
  
  // MARK: - Method
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public func makeUIView(context: Context) -> UIPickerView {
    let picker = UIPickerView()
    picker.dataSource = context.coordinator
    picker.delegate = context.coordinator
    return picker
  }
  
  public func updateUIView(_ uiView: UIPickerView, context: Context) {
    uiView.selectRow(
      self.array.firstIndex(of: self.selectedItem) ?? 0,
      inComponent: 0,
      animated: false
    )
  }
}
