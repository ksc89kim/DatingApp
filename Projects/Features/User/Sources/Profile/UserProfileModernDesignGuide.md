# User Profile - Modern Dating App Design Guide (Badoo/Tinder Style)

## 1. 디자인 철학

현대적인 데이팅 앱(Badoo, Tinder, Bumble)의 디자인 언어를 차용:
- **이미지 중심**: 프로필 사진이 화면의 주인공
- **미니멀리즘**: 불필요한 요소 제거, 핵심 정보만 표시
- **인터랙티브**: 스와이프, 애니메이션 등 직관적인 제스처
- **카드 기반 UI**: 정보를 카드 형태로 레이어링

---

## 2. 리뷰 이슈 및 수정 방안

| # | 등급 | 이슈 | 디자인 스펙 | 관련 섹션 |
|---|------|------|-----------|----------|
| 1 | 🔴 | 신고/차단 접근점 없음 | 네비게이션 우측에 더보기 아이콘(ellipsis) 22pt, 터치 영역 44x44pt | §5.7 |
| 2 | 🔴 | 로딩 상태 View 미반영 | 반투명 배경(#FFFFFF 70%) + 중앙 ProgressView, 또는 Skeleton 효과 | §5.8 |
| 3 | 🔴 | 다크 모드 미대응 | `.white`/`.black` → Semantic Color 전환 | §3 |
| 4 | 🔴 | ScrollView 내 Spacer 무효 | Spacer 제거, 하단 여백 `.padding(.bottom, 24)` | §6 |
| 5 | 🔴 | presentationMode deprecated | `@Environment(\.dismiss)` 교체 | - |
| 6 | 🟡 | 이미지 높이 400pt 고정 | 화면 높이의 55% 비율 기반 | §5.2 |
| 7 | 🟡 | UIPageControl 전역 오염 | 커스텀 바 인디케이터로 교체 | §5.1 |
| 8 | 🟡 | 이미지 위 정보 오버레이 없음 | 하단 40% 그라데이션 + 닉네임/나이 오버레이 | §5.2 |
| 9 | 🟡 | 좋아요/건너뛰기 시각적 비중 동일 | 좋아요 56pt/건너뛰기 44pt, 비율 60:40 | §5.5 |
| 10 | 🟡 | chatList 진입 시 하단 비어있음 | "메시지 보내기" 버튼 추가 | §5.5 |
| 11 | 🟡 | 자기소개 섹션 부재 | 직업과 관심사 사이에 "소개" 섹션 추가 | §5.4 |
| 12 | 🟡 | chipRowCount 고정값 부정확 | 고정 높이 제거, intrinsic height 의존 | §5.3 |
| 13 | 🟢 | 닉네임 24pt 시스템 외 커스텀 | boldLargeTitle(28pt) 또는 오버레이 방식 시 32pt | §4 |
| 14 | 🟢 | 나이/키 색상 위계 부족 | #3C3C43 (opacity 0.8) 으로 직업(#6E6E6E)과 차별화 | §4 |
| 15 | 🟢 | 버튼 높이 48pt | 56pt로 확대 권장 | §5.5 |
| 16 | 🟢 | 빈 프로필 Skeleton 미처리 | Skeleton 높이 24pt, 너비 120pt, 색상 #E5E5EA | §5.8 |

---

## 3. 컬러 시스템 (다크 모드 대응)

### Semantic Color 매핑

| 용도 | 라이트 모드 | 다크 모드 | iOS Semantic |
|------|-----------|----------|-------------|
| 화면 배경 | #FFFFFF | #000000 | `systemBackground` |
| 카드 배경 | #FFFFFF | #1C1C1E | `secondarySystemBackground` |
| 기본 텍스트 | #000000 | #FFFFFF | `label` |
| 보조 텍스트 | #3C3C43 (60%) | #EBEBF5 (60%) | `secondaryLabel` |
| 구분선 | gray 20% | gray 30% | `separator` |
| 건너뛰기 버튼 배경 | gray 15% | gray 25% | `tertiarySystemFill` |
| 건너뛰기 버튼 텍스트 | #000000 | #FFFFFF | `label` |

### 브랜드 컬러 (다크 모드에서도 동일)

| 토큰 | Hex | 용도 |
|------|-----|------|
| `MainColor.accent` | #FFB6C1 | 좋아요 버튼, 활성 인디케이터, 하트 아이콘 |
| `MainColor.background` | #6A5ACD | 프로필 편집 버튼, CTA |
| `MainColor.text` | #FEFEFF | 버튼 내부 텍스트 |
| `MainColor.placeHolder` | #6E6E6E | 직업 등 서브텍스트 |

### 액션 버튼 컬러

| 용도 | 값 | 다크 모드 |
|------|-----|----------|
| Like 버튼 그라데이션 | #FF6B9D → #C239B3 | 동일 |
| Like 버튼 그림자 | #FF6B9D (opacity 0.4) | 동일 |
| Nope 버튼 배경 | `systemBackground` | 자동 대응 |
| Nope 버튼 아이콘 | Red (system) | 동일 |
| Super Like | #FFD700 | 동일 |
| 이미지 그라데이션 | clear → #000000 (opacity 0.55) | 동일 |

---

## 4. 타이포그래피

### 이미지 오버레이 영역

| 요소 | Weight | Size | Color |
|------|--------|------|-------|
| 닉네임 | Bold | 32pt | #FFFFFF |
| 나이 | Regular | 24pt | #FFFFFF (opacity 0.9) |
| 위치/직업 | Regular | 16pt | #FFFFFF (opacity 0.85) |

### 카드/정보 영역

| 요소 | Weight | Size | Color |
|------|--------|------|-------|
| 섹션 타이틀 ("관심사", "소개") | Semibold | 17pt | `label` |
| 소개 본문 | Regular | 15pt | `label` |
| 나이/키 (분리 배치 시) | Medium | 16pt | #3C3C43 (opacity 0.8) |
| 직업 | Medium | 14pt | #6E6E6E (`placeHolder`) |
| 관심사 Chip | Medium | 14pt | Chip 스타일 |
| 하단 버튼 텍스트 | Bold | 14pt | 버튼별 상이 |

### 폰트 규칙
- 프로젝트 `systemScaledFont` 사용 (Dynamic Type 자동 지원)
- 최소 텍스트 크기: 11pt (HIG Caption 2)
- 오버레이 영역은 고정 크기 허용 (그라데이션 배경 위)

---

## 5. 컴포넌트 상세 설계

### 5.1 이미지 인디케이터 (상단 바)

UIPageControl 기본 dot 대신 Tinder 스타일 바 인디케이터를 사용합니다.

**스펙:**

| 속성 | 값 |
|------|-----|
| 형태 | Capsule (수평 바) |
| 높이 | 3pt |
| 바 간격 | 4pt |
| 좌우 여백 | 8pt |
| 상단 여백 | SafeArea 하단 + 8pt |
| 활성 색상 | #FFFFFF (opacity 1.0) |
| 비활성 색상 | #FFFFFF (opacity 0.4) |
| 바 너비 | `(화면너비 - 16 - (바간격 × (장수-1))) / 장수` |
| cornerRadius | 1.5pt |
| 위치 | 이미지 영역 상단, 오버레이 |

**레퍼런스:** Tinder, Bumble, Hinge, 아만다 모두 동일 패턴

---

### 5.2 프로필 이미지 (비율 기반 + 그라데이션 오버레이)

**이미지 영역:**

| 속성 | 값 | 비고 |
|------|-----|------|
| 높이 | **화면 높이의 55%** | 400pt 고정값 제거 |
| 너비 | 전체 화면 너비 | |
| contentMode | fill + clipped | |
| 이미지 전환 | 좌우 탭 (좌: 이전, 우: 다음) | Tinder 스타일 |
| 전환 애니메이션 | spring(response: 0.3, damping: 0.8) | |

기기별 55% 적용 결과:

| 모델 | 화면 높이 | 이미지 높이 |
|------|----------|-----------|
| iPhone 16 Pro Max | 956pt | ~526pt |
| iPhone 16 / 15 | 852pt | ~469pt |
| iPhone SE | 667pt | ~367pt |

**그라데이션 오버레이:**

| 속성 | 값 |
|------|-----|
| 방향 | 아래에서 위로 (bottom → center) |
| 시작 | #000000 (opacity 0.55) |
| 끝 | clear |
| 영역 | 이미지 하단 40% |

**오버레이 위 기본 정보:**

| 속성 | 값 |
|------|-----|
| 닉네임 | Bold 32pt, #FFFFFF |
| 나이 | Regular 24pt, #FFFFFF (opacity 0.9) |
| 닉네임-나이 간격 | 8pt |
| 위치/직업 아이콘 | SF Symbol `mappin.circle.fill`, `briefcase.fill` |
| 위치/직업 텍스트 | Regular 16pt, #FFFFFF (opacity 0.85) |
| 위치-직업 간격 | 12pt |
| 정보 줄 간격 | 8pt (닉네임줄 → 위치줄) |
| 좌측 여백 | 20pt |
| 하단 여백 | 24pt |
| 정렬 | 좌측 하단 |

**이미지 없을 때:**
- ProfilePlaceHolder 표시
- 배경: `profilePlaceholder` (#F5F5F5)
- 아이콘: `person.fill`, 컨테이너의 50%, 색상 #CCCCCC

---

### 5.3 플로팅 카드 (관심사)

| 속성 | 값 |
|------|-----|
| 배경 | `secondarySystemBackground` (다크 모드 자동 대응) |
| cornerRadius | 16pt |
| 그림자 | offset(0, 2), blur 8pt, #000000 (opacity 0.08) |
| 내부 패딩 | 20pt (전방향) |
| 외부 좌우 마진 | 16pt |
| 상단 간격 (이미지 → 카드) | 12pt |

**섹션 타이틀:**

| 속성 | 값 |
|------|-----|
| 아이콘 | SF Symbol `gamecontroller.fill`, 색상 `MainColor.accent` |
| 타이틀 | "관심사", Semibold 17pt, `label` |
| 아이콘-타이틀 간격 | 8pt |
| 타이틀-칩 간격 | 12pt |

**칩 스타일 (ChipAppearance):**

| 속성 | 값 |
|------|-----|
| 선택 배경 | `MainColor.accent` (#FFB6C1) |
| 선택 텍스트 | #FFFFFF |
| 미선택 배경 | gray (opacity 0.2) |
| 미선택 텍스트 | `label` |
| cornerRadius | 20pt |
| 내부 패딩 | top/bottom 8pt, leading/trailing 16pt |
| 폰트 | Medium 15pt |
| 칩 간격 | 4pt |
| 높이 계산 | **intrinsic height 의존** (고정 높이 계산 제거) |
| 인터랙션 | 비활성 (읽기 전용) |

---

### 5.4 소개 섹션 (NEW)

직업과 관심사 사이에 추가하는 자기소개 영역입니다.

| 속성 | 값 |
|------|-----|
| 배경 | `secondarySystemBackground` |
| cornerRadius | 16pt |
| 그림자 | 관심사 카드와 동일 |
| 내부 패딩 | 20pt |
| 외부 좌우 마진 | 16pt |
| 카드 간 간격 | 12pt |

**내부 구성:**

| 요소 | 스펙 |
|------|------|
| 아이콘 | SF Symbol `text.quote`, 색상 `MainColor.accent` |
| 타이틀 | "소개", Semibold 17pt, `label` |
| 본문 | Regular 15pt, `label`, 최대 3줄 표시 |
| "더보기" 링크 | Regular 14pt, `MainColor.accent`, 3줄 초과 시 표시 |
| 빈 상태 | 섹션 자체를 숨김 |

**레퍼런스:** Hinge의 프롬프트 카드, Bumble의 소개 섹션

---

### 5.5 하단 액션 버튼

진입 경로에 따라 3가지 분기:

#### (A) 매칭 추천 진입 — 원형 액션 버튼

```
        ✕          ⭐️          💚
      (Nope)    (Super)     (Like)
       56pt      48pt        64pt
```

| 버튼 | 크기 | 아이콘 | 아이콘 크기 | 배경 | 아이콘 색상 | 그림자 |
|------|------|--------|-----------|------|-----------|--------|
| Nope | 56pt | `xmark` | Bold 24pt | `systemBackground` | Red (system) | #000000 10%, blur 8pt, y:2 |
| Super Like | 48pt | `star.fill` | Bold 20pt | `systemBackground` | #FFD700 | #000000 10%, blur 8pt, y:2 |
| Like | 64pt | `heart.fill` | Bold 28pt | 그라데이션 #FF6B9D→#C239B3 | #FFFFFF | #FF6B9D 40%, blur 12pt, y:4 |

| 속성 | 값 |
|------|-----|
| 버튼 간격 | 24pt |
| 상하 패딩 | 24pt |
| 정렬 | 수평 중앙 |
| 눌림 효과 | scaleEffect 0.9, spring 0.3s |

> Like 버튼이 가장 크고 시각적으로 가장 강조. 피츠의 법칙 적용 — 핵심 액션의 타겟 크기 최대화.

#### (B) 채팅 리스트 진입 — 메시지 버튼 (NEW)

| 속성 | 값 |
|------|-----|
| 텍스트 | "메시지 보내기" |
| 배경 | `MainColor.accent` (#FFB6C1) |
| 텍스트 색상 | #FFFFFF |
| 높이 | 52pt |
| cornerRadius | 12pt |
| 너비 | 전체 (좌우 여백 18pt) |
| 상하 패딩 | 18pt |
| 눌림 효과 | PressedButtonStyle |

> 기존 EmptyView 대신 자연스러운 플로우 제공. 채팅방으로 바로 이동.

#### (C) 마이페이지 진입 — 프로필 편집

| 속성 | 값 |
|------|-----|
| 텍스트 | "프로필 편집" |
| 배경 | `MainColor.background` (#6A5ACD) |
| 텍스트 색상 | `MainColor.text` (#FEFEFF) |
| 높이 | 48pt |
| cornerRadius | 12pt |
| 너비 | 전체 (좌우 여백 18pt) |
| 상하 패딩 | 18pt |
| 눌림 효과 | PressedButtonStyle |

---

### 5.6 관심사 Chip (Modern Style — 선택 적용)

기존 ChipContainerView 대신 그라데이션 칩을 사용할 경우:

| 속성 | 값 |
|------|-----|
| 구조 | 이모지 + 텍스트 |
| 이모지 크기 | 16pt |
| 텍스트 | Medium 14pt, #FFFFFF |
| 이모지-텍스트 간격 | 6pt |
| 내부 패딩 | 좌우 12pt, 상하 8pt |
| cornerRadius | 20pt |
| 배경 | 장르별 그라데이션 (leading → trailing) |

**장르별 그라데이션:**

| 장르 | 이모지 | 시작색 | 끝색 |
|------|--------|--------|------|
| FPS | 🎯 | #FF6B6B | #FF8E53 |
| RPG | ⚔️ | #4E54C8 | #8F94FB |
| 인디 | 🎨 | #F093FB | #F5576C |
| 전략 | 🧠 | #667EEA | #764BA2 |
| 기본 | 🎮 | #FA709A | #FEE140 |

---

### 5.7 신고/차단 메뉴 (NEW)

**네비게이션 바 레이아웃:**

```
┌─────────────────────────────────┐
│  [←]                      [···] │
│  BackButton          더보기 메뉴 │
└─────────────────────────────────┘
```

**더보기 버튼:**

| 속성 | 값 |
|------|-----|
| 아이콘 | SF Symbol `ellipsis` |
| 아이콘 크기 | 20pt, Medium weight |
| 색상 | `label` (라이트: #000000, 다크: #FFFFFF) |
| 터치 영역 | 44 x 44pt (HIG 최소 준수) |
| 표시 조건 | matchRecommend, chatList 진입 시만 (myPage에서는 숨김) |

**메뉴 옵션:**

| 옵션 | 아이콘 | 스타일 |
|------|--------|--------|
| 신고하기 | SF Symbol `flag` | destructive (빨간색) |
| 차단하기 | SF Symbol `hand.raised` | destructive (빨간색) |

**UX 규칙:**
- 탭 시 ActionSheet/Menu 표시
- 신고/차단 선택 시 확인 Alert 표시 (오류 방지 — Nielsen #5)
- 접근 가능하되 핵심 플로우를 방해하지 않는 위치 (Nielsen #8)

**레퍼런스:** Tinder, Bumble, Hinge, 아만다 모두 우측 상단 `...` 패턴

---

### 5.8 로딩/에러/빈 상태 (NEW)

#### 로딩 상태

| 속성 | 값 |
|------|-----|
| 배경 | 반투명 #FFFFFF (opacity 0.7) / 다크: #000000 (opacity 0.7) |
| ProgressView | 중앙 배치, 1.5x 스케일 |
| ProgressView 색상 | `MainColor.accent` (#FFB6C1) |

또는 Skeleton 방식:

| 요소 | 스펙 |
|------|------|
| 이미지 영역 | 배경 #F2F2F7, shimmer #E5E5EA → #F2F2F7, 1.2초 주기 |
| 닉네임 placeholder | 높이 24pt, 너비 120pt, cornerRadius 4pt, 색상 #E5E5EA |
| 서브텍스트 placeholder | 높이 16pt, 너비 80pt, cornerRadius 4pt, 색상 #E5E5EA |

#### 에러 상태

| 요소 | 스펙 |
|------|------|
| 아이콘 | SF Symbol `wifi.slash`, 48pt, `secondaryLabel` |
| 제목 | "프로필을 불러올 수 없습니다", Semibold 17pt, `label` |
| 설명 | "네트워크 연결을 확인해주세요", Medium 14pt, `secondaryLabel` |
| 재시도 버튼 | "다시 시도", Bold 14pt, #FFFFFF, 배경 `MainColor.background`, 패딩 좌우 24pt 상하 12pt, cornerRadius 12pt |
| 요소 간격 | 16pt |
| 정렬 | 수직/수평 중앙 |

#### 빈 프로필 상태

| 조건 | 처리 |
|------|------|
| 닉네임 빈 문자열 | Skeleton placeholder 표시 |
| 직업 없음 | 해당 Text 숨김 |
| 관심사 없음 | 관심사 섹션 전체 숨김 |
| 소개 없음 | 소개 카드 전체 숨김 |

---

## 6. 전체 레이아웃 구조

### 와이어프레임

```
┌─────────────────────────────────┐
│  [←]                      [···] │  네비게이션 바 + 더보기(🔴 NEW)
├─────────────────────────────────┤
│  ━━━━━━━━ ━━━━━━━━              │  커스텀 바 인디케이터(🟡 FIX)
│                                 │
│                                 │
│         프로필 이미지             │  비율 기반 높이(🟡 FIX)
│      (탭으로 전환)               │  화면 높이의 55%
│                                 │
│   ┌───────────────────────┐     │
│   │ ▓▓ 그라데이션(🟡 NEW) ▓▓│    │  하단 40%, #000000 55%
│   │ 김민수  28              │    │  Bold 32pt + Regular 24pt
│   │ 📍 서울 · 💼 개발자     │    │  Regular 16pt
│   └───────────────────────┘     │
│                                 │
├───── 12pt 간격 ─────────────────┤
│  ┌─────────────────────────┐   │
│  │  🎮 관심사               │   │  플로팅 카드
│  │  [FPS] [RPG] [인디]      │   │  secondarySystemBackground
│  │  intrinsic height        │   │  (🟢 FIX: 고정높이 제거)
│  └─────────────────────────┘   │
├───── 12pt 간격 ─────────────────┤
│  ┌─────────────────────────┐   │
│  │  💬 소개 (🟡 NEW)        │   │  플로팅 카드
│  │  안녕하세요, 게임 좋아...  │   │  최대 3줄 + "더보기"
│  └─────────────────────────┘   │
│           24pt 하단 여백         │  (🔴 FIX: Spacer 제거)
├─────────────────────────────────┤
│                                 │
│   ✕        ⭐️        💚         │  원형 액션 버튼
│  56pt     48pt      64pt       │
│  (Nope)  (Super)   (Like)      │
│                                 │
└─────────────────────────────────┘
```

### 뷰 계층 구조

```
UserProfileView
├── VStack(spacing: 0)
│   ├── navigationBar
│   │   ├── BackButton (좌측)
│   │   └── 더보기 Menu (우측, 🔴 NEW)
│   ├── contentBody (🔴 로딩/에러 상태 분기)
│   │   └── ScrollView(.vertical)
│   │       └── VStack(alignment: .leading)
│   │           ├── profileImageSection (55% 비율)
│   │           │   └── ZStack
│   │           │       ├── TabView (indexDisplayMode: .never)
│   │           │       ├── LinearGradient (하단 40%)
│   │           │       ├── 바 인디케이터 (상단)
│   │           │       └── 기본 정보 (하단 좌측)
│   │           ├── 관심사 플로팅 카드
│   │           ├── 소개 플로팅 카드 (🟡 NEW)
│   │           └── .padding(.bottom, 24)
│   └── bottomButtonSection
│       ├── (A) 원형 액션 버튼 (매칭 추천)
│       ├── (B) "메시지 보내기" (채팅 리스트, 🟡 NEW)
│       └── (C) "프로필 편집" (마이페이지)
├── .background(systemBackground) // 🔴 Semantic Color
└── .alert + .onChange(dismiss) // 🔴 Modern API
```

---

## 7. 간격 및 크기 종합

### 간격

| 위치 | 값 | 비고 |
|------|-----|------|
| 인디케이터 상단 | SafeArea + 8pt | |
| 인디케이터 바 높이 | 3pt | |
| 인디케이터 바 간격 | 4pt | |
| 인디케이터 좌우 여백 | 8pt | |
| 오버레이 정보 좌측 여백 | 20pt | |
| 오버레이 정보 하단 여백 | 24pt | |
| 이미지 → 카드 간격 | 12pt | |
| 카드 간 간격 | 12pt | |
| 카드 좌우 마진 | 16pt | |
| 카드 내부 패딩 | 20pt | |
| 콘텐츠 하단 여백 | 24pt | 🔴 Spacer 대체 |
| 액션 버튼 간격 | 24pt | |
| 액션 버튼 상하 패딩 | 24pt | |
| 더보기 버튼 터치 영역 | 44 x 44pt | HIG 최소 |

### 크기

| 요소 | 크기 |
|------|------|
| 이미지 영역 | 화면 높이의 55% |
| Like 버튼 | 64pt (원형) |
| Nope 버튼 | 56pt (원형) |
| Super Like 버튼 | 48pt (원형) |
| 직사각형 CTA 버튼 | 높이 52pt (채팅) / 48pt (편집) |
| 카드 cornerRadius | 16pt |
| Chip cornerRadius | 20pt |
| 버튼 cornerRadius | 12pt |
| 인디케이터 cornerRadius | 1.5pt |

---

## 8. 애니메이션 및 인터랙션

### 이미지 전환
- 좌우 탭으로 이미지 전환 (스와이프 아닌 탭)
- spring(response: 0.3, dampingFraction: 0.8)

### 좋아요 피드백
- 화면 중앙에 큰 하트 아이콘 (100pt, `MainColor.accent`)
- spring(response: 0.3, dampingFraction: 0.6)으로 등장
- scale 1.0 → opacity fade out

### 카드 등장
- offset Y: 50pt → 0pt
- opacity: 0 → 1
- easeOut 0.4s, delay 0.2s

### 버튼 눌림
- 원형 버튼: scaleEffect 0.9, spring 0.3s
- 직사각형 버튼: scaleEffect 0.95, easeInOut 0.25s (PressedButtonStyle)

### 스와이프 제스처 (선택)
- 좌우 드래그로 좋아요/패스
- 임계값: 좌우 100pt
- 회전: drag 거리 / 20 도
- 원위치 복귀: spring 애니메이션

---

## 9. 접근성

| 요소 | 접근성 레이블 | 비고 |
|------|-------------|------|
| 뒤로가기 | "뒤로 가기" | BackButton 기본 |
| 더보기 메뉴 | "더보기" | 🔴 NEW |
| 프로필 이미지 | "프로필 사진 N장 중 M번째" | + `.isImage` trait |
| 닉네임 | (텍스트 자동) | + `.isHeader` trait |
| 좋아요 | "좋아요 보내기" | |
| 패스 | "패스하기" | |
| 슈퍼 좋아요 | "슈퍼 좋아요 보내기" | |
| 메시지 보내기 | "메시지 보내기" | 🟡 NEW |
| 신고하기 | "신고하기" | 🔴 NEW |
| 차단하기 | "차단하기" | 🔴 NEW |

**Dynamic Type:** 모든 텍스트 `systemScaledFont` 사용
**대비율:** 텍스트 4.5:1 이상, 큰 텍스트 3:1 이상
**터치 타겟:** 모든 인터랙티브 요소 최소 44 x 44pt

---

## 10. 구현 우선순위

### Phase 1: 필수 이슈 수정
1. 🔴 Semantic Color 전환 (다크 모드 대응)
2. 🔴 신고/차단 더보기 메뉴 추가
3. 🔴 로딩/에러 상태 UI 반영
4. 🔴 ScrollView Spacer → padding 교체
5. 🔴 `@Environment(\.dismiss)` 교체

### Phase 2: 모던 UI 전환
6. 🟡 비율 기반 이미지 높이 (55%)
7. 🟡 커스텀 바 인디케이터
8. 🟡 그라데이션 오버레이 + 정보 배치
9. 🟡 원형 액션 버튼

### Phase 3: 콘텐츠 확장
10. 🟡 소개 섹션 추가
11. 🟡 chatList 진입 시 "메시지 보내기" 버튼
12. 🟡 칩 높이 계산 → intrinsic height

### Phase 4: 폴리싱
13. 🟢 닉네임 폰트 시스템 통일
14. 🟢 나이/키 색상 위계 조정
15. 🟢 빈 프로필 Skeleton
16. 🟢 스와이프 제스처
17. 🟢 성능 최적화

---

## 11. 경쟁 앱 비교표

| 패턴 | Tinder | Bumble | Hinge | 아만다 | **우리 앱 (목표)** |
|------|--------|--------|-------|--------|-----------------|
| 이미지 비율 | 65% | 60% | 50%+카드 | 55% | **55%** |
| 인디케이터 | 상단 바 | 상단 바 | 상단 바 | 상단 바 | **상단 바** |
| 정보 오버레이 | 그라데이션+이름/나이 | 그라데이션+이름/나이/직업 | 카드 하단 | 그라데이션+이름 | **그라데이션+이름/나이/직업** |
| 좋아요 버튼 | 원형(초록 하트) | 원형(노란 체크) | 장미 아이콘 | 하트 버튼 | **원형(핑크 하트)** |
| 신고 접근 | 우측 상단 ... | 우측 상단 ... | 우측 상단 ... | 우측 상단 ... | **우측 상단 ...** |
| 자기소개 | 텍스트 | 텍스트+배지 | 프롬프트 카드 | 텍스트 | **텍스트 카드** |
| 다크 모드 | 지원 | 지원 | 지원 | 부분 지원 | **지원 (목표)** |
