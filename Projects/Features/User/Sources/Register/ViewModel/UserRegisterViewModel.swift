//
//  UserRegisterViewModel.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Util
import Core
import DI
import UserInterface
import UIKit

final class UserRegisterViewModel: ViewModelType, Injectable {
  
  // MARK: - Property
  
  @Published
  var state: UserRegisterState = .init()
  
  @Inject(UserRegisterRepositoryTypeKey.self)
  private var repository: UserRegisterRepositoryType
  
  private let container: ProgressMainContainer
  
  private let taskBag: AnyCancelTaskBag = .init()
  
  // MARK: - Init
  
  init(container: ProgressMainContainer) {
    self.container = container
    defer {
      self.container.delegate = self
      self.container.mains.forEach { main in
        guard var main = main as? UserRegisterMain else { return }
        main.repository = self.repository
      }
    }
  }
  
  // MARK: - Method
  
  func trigger(_ action: UserRegisterAction) {
    switch action {
    case .initUI: self.initUI()
    case .next: self.next()
    case .previous: self.previous()
    case .birthday(let date): self.updateBirthDayIfNeeded(date)
    case .height(let height): self.updateHeightIfNeeded(height)
    case .singleSelect(let key, let value):
      self.updateSingleSelectIfNeeded(key: key, value: value)
    case .multipleSelect(let key, let value):
      self.updateMultipleSelectIfNeeded(key: key, value: value)
    case .showAlbum: self.showAlbum()
    case .hideAlbum: self.hideAlbum()
    case .selectedImage(let image): self.insertImageInUserRegisterGalleryIfNeeded(image: image)
    case .deleteImage(let index): self.deleteImageInUserRegisterGalleryIfNeeded(index: index)
    }
  }
  
  func trigger(_ action: UserRegisterAction) async {
    switch action {
    case .initUI: await self.initUI()
    case .next: await self.next()
    case .previous: await self.previous()
    case .birthday(let date): self.updateBirthDayIfNeeded(date)
    case .height(let height): self.updateHeightIfNeeded(height)
    case .singleSelect(key: let key, value: let value):
      self.updateSingleSelectIfNeeded(key: key, value: value)
    case .multipleSelect(let key, let value):
      self.updateMultipleSelectIfNeeded(key: key, value: value)
    case .showAlbum: self.showAlbum()
    case .hideAlbum: self.hideAlbum()
    case .selectedImage(let image): self.insertImageInUserRegisterGalleryIfNeeded(image: image)
    case .deleteImage(let index): self.deleteImageInUserRegisterGalleryIfNeeded(index: index)
    }
  }
  
  private func initUI() {
    self.taskBag.cancel()
    
    Task { [weak self] in
      await self?.initUI()
    }
    .store(in: self.taskBag)
  }
  
  private func initUI() async {
    await self.container.updateFirstMain()
  }
  
  private func next() {
    self.taskBag.cancel()
    
    Task { [weak self] in
      await self?.next()
    }
    .store(in: self.taskBag)
  }
  
  private func next() async {
    await self.container.next()
  }
  
  private func previous() {
    self.taskBag.cancel()
    
    Task { [weak self] in
      await self?.previous()
    }
    .store(in: self.taskBag)
  }
  
  private func previous() async {
    await self.container.previous()
  }
  
  private func updateBirthDayIfNeeded(_ birthday: Date) {
    guard let userRegisterBirthday = self.state.currentMain as? UserRegisterBirthday else {
      return
    }
    userRegisterBirthday.updateBirthday(birthday)
    self.state.bottomButton.isDisable = userRegisterBirthday.isBottomDisable
  }

  private func updateHeightIfNeeded(_ height: String) {
    guard let userRegisterHeight = self.state.currentMain as? UserRegisterHeight else {
      return
    }
    userRegisterHeight.updateHeight(height)
    self.state.bottomButton.isDisable = userRegisterHeight.isBottomDisable
  }
  
  private func updateSingleSelectIfNeeded(key: String, value: String?) {
    guard let userRegisterSingleSelect = self.state.currentMain as? UserRegisterSingleSelect,
          key == userRegisterSingleSelect.key,
          let value = value else {
      return
    }
    userRegisterSingleSelect.updateSelection(value)
    self.state.bottomButton.isDisable = userRegisterSingleSelect.isBottomDisable
  }
  
  private func updateMultipleSelectIfNeeded(key: String, value: Set<Chip>) {
    guard let userRegisterMultipleSelect = self.state.currentMain as? UserRegisterMultipleSelect,
          key == userRegisterMultipleSelect.key else {
      return
    }
    userRegisterMultipleSelect.updateSelections(value)
    self.state.bottomButton.isDisable = userRegisterMultipleSelect.isBottomDisable
  }
  
  private func showAlbum() {
    self.state.showingImagePicker = true
  }
  
  private func hideAlbum() {
    self.state.showingImagePicker = false
  }
  
  private func insertImageInUserRegisterGalleryIfNeeded(image: UIImage?) {
    self.hideAlbum()
    guard let userRegisterGallery = self.state.currentMain as? UserRegisterGallery,
          let image = image else { return }
    userRegisterGallery.insertImageIfNeeded(image)
    self.state.bottomButton.isDisable = userRegisterGallery.isBottomDisable
  }
  
  private func deleteImageInUserRegisterGalleryIfNeeded(index: UserRegisterPhotoIndex) {
    guard let userRegisterGallery = self.state.currentMain as? UserRegisterGallery else { return }
    userRegisterGallery.deleteImageIfNeeded(index)
    self.state.bottomButton.isDisable = userRegisterGallery.isBottomDisable
  }

  @MainActor
  private func handleError(_ error: Error) {
    self.state.alert = .init(
      title: "",
      message: error.localizedDescription,
      primaryAction: .init(
        title: .confirm,
        type: .default,
        completion: { [weak self] in
          self?.endLoading()
        }
      )
    )
    self.state.isPresentAlert = true
  }

  @MainActor
  private func startLoading() {
    self.state.bottomButton.isLoading = true
    self.state.bottomButton.isDisable = true
  }

  @MainActor
  private func endLoading() {
    self.state.bottomButton.isLoading = false
    self.state.bottomButton.isDisable = false
  }
}


// MARK: - ProgressMainContainerDelegate

extension UserRegisterViewModel: ProgressMainContainerDelegate {
  
  @MainActor
  func dismiss() async {
    self.state.shouldDismiss = true
  }
  
  func complete() async {
    
  }
  
  @MainActor
  func updateMain(
    _ main: ProgressMain,
    value: Double,
    from: ProgressMainContainer.From
  ) {
    self.state.currentMain = main as? UserRegisterMain
    self.state.progress.value = value
    self.state.bottomButton.isDisable = main.isBottomDisable
    if from != .updateFirstMain {
      self.state.progress.isAnimation = true
    }
  }
}
