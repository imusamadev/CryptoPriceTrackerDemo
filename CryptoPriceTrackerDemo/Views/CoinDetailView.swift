//
//  CoinDetailView.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import SwiftUI

struct CoinDetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView{
                VStack(alignment: .leading) {
                    TopBarView()
                    CoinInfoView()
                    CoinStatsView()
                    ChartFiltersView()
                    CoinChartView()
                    MinMaxPriceView()
                }
            }
            TransferButtonView()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
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
    var body: some View {
        HStack(spacing: 16) {
            Image("cardano") // Replace with real asset name
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Cardano / ADA")
                    .foregroundColor(.white)
                    .font(.headline)

                Text("$123.77")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
            }

            Spacer()

            Text("▲ 11.75%")
                .font(.subheadline)
                .foregroundColor(.green)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.green.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)

        Divider()
            .background(Color.white.opacity(1))
    }
}

struct CoinStatsView: View {
    var body: some View {
        HStack {
            VStack {
                Text("POPULARITY")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("#61")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("MARKET CAP")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("$32.4 b")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("VOLUME")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("$20.6 b")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)

        Divider()
            .background(Color.white.opacity(1))
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
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom))
                .frame(height: 220)

            LineChartMock()
                .stroke(Color.blue, lineWidth: 2)
                .frame(height: 365)
                .padding(.horizontal)
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
        CoinDetailView()
    }
}
