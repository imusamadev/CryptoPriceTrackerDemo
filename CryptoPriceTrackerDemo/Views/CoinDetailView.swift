//
//  CoinDetailView.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    
    @StateObject var viewModel = CoinDetailViewModel()
    var coinId: String
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .foregroundColor(.white)
            } else if let coin = viewModel.coinDetail {
                ScrollView{
                    VStack(alignment: .leading) {
                        TopBarView()
                        CoinInfoView(coin: coin)
                        CoinStatsView(coin: coin)
                        ChartFiltersView()
                        if viewModel.isChartLoading {
                            ProgressView("Loading Chart...")
                                .foregroundColor(.white)
                        } else {
                            CoinChartView(prices: viewModel.historicalPrices)
                        }
                        MinMaxPriceView()
                    }
                }
                TransferButtonView()
            }
            else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.loadCoinDetail(id: coinId)
            viewModel.loadHistoricalPrices(id: coinId)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct TopBarView: View{
    var body: some View{
        
        // Header
        HStack {
            Button(action: {
                // Back action
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.green)
                    .font(.title2)
            }
            Spacer()
            Button(action: {
                // Favorite action
            }) {
                Image(systemName: "heart")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
        }
        .padding(.horizontal)
        
    }
}

struct CoinInfoView: View {
    let coin: CoinDetail
    
    var body: some View {
        HStack(spacing: 16) {
            Image(coin.id) // Ensure image exists in Assets with the coin id
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(coin.name) / \(coin.symbol.uppercased())")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("$\(String(format: "%.2f", coin.marketData.currentPrice["usd"] ?? 0))")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
            }
            
            Spacer()
            
            let change = coin.marketData.priceChangePercentage24H
            let isPositive = (change ?? 0) >= 0
            Text("\(isPositive ? "▲" : "▼") \(String(format: "%.2f", abs(change ?? 0)))%")
                .font(.subheadline)
                .foregroundColor(isPositive ? .green : .red)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background((isPositive ? Color.green : Color.red).opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
        
        Divider().background(Color.white.opacity(1))
    }
}

struct CoinStatsView: View {
    let coin: CoinDetail
    
    var body: some View {
        HStack {
            VStack {
                Text("POPULARITY")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("#\(String(describing: coin.marketCapRank))")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("MARKET CAP")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("$\(formatNumber(coin.marketData.marketCap["usd"]))")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("VOLUME")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("$\(formatNumber(coin.marketData.totalVolume["usd"]))")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)
        
        Divider().background(Color.white.opacity(1))
    }
    
    private func formatNumber(_ number: Double?) -> String {
        guard let number = number else { return "--" }
        if number >= 1_000_000_000 {
            return String(format: "%.1f b", number / 1_000_000_000)
        } else if number >= 1_000_000 {
            return String(format: "%.1f m", number / 1_000_000)
        } else {
            return String(format: "%.0f", number)
        }
    }
}

struct ChartFiltersView: View {
    let periods = ["1H", "1D", "1W", "1M", "1Y", "All"]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(periods, id: \.self) { period in
                Text(period)
                    .foregroundColor(period == "1H" ? .black : .white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(period == "1H" ? Color.gray : Color.gray.opacity(0.3))
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
    }
}

struct CoinChartView: View {
    var prices: [HistoricalPrice]

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom))
                .frame(height: 220)

            if prices.isEmpty {
                Text("No data available")
                    .foregroundColor(.white)
            } else {
                Chart {
                    ForEach(prices) { price in
                        LineMark(
                            x: .value("Date", price.date),
                            y: .value("Price", price.price)
                        )
                        .foregroundStyle(Color.green)
                        .interpolationMethod(.monotone)
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 365)
                .padding(.horizontal)
            }
        }
        .padding(.horizontal)
    }
}

struct MinMaxPriceView: View {
    var body: some View {
        HStack {
            Text("MIN $86.21")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            Text("MAX $137.88")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
}

struct TransferButtonView: View {
    var body: some View {
        
        Button(action: {
            // Transfer action
        }) {
            Text("Transfer")
                .foregroundColor(.black)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0/255, green: 244/255, blue: 200/255))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal)
    }
}


// Mock Line Chart Shape
struct LineChartMock: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let points: [CGFloat] = [0.1, 0.6, 0.3, 0.9, 0.2, 0.8, 0.4, 0.7, 0.1]
        let step = rect.width / CGFloat(points.count - 1)
        
        path.move(to: CGPoint(x: 0, y: rect.height * (1 - points[0])))
        
        for i in 1..<points.count {
            path.addLine(to: CGPoint(x: CGFloat(i) * step, y: rect.height * (1 - points[i])))
        }
        
        return path
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coinId: "0")
    }
}
