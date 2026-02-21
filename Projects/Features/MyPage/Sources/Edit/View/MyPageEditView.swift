//
//  MyPageEditView.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import SwiftUI
import DI
import Util
import MyPageInterface

struct MyPageEditView: View {

  // MARK: - Define

  private typealias MainColor = UtilAsset.MainColor

  private enum Metric {
    static let horizontalPadding: CGFloat = 16
    static let cardPadding: CGFloat = 16
    static let cardCornerRadius: CGFloat = 16
    static let sectionSpacing: CGFloat = 20
    static let fieldSpacing: CGFloat = 14
    static let buttonHeight: CGFloat = 50
    static let buttonCornerRadius: CGFloat = 12
    static let introduceMaxLength: Int = 140
  }

  // MARK: - Property

  @ObservedObject
  private var viewModel: MyPageEditViewModel

  @Environment(\.dismiss)
  private var dismiss

  // MARK: - Init

  init(viewModel: MyPageEditViewModel) {
    self.viewModel = viewModel
  }

  // MARK: - Body

  var body: some View {
    VStack(spacing: 0) {
      self.headerBar
      self.scrollContent
      self.bottomSaveButton
    }
    .background(Color(.systemGroupedBackground))
    .navigationBarHidden(true)
    .alert(
      "오류",
      isPresented: self.$viewModel.state.isPresentAlert
    ) {
      Button("확인") {
        self.viewModel.trigger(.dismissAlert)
      }
    } message: {
      Text(self.viewModel.state.alertMessage)
    }
    .overlay {
      if self.viewModel.state.isSaving {
        ProgressView()
          .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
          )
          .background(Color.black.opacity(0.2))
      }
    }
  }

  // MARK: - Header Bar

  private var headerBar: some View {
    ZStack {
      Text("프로필 편집")
        .systemScaledFont(
          font: .semibold,
          size: 17
        )
        .foregroundStyle(Color(.label))
      HStack {
        Button {
          self.dismiss()
        } label: {
          HStack(spacing: 4) {
            Image(systemName: "chevron.left")
              .font(.system(size: 15))
            Text("취소")
              .systemScaledFont(
                font: .regular,
                size: 16
              )
          }
          .foregroundStyle(Color(.label))
        }
        Spacer()
        Button {
          self.viewModel.trigger(.save)
        } label: {
          Text("저장")
            .systemScaledFont(
              font: .semibold,
              size: 16
            )
            .foregroundStyle(
              MainColor.accent.swiftUIColor
            )
        }
        .disabled(self.viewModel.state.isSaving)
      }
    }
    .padding(.horizontal, Metric.horizontalPadding)
    .padding(.vertical, 12)
    .background(Color(.systemBackground))
  }

  // MARK: - Scroll Content

  private var scrollContent: some View {
    ScrollView {
      VStack(spacing: Metric.sectionSpacing) {
        self.basicInfoCard
        self.introduceCard
        self.gameGenreCard
      }
      .padding(.horizontal, Metric.horizontalPadding)
      .padding(.vertical, Metric.sectionSpacing)
    }
  }

  // MARK: - Section 1: Basic Info

  private var basicInfoCard: some View {
    VStack(alignment: .leading, spacing: Metric.fieldSpacing) {
      Text("기본 정보")
        .systemScaledFont(
          font: .semibold,
          size: 17
        )
        .foregroundStyle(Color(.label))
      self.textField(
        title: "닉네임",
        text: self.$viewModel.state.nickname,
        placeholder: "닉네임을 입력하세요"
      )
      self.textField(
        title: "키 (cm)",
        text: self.$viewModel.state.height,
        placeholder: "키를 입력하세요",
        keyboardType: .numberPad
      )
      self.textField(
        title: "직업",
        text: self.$viewModel.state.job,
        placeholder: "직업을 입력하세요"
      )
      self.mbtiPicker
    }
    .padding(Metric.cardPadding)
    .background(Color(.systemBackground))
    .clipShape(
      RoundedRectangle(
        cornerRadius: Metric.cardCornerRadius
      )
    )
  }

  private func textField(
    title: String,
    text: Binding<String>,
    placeholder: String,
    keyboardType: UIKeyboardType = .default
  ) -> some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(title)
        .systemScaledFont(
          font: .medium,
          size: 13
        )
        .foregroundStyle(Color(.secondaryLabel))
      TextField(placeholder, text: text)
        .systemScaledFont(
          font: .regular,
          size: 15
        )
        .keyboardType(keyboardType)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
          Color(.tertiarySystemFill)
        )
        .clipShape(
          RoundedRectangle(cornerRadius: 10)
        )
    }
  }

  private var mbtiPicker: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("MBTI")
        .systemScaledFont(
          font: .medium,
          size: 13
        )
        .foregroundStyle(Color(.secondaryLabel))
      Picker(
        "MBTI",
        selection: self.$viewModel.state.mbti
      ) {
        Text("선택 안함")
          .tag("")
        ForEach(
          ProfileOptions.allMbtiTypes,
          id: \.self
        ) { type in
          Text(type).tag(type)
        }
      }
      .pickerStyle(.wheel)
      .frame(height: 120)
      .clipShape(
        RoundedRectangle(cornerRadius: 10)
      )
    }
  }

  // MARK: - Section 2: Introduce

  private var introduceCard: some View {
    VStack(alignment: .leading, spacing: Metric.fieldSpacing) {
      Text("소개")
        .systemScaledFont(
          font: .semibold,
          size: 17
        )
        .foregroundStyle(Color(.label))
      ZStack(alignment: .bottomTrailing) {
        TextEditor(
          text: self.introduceBinding
        )
        .systemScaledFont(
          font: .regular,
          size: 15
        )
        .frame(minHeight: 100)
        .scrollContentBackground(.hidden)
        .padding(8)
        .background(Color(.tertiarySystemFill))
        .clipShape(
          RoundedRectangle(cornerRadius: 10)
        )
        Text(
          "\(self.viewModel.state.introduce.count)"
            + "/\(Metric.introduceMaxLength)"
        )
        .systemScaledFont(
          font: .regular,
          size: 12
        )
        .foregroundStyle(Color(.tertiaryLabel))
        .padding(.trailing, 12)
        .padding(.bottom, 8)
      }
    }
    .padding(Metric.cardPadding)
    .background(Color(.systemBackground))
    .clipShape(
      RoundedRectangle(
        cornerRadius: Metric.cardCornerRadius
      )
    )
  }

  private var introduceBinding: Binding<String> {
    Binding(
      get: { self.viewModel.state.introduce },
      set: {
        self.viewModel.trigger(.updateIntroduce($0))
      }
    )
  }

  // MARK: - Section 3: Game Genre

  private var gameGenreCard: some View {
    VStack(alignment: .leading, spacing: Metric.fieldSpacing) {
      HStack {
        Text("게임 장르")
          .systemScaledFont(
            font: .semibold,
            size: 17
          )
          .foregroundStyle(Color(.label))
        Spacer()
        Text("최대 5개 선택")
          .systemScaledFont(
            font: .regular,
            size: 13
          )
          .foregroundStyle(Color(.tertiaryLabel))
      }
      ChipContainerView(
        items: self.viewModel
          .state.availableGenreChips,
        selections: self.selectedGenresBinding,
        appearance: self.editChipAppearance,
        limitCount: .value(5)
      )
      .frame(
        height: CGFloat(
          (self.viewModel
            .state.availableGenreChips
            .count / 4 + 1) * 44
        )
      )
    }
    .padding(Metric.cardPadding)
    .background(Color(.systemBackground))
    .clipShape(
      RoundedRectangle(
        cornerRadius: Metric.cardCornerRadius
      )
    )
  }

  private var selectedGenresBinding: Binding<Set<Chip>> {
    Binding(
      get: {
        self.viewModel.state.selectedGenreChips
      },
      set: {
        self.viewModel.trigger(
          .updateSelectedGenres($0)
        )
      }
    )
  }

  private var editChipAppearance: ChipAppearance {
    ChipAppearance(
      selectedBackgroundColor:
        MainColor.accent.swiftUIColor,
      unselectedBackgroundColor:
        Color.gray.opacity(0.15),
      selectedForegroundColor: .white,
      unselectedForegroundColor: Color(.label)
    )
  }

  // MARK: - Bottom Save Button

  private var bottomSaveButton: some View {
    VStack(spacing: 0) {
      Divider()
      Button {
        self.viewModel.trigger(.save)
      } label: {
        Text("저장하기")
          .systemScaledFont(style: .bottomButton)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .frame(height: Metric.buttonHeight)
          .background(
            MainColor.accent.swiftUIColor
          )
          .clipShape(
            RoundedRectangle(
              cornerRadius: Metric
                .buttonCornerRadius
            )
          )
      }
      .buttonStyle(PressedButtonStyle())
      .disabled(self.viewModel.state.isSaving)
      .padding(
        .horizontal,
        Metric.horizontalPadding
      )
      .padding(.vertical, 12)
    }
    .background(
      Color(.systemBackground)
        .ignoresSafeArea(edges: .bottom)
    )
  }
}
