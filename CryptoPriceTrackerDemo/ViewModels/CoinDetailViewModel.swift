//
//  CoinDetailViewModel.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import RxSwift
import RxCocoa

struct HistoricalPrice: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

class CoinDetailViewModel: ObservableObject {
    @Published var coinDetail: CoinDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var historicalPrices: [HistoricalPrice] = []
    @Published var isChartLoading = false
    
    private let service = CoinGeckoService()
    private let disposeBag = DisposeBag()

    func loadCoinDetail(id: String) {
        isLoading = true
        errorMessage = nil

        service.fetchCoinDetail(by: id)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] detail in
                    self?.isLoading = false
                    self?.coinDetail = detail
                },
                onFailure: { [weak self] error in
                    self?.isLoading = false
                    self?.errorMessage = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
    
    
    func loadHistoricalPrices(id: String, days: Int = 7) {
            isChartLoading = true
            service.fetchHistoricalPrices(for: id, days: days)
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] prices in
                        self?.historicalPrices = prices
                        self?.isChartLoading = false
                    },
                    onError: { [weak self] error in
                        self?.errorMessage = error.localizedDescription
                        self?.isChartLoading = false
                    }
                )
                .disposed(by: disposeBag)
        }
}

