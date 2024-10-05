# ☀️ OpenWeatherApp

- 지원 플랫폼 : iOS 14+
- 라이트 모드, 세로 모드

## 📝 기능 요구사항

사용자가 선택한 도시에 대한 현재 날씨 정보 제공

- 도시 정보 (도시 이름, 지도상 도시 위치)

- 현재 날씨 (기온, 날씨, 최저 & 최고 온도)

- 시간 별 날씨 (오늘 포함 3시간 간격으로 2일간 )

- 일 별 날씨 (오늘 포함 1일 간격으로 5일간)

  

## ⚒️ 개발 기술

- 개발환경: Xcode(16.0)

- 언어: Swift5(latest)

- UI Framework: SwiftUI(based), UIKit

- 아키텍쳐 패턴: MVVM Input-Output (Unidirectional Flow), Clean Architecture

- 반응형: Combine

- 비동기: Async/ Await

- 영속성: UserDefault

- 네트워킹: URLSession

- 지도: MapKit

- 1’st Library Only

## 구현 화면

![Simulator Screen Recording - iPhone 15 Pro - 2024-10-05 at 08 32 36](https://github.com/user-attachments/assets/fd6d2d7e-2c60-40f6-8b91-0d1bc22ce760)


##  ⚙️ 앱 빌드 전 환경 설정 (필수)

Xcode Configuration 파일을 생성해 환경 변수를 주입해줘야합니다.

- 환경변수 설정(*.xcconfig)

  ```shell
  BASE_URL = <api base url>
  API_KEY = <api key>
  ```

  Open Weaher Map API의 경우 `BASE_URL = https://api.openweathermap.org`



## 🤔 고려 사항

### 1.  **데이터 경합에 대한 대처 방식**

> 모든 객체를 serialize 할 필요는 없다고 판단했습니다.

- **경합 가능성이 있는 경우**:

  - 데이터 경합이 발생할 수 있는 상황(예: 여러 스레드에서 동일 데이터에 접근하거나 수정하는 경우)을 면밀히 분석하고, 이러한 상황에서만 `MainActor`를 통해 직렬화하여 UI 업데이트를 처리했습니다.

  - ex) ViewModel에서 View가 바라보는  `@Published output: Output` 프로퍼티는 UI의 업데이트와 직결됨으로 값을 업데이트 할 때는 `MainActor`를 통해 업데이트 하도록 했습니다.

- **경합 가능성이 낮은 경우**:
  - 경합 가능성이 낮은 단순 데이터 읽기 및 연산의 경우, 불필요하게 `Actor`를 사용하지 않고 **직렬화 없이 비동기 처리**를 진행하였습니다.

### 2. 라이브러리 선택에 대한 기준

> **URLSession** vs **Alamofire** vs **Moya**

- **네트워킹 라이브러리**

  `Alamofire`와 같은 네트워킹 라이브러리를 사용하지 않고 유연성을 위해 URLSession을 기반으로 네트워크 통신을 구현하였습니다. 필요에 따라 라이브러리의 유틸리티들을 활용하면 좋지만, 간단한 날씨 앱에서 사용하기에는 불필요한 리소스가 더 많다고 판단했습니다.

>**UserDefault** vs **DB**

- **영속성 라이브러리**

  영속성 관리를 위해 `UserDefault`와 `RealmDB`, `CoreData` 같은 DB 사이에서 선택을 고민했지만, 데이터를 계속해서 쌓아서 보관해야하는 경우가 아니기 때문에, 무거운 데이터베이스 시스템을 로컬에 구축하기보다는 경량의 `UserDefault` 를 활용하였습니다.

### 3. SwiftUI 버전 대응

- SwiftUI의 기능적 제약으로 인해 최소 지원 버전을 iOS 14(SwiftUI 2.0)으로 설정

  - iOS 14부터 `SwiftUI` 2.0이 지원되면서 `Grid`와 같은 유용한 컴포넌트가 추가되었고, 이를 활용하기 위해 최소 버전을 조정했습니다.
  - 대부분 UI를 `SwiftUI`로 작성하고, `SwiftUI` 2.0 에서 일부 구현이 어려운 부분들은 UIKit으로 작성하였습니다.
    Ex) 서치바, 맵뷰 


- 멀티플랫폼 대응을 위한 ViewExtension 구조체 정의

  - `SwiftUI`의 `ViewModifier`를 확장하여 직관적인 코드 작성을 위해 `rx` 네임스페이스와 유사한 `ViewExtension` 네임스페이스를 설계했습니다.
  - 모든 View는 다음과 같이 `ex` 네임스페이스 (`ViewExtension`의 축약)를 통해 ViewExtension 에 정의된 확장 유틸리티들을 사용할 수 있으며, 이미 정의된 modifier들과 구분하여 사용할 수 있습니다.
    Ex) `Color.white.ex.forground(Color.red)`
  - 확장 유틸리티들은 버전 분기를 통해 다양한 플랫폼에 대응 가능한 구조로 개발하였습니다.

### 4.  레이어드 아키텍쳐
<img width="1596" alt="image" src="https://github.com/user-attachments/assets/7250f4b0-e1d9-4bb4-aed7-69cfeaa8926c">


>**Application**: 애플리케이션의 흐름을 조율하는 계층.
>
>**Presentation**: UI 및 사용자와의 상호작용을 처리하는 계층.
>
>**Domain**: 비즈니스 로직과 모델을 관리하는 핵심 계층. (도메인에서 다루는 데이터를 모델이라고 지칭했습니다)
>
>**Data**: 외부 데이터 소스(API, DB 등)와의 통신 및 데이터 저장을 담당하는 계층. (영속성의 데이터를 Entity라고 지칭했습니다.)
>
>**Shared**: 공통 유틸리티, 공통 컴포넌트, 상수, 확장 메서드 등을 제공하는 계층.

- 책임 분리를 통해 모듈 간 결합도를 낮추고 유연성을 높이고자 하였으며, 클린 아키텍처의 원칙을 참고하여 다음과 같이 계층을 분리하였습니다. 각 계층별로 목업 데이터를 생성하여, 개발 중에도 다른 계층의 실제 구현체가 없어도 독립적으로 개발과 테스트를 진행할 수 있도록 했습니다.
- Shared는 추후 패키지로 분리해 재사용할 수 있는 공유 모듈로 구성되어 있습니다.

### 5. Combine과  Swift Concurrency의 결합

> `async/await`:  불필요한 쓰레드 전환 없이 작업을 효율적으로 처리하여 CPU 사용률을 최적화 할 수 있습니다.
>
> `combine`: UI와 데이터 바인딩에 최적화되어, 비동기 데이터의 스트리밍 및 사용자 이벤트 처리에 유리합니다.

- 각 각의 장점을 살리고자 UI를 다루는 `Presentation` 계층에서는 `Combine`을 통한 데이터 흐름 관리와 UI 업데이트를 수행하고, `Domain` 및 `Data` 계층에서는 `async/await`을 사용하여 비동기 작업을 간결하게 수행했습니다.

- 계층간의 결합시에는 `Task`를 사용하여 두 비동기 처리 방식을 자연스럽게 연결했습니다.

### 5. Open Weather API Call 제한 및 Client-side Caching 최적화

하루 1000회 **API 호출 제한**이 있었고, 추가 호출 시 비용이 발생하는 상황이었습니다. API 공급업체의 **데이터 갱신 주기**는 **10분**으로, 이를 고려하여 **클라이언트 사이드 캐싱**을 통해 네트워크 호출을 최적화했습니다.

### 6. 도시 검색 메모리 캐싱 기능 구현

도시 검색을 위한 데이터는 파일 i/o를 통해 디스크에 저장된 json 파일을 모델로 디코딩해서 사용합니다. 하지만, 데이터의 용량이 커 매번 디스크에서 load 하는 것은 응답 latency가 너무 컸습니다. 이를 개선하기 위해 캐시메모리에 저장하도록 하였습니다. NSCache를 활용하였습니다. NSCache는 메모리 과적합시에 사용하지 않는 메모리를 OS에서 자동으로 정리해주기 때문에 효율적이라 판단했습니다.

### 7. 날씨 데이터에 대한 모델링

`iOS 16+`의 `WeatherKit`과 유사한 인터페이스를 제공하여, 사용자나 다른 개발자가 쉽게 이해하고 확장할 수 있도록 하고 싶었습니다.  특히, `Forecast`라는 래퍼 구조체는 향후 확장성을 고려하여 설계되었습니다. 지금 현재의 기능 요구사항에서 `Forecast` 구조체는 실질적인 역할이 없는 "껍데기" 구조체이지만, 향후 데이터를 가공하거나 통계를 낼 수 있는 메서드를 추가할 수 있는 공간을 확보하고 있습니다.

### 8. 네트워크 단절에 대한 대응

네트워크 모니터 유틸리티를 정의하여 네트워크 연결 상태에 대한 이벤트를 구독하고, 상태에 따라 사용자에게 네트워크 단절 상황에 대해 알려주도록 하였습니다. 

