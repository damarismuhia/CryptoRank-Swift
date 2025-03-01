//
//  CoinDetailView.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 26/02/2025.
//

import SwiftUI
import Combine

struct CoinDetailView: View {
    @ObservedObject var viewModel: CoinDetailsViewModel
    @State private var selectedSortOption: PeriodSortOption = .oneHour

    init(coin: Coin) {
        self.viewModel = CoinDetailsViewModel(coin: coin)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8){
                
                HStack() {
                    Text("#\(viewModel.coin.rank)")
                        .font(.sourceSanRegular())
                        .foregroundColor(Color.lightFadedGrey)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.fadeGrey)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text(viewModel.coin.name)
                        .font(.sourceSanBold())
                }.padding(.top, 8)
                VStack(alignment: .leading, spacing: 8) {
                    RowView(title: .localizable(.currentPrice), value: viewModel.coin.price.formatPrice())
                    RowView(title: .localizable(.bitcoinPrice), value: viewModel.coin.btcPrice.formatBTCPrice())
                    RowView(title: .localizable(.marketCap), value: viewModel.coin.marketCap.formatMarketCap())
                    RowView(title: .localizable(.hrChange), value:
                                viewModel.coin.change.formatHrChange(), textColor: viewModel.coin.change.starts(with: "-") ? Color.red : Color.darkGreen )
                }.padding(.vertical, 8).padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Chart
                Text(localizable: .performaceChart)
                    .font(.sourceSanBold())
                let title: String = .localizable(.sortBy)
                Picker( title, selection: $selectedSortOption) {
                    ForEach(PeriodSortOption.allCases, id: \.self) { option in
                        Text(option.displayName).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .valueChanged(value: self.selectedSortOption) { newValue in
                    Task {
                        await viewModel.fetchCoinHistory(within: newValue.displayName)
                    }
                }
                VStack {
                    if viewModel.isHistoryLoading {
                        Text(localizable: .loadingChart)
                    } else if let errorMessage = viewModel.historyErrMsg {
                        ErrorText(errMsg: errorMessage)
                    } else {
                        PerformanceChartView(entry: ChartDataConverter.toChartDataEntry(entries: viewModel.coinHistory), selectedPeriod: selectedSortOption)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                    }
                }
                Divider()
                    .background(Color.gray)
                
                Text(localizable: .aboutCoin(viewModel.coin.name))
                    .font(.sourceSanBold())
                if viewModel.isDetailLoading {
                    Text(localizable: .pleaseWait)
                }else if let errorMessage = viewModel.detailsErrMsg {
                    ErrorText(errMsg: errorMessage)
                }else {
                    Text(viewModel.coinDetails?.description ?? "")
                        .font(.sourceSanRegular())
                    Divider()
                        .background(Color.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
                
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            Task {
               await viewModel.fetchCoinHistory(within: selectedSortOption.displayName)
                await viewModel.fetchCoinDetail()
            }
        }
        
    }
}

#Preview {
   
    let coin = Coin(uuid: "Qwsogvtv82FCd", name: "Ethereum", symbol: "ETH", price: "87,800.34", btcPrice: "0.345678", marketCap: "50,000,000,789.09", change: "-89.90", rank: 1, sparkline: [], iconUrl: "")
    CoinDetailView(coin: coin)
}


