# CryptoRank - iOS
## Overview
CryptoRank App fetches data from the [CointRanking API](https://api.coinranking.com/v2) and displays a list of the
top 100 cryptocurrency coins paginated, showing 20 characters per page. It supports dark and light theme and uses a combination of both UIKit and SwiftUI to display the UI.

## Installation

    Prerequisites
    - Latest Xcode version - 16.0 and above.
    - iOS 13.0 or higher.
- Clone the repository
- Open CryptoCoin.xcodeproj
- Install/Setup the dependencies:
    > File -> Packages -> Resolve Package Versions
- Build and run the project.

## Assumptions and Decisions Made
- The app should support a wide range of devices, so the minimum deployment target is set to iOS 13.0.
- The app uses the built-in URLSession framework for networking calls.
- Core Data is used to cache favorite coins, allowing offline access and improved performance.
- The app supports both dark and light modes, enhancing user experience based on system preferences.
- The app should use MVVM architecture for better scalability and testability.
- The app uses xcstrings-tool-plugin to manage strings efficiently, allowing for easier localization in the future.

## Challenges & Solutions
 1. The Swift Charts framework is available from iOS 16 and above, limiting support for devices running older iOS versions.
    Sol: Implemented an alternative charting solution using DGCharts, a third-party library that supports older iOS versions and work with both UIKit and SwiftUI.
2. The coin images are in SVG format and iOS does not have native support for SVG images in UIImageView.
   Sol: Leveraged SDWebImageSVGCoder a third-party library that extends SDWebImage to support loading SVG images into UIImageview.


## wip
- settings
- more unit tests.
 
## Attributions
Used images for walkthrough screens from : [
  - https://iconscout.com/free-illustration/business-stat-9883386_8058246
  - https://iconscout.com/free-illustration/bitcoin-investment-profit-5665487_4725570
  - https://storyset.com/illustration/investment-data/rafiki
]

   


