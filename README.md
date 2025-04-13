# 📱 Crypto Price Tracker

A SwiftUI-based iOS app that tracks real-time cryptocurrency prices using the CoinGecko API. Built with RxSwift for reactive programming and includes modern UI components designed via Figma.

> ✅ This task was assigned to me by **TECHSOLVE SOLUTION**, and I have successfully completed it.

---

## 🎨 Design

Figma Design: [Crypto Wallet App (Community)](https://www.figma.com/design/bgUjEjO0Wr9rylRBr4iba3/Crypto-Wallet-App-(Community)?m=auto&t=L3pP8hmODvdh8P79-1)

---

## ⚙️ Tech Stack

- SwiftUI
- RxSwift & RxCocoa
- Alamofire
- CoreData
- CoinGecko API

---

## 🚀 Features

### ✅ Welcome Screen
- App name and tagline
- “Get Started” button

### ✅ Market Overview + Portfolio
- Live prices: name, symbol, price, % change
- Market cap, volume
- Mock portfolio: balance, allocation, chart
- Pull-to-refresh

### ✅ Coin Detail Screen
- Coin info from API
- 7-day price chart
- Favorite coin (CoreData)

### 🔍 Optional: Search
- Search bar to filter coins
- RxSwift debounce for efficiency

---

## 🔌 API Integration (CoinGecko)

- Market List:  
  `GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true`

- Coin Detail:  
  `GET /coins/{id}`

- Historical Chart:  
  `GET /coins/{id}/market_chart?vs_currency=usd&days=7`

---

## 🛠 Setup Instructions

1. Clone the repo
2. Run `pod install`
3. Open in Xcode 15+
4. Build and run on iOS 17+

---

## ✅ Requirements

- macOS with Xcode 15+
- iOS 17 deployment target
- Cocoapods installed

---

**Project by Muhammad Usama**  
**Completed for TECHSOLVE SOLUTION**
