//
//  CryptoListScreenView.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/12/25.
//

import SwiftUI

struct CryptoListView: View {
    @StateObject private var viewModel = CryptoListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        TopBarView()
                        PortfolioSummaryView()
                        CoinCardsView()
                        RewardsBannerView()
                        MarketStatisticsView(viewModel: viewModel)
                    }
                }
                CustomTabBar()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Top Bar
    struct TopBarView: View {
        var body: some View {
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                Image(systemName: "bell")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Portfolio Summary
    struct PortfolioSummaryView: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("Portfolio Balance")
                    .foregroundColor(.gray)
                
                HStack {
                    Text("$12550.50")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("+10.75%")
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.green.opacity(0.2))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text("My Portfolio")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Monthly")
                        .foregroundColor(.green)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.green)
                        .font(.caption)
                }
                
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Coin Cards
    struct CoinCardsView: View {
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    CoinCard(name: "Bitcoin", symbol: "BTC", value: "$6780", growth: "+11.75%", color: Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.12), imageName: "bitcoin")
                    CoinCard(name: "Ethereum", symbol: "ETH", value: "$1478.10", growth: "+4.75%", color: .blue, imageName: "bitcoin")
                }
                .padding(.horizontal)
            }
        }
    }
    
    struct CoinCard: View {
        var name: String
        var symbol: String
        var value: String
        var growth: String
        var color: Color
        var imageName: String
        var imageSize = CGSize(width: 90, height: 90)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Text(symbol)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                Spacer()
                
                HStack {
                    Text(value)
                        .foregroundColor(.white)
                        .font(.title3)
                    
                    Spacer()
                    
                    Text(growth)
                        .foregroundColor(.green)
                        .font(.caption)
                }
                .padding()
            }
            .padding(.top)
            .frame(width: 196, height: 156)
            .background(LinearGradient(gradient: Gradient(colors: [color.opacity(0.6), color]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(18)
        }
    }
    
    // MARK: - Rewards Banner
    struct RewardsBannerView: View {
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Refer Rewards")
                        .font(.caption)
                    Text("Earn 5$ rewards on every successfull refers")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: 347)
            .background(Color(red: 0/255, green: 244/255, blue: 200/255))
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Market Statistics
    struct MarketStatisticsView: View {
        let filters = ["24 hrs", "Hot", "Profit", "Rising", "Loss", "Top Gain"]
        @ObservedObject var viewModel: CryptoListViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("Market Statistics")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter)
                                .foregroundColor(.white)
                                .padding(.top, 5)
                                .padding(.bottom, 4)
                                .padding(.horizontal, 12)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(6)
                        }
                    }
                }
                
                VStack(spacing: 20) {
                    ForEach(viewModel.cryptoCurrencies) { coin in
                        NavigationLink(destination: CoinDetailView(coinId: coin.id)) {
                                    MarketCoinRow(
                                        name: coin.name,
                                        symbol: coin.symbol.uppercased(),
                                        value: String(format: "$%.2f", coin.currentPrice),
                                        growth: String(format: "%.2f%%", coin.priceChangePercentage24h),
                                        color: .blue
                                    )
                                }
                    }
                }
            }
            .padding()
        }
    }
    
    struct MarketCoinRow: View {
        var name: String
        var symbol: String
        var value: String
        var growth: String
        var color: Color
        
        var body: some View {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 32, height: 32)
                VStack(alignment: .leading) {
                    Text(name)
                        .foregroundColor(.white)
                    Text(symbol)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(value)
                        .foregroundColor(.white)
                    Text(growth)
                        .foregroundColor(growth.contains("-") ? .red : .green)
                        .font(.caption)
                }
            }
        }
    }
    
    // MARK: - Custom Tab Bar
    struct CustomTabBar: View {
        var body: some View {
            HStack {
                Spacer()
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "chart.pie.fill")
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(red: 0/255, green: 244/255, blue: 200/255))
                        .frame(width: 50, height: 50)
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "chart.bar.fill")
                Spacer()
                Image(systemName: "gearshape.fill")
                Spacer()
            }
            .background(
                LinearGradient(colors: [.blue.opacity(0.3), .black], startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(32)
            .foregroundColor(.white)
        }
    }
    
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView()
    }
}
