# DOONG DOONG MASTER

둥둥마스터의 iOS 앱<br>
(안드로이드는 추후 지원 예정)

## Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Dependencies](#dependencies)
- [Features](#features)

## Introduction

드럼 초보자를 위한 어쿠스틱 드럼 채점기 둥둥마스터

## Requirements
개발환경은 MacOS입니다.

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Xcode**: [Download Xcode](https://developer.apple.com/xcode/)
- **CocoaPods**: [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation)

세부 버전은 아래와 같습니다.

```
  [✓] Flutter (Channel stable, 3.16.9, on macOS 13.6.1 22G313 darwin-arm64, locale en-KR)
      • Flutter version 3.16.9 on channel stable at /opt/homebrew/Caskroom/flutter/3.13.9/flutter
      • Upstream repository https://github.com/flutter/flutter.git
      • Framework revision 41456452f2 (5 months ago), 2024-01-25 10:06:23 -0800
      • Engine revision f40e976bed
      • Dart version 3.2.6
      • DevTools version 2.28.5

  [✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
      • Xcode at /Applications/Xcode-15.0.1.app/Contents/Developer
      • Build 15A507
      • CocoaPods version 1.14.3

  [✓] VS Code (version 1.90.0)
      • VS Code at /Applications/Visual Studio Code.app/Contents
      • Flutter extension version 3.90.0

  [✓] Network resources
      • All expected network resources are available.

  • No issues found!
```

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/DoongDoongMaster/application.git
   cd application
   ```

2. **Install Flutter dependencies**:

   ```bash
   flutter pub get
   ```

3. **Install iOS dependencies**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Running the App

```bash
flutter run
```

## Dependencies

사용한 주요 패키지 및 오픈소스는 아래와 같습니다.

### flutter package

- [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview): ^6.0.0
- [fl_chart](https://pub.dev/packages/fl_chart): ^0.66.2
- [go_router](https://pub.dev/packages/go_router): ^13.1.0

전체 패키지는 `pubspec.yaml` 참고.

### etc

- [OSMD](https://github.com/opensheetmusicdisplay/opensheetmusicdisplay): MusicXML 시각화 오픈소스

## Features

- 악보 등록: 악보 이미지를 등록하여 사용 가능
- 악보 프롬프트: 선택한 악보를 지정한 속도로 프롬프트 & 현재 위치 표기
- 연주 채점: 악보와 연주를 비교하여 악기 및 박자 정확도를 기준으로 채점레포트 제공
- 연습장: 채점 레포트 모아보기, 점수 추이 확인 가능
- 구간 반복: 원하는 구간을 선택해서 반복 연습 가능
