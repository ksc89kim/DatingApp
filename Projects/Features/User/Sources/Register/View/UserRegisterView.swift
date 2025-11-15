//
//  UserRegisterView.swift
//  User
//
//  Created by kim sunchul on 2/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import Util
import UserInterface

struct UserRegisterView: View {
  
  // MARK: - Property
  
  @ObservedObject
  private var viewModel: UserRegisterViewModel = DIContainer.resolve(
    for: UserRegisterViewModelKey.self
  )
  
  @Environment(\.presentationMode)
  var presentationMode
  
  @State
  var selectedImage: UIImage?
  
  var body: some View {
    VStack(alignment: .leading) {
      BackButton(
        touchPadding: .init(top: 14, leading: 18, bottom: 14, trailing: 18)
      ) {
        self.viewModel.trigger(.previous)
      }
      .accessibilitySortPriority(5)
      VStack(alignment: .leading) {
        self.progressView
        self.currentMainView
        self.nextButton
      }
      .padding(.horizontal, 18)
    }
    .background(.white)
    .alert(isPresented: .constant(self.viewModel.state.isPresentAlert) ) {
      return self.buildAlert(self.viewModel.state.alert)
    }
    .sheet(isPresented: .constant(self.viewModel.state.showingImagePicker)) {
      PhotoPicker(selectedImage: .init(
        get: {
          return self.selectedImage
        },
        set: { image in
          self.viewModel.trigger(.selectedImage(image: image))
          self.selectedImage = image
        }
      ), onCancel: .init(
        get: {
          return false
        },
        set: { onCancel in
          if onCancel {
            self.viewModel.trigger(.hideAlbum)
          }
        })
      )
    }
    .onAppear {
      self.viewModel.trigger(.initUI)
    }
    .onChange(of: self.viewModel.state.shouldDismiss) { _, newValue in
      if newValue {
        self.presentationMode.wrappedValue.dismiss()
      }
    }
  }
  
  @ViewBuilder
  private var progressView: some View {
    ProgressView(value: self.viewModel.state.progress.value)
      .progressViewStyle(
        UserRegisterProgressViewStyle(isAnimation: self.viewModel.state.progress.isAnimation)
      )
      .accessibilityLabel("프로필 등록 진행율")
      .accessibilitySortPriority(4)
      .disabled(true)
      .padding(.bottom, 24)
  }
  
  @ViewBuilder
  private var currentMainView: some View {
    Group {
      if let main = self.viewModel.state.currentMain {
        switch main {
        case let birthdayMain as UserRegisterBirthday:
          self.birthdayView(birthday: birthdayMain)
        case let heightMain as UserRegisterHeight:
          self.heightView(height: heightMain)
        case let singleSelect as UserRegisterSingleSelect:
          self.singleSelectView(select: singleSelect)
        case let multipleSelect as UserRegisterMultipleSelect:
          self.mulitipleSelect(select: multipleSelect)
        case let gallery as UserRegisterGallery:
          self.galleryView(gallery: gallery)
        default: Spacer()
        }
      } else {
        Spacer()
      }
    }
    .transition(.opacity)
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .topLeading
    )
  }
  
  @ViewBuilder
  private var nextButton: some View {
    UserRegisterNextButton(
      isLoading: self.viewModel.state.bottomButton.isLoading,
      isDisable: self.viewModel.state.bottomButton.isDisable,
      title: "다음"
    ) {
      self.viewModel.trigger(.next)
    }
  }
  
  // MARK: - Method
  
  @ViewBuilder
  private func birthdayView(birthday: UserRegisterBirthday) -> some View {
    let binding: Binding<Date> = .init(
      get: { birthday.birthday },
      set: { date in
        self.viewModel.trigger(.birthday(date))
      }
    )
    UserRegisterBirthDayView(birthDate: binding)
  }
  
  @ViewBuilder
  private func heightView(height: UserRegisterHeight) -> some View {
    let binding: Binding<String> = .init(
      get: { return height.height },
      set: { height in
        self.viewModel.trigger(.height(height))
      }
    )
    UserRegisterHeightView(
      selection: binding
    )
  }
  
  @ViewBuilder
  private func singleSelectView(select: UserRegisterSingleSelect) -> some View {
    let binding: Binding<String?> = .init(
      get: { select.selection },
      set: { selection in
        self.viewModel.trigger(
          .singleSelect(key: select.key, value: selection)
        )
      }
    )
    UserRegisterSingleSelectView(
      title: select.title,
      subTitle: select.subTitle,
      items: select.items.map { $0.stringValue },
      selection: binding
    )
  }
  
  @ViewBuilder
  private func mulitipleSelect(select: UserRegisterMultipleSelect) -> some View {
    let binding: Binding<Set<Chip>> = .init(
      get: { select.selections },
      set: { selections in
        self.viewModel.trigger(
          .multipleSelect(key: select.key, value: selections)
        )
      }
    )
    UserRegisterMultipleSelectView(
      title: select.title,
      subTitle: select.subTitle,
      items: select.items,
      selections: binding
    )
  }
  
  @ViewBuilder
  private func galleryView(gallery: UserRegisterGallery) -> some View {
    UserRegisterGalleryView(
      firstImage: .constant(gallery.firstImage),
      secondImage: .constant(gallery.secondImage),
      onAppend: {
        self.viewModel.trigger(.showAlbum)
      },
      onDelete: { index in
        self.viewModel.trigger(.deleteImage(index: index))
      }
    )
  }
}


extension UserRegisterView: AlertBuildable { }


#Preview {
  UserDIRegister.register()
  return UserRegisterView()
}
