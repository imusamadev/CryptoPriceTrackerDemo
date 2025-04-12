//
//  CryptoListViewModel.swift
//  CryptoPriceTrackerDemo
//
//  Created by mac on 4/13/25.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoListViewModel: ObservableObject {
    private let service = CryptoService()
    private let disposeBag = DisposeBag()

    @Published var cryptoCurrencies: [CryptoCurrency] = []

    init() {
        fetchData()
    }

    func fetchData() {
        service.fetchCryptoCurrencies()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] currencies in
                self?.cryptoCurrencies = currencies
            })
            .disposed(by: disposeBag)
    }
}
