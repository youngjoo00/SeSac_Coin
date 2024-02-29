//
//  ChartView.swift
//  SeSac_Coin
//
//  Created by youngjoo on 2/29/24.
//

import UIKit
import Then
import DGCharts

final class ChartView: BaseView {
    
    let coinImageView = UIImageView()
    let titleLabel = TitleLabel()
    let currentPriceLabel = TitleLabel().then {
        $0.font = .boldSystemFont(ofSize: 40)
    }
    
    let percentageLabel = SeSacRedLabel()
    let todayLabel = UILabel().then {
        $0.text = "Today"
        $0.textColor = .sesacDarkGray
    }
    
    let highLabel = SeSacRedLabel().then {
        $0.text = "고가"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    let highPriceLabel = SeSacLightBlackLabel()
    
    let lowLabel = SeSacBlueLabel().then {
        $0.text = "저가"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let lowPriceLabel = SeSacLightBlackLabel()
    let allTimeHighLabel = SeSacRedLabel().then {
        $0.text = "신고점"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let allTimeHighPriceLabel = SeSacLightBlackLabel()
    let allTimeLowLabel = SeSacBlueLabel().then {
        $0.text = "신저점"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let allTimeLowPriceLabel = SeSacLightBlackLabel()
    
    let chart = LineChartView()
    let lastUpdateLabel = SeSacLightBlackLabel()
    override func configureHierarchy() {
        [
            coinImageView,
            titleLabel,
            currentPriceLabel,
            percentageLabel,
            todayLabel,
            highLabel,
            highPriceLabel,
            lowLabel,
            lowPriceLabel,
            allTimeHighLabel,
            allTimeHighPriceLabel,
            allTimeLowLabel,
            allTimeLowPriceLabel,
            chart,
            lastUpdateLabel,
        ].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        
        coinImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(coinImageView)
            make.leading.equalTo(coinImageView.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
        
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(10)
            make.leading.equalTo(currentPriceLabel)
            make.height.equalTo(18)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel)
            make.leading.equalTo(percentageLabel.snp.trailing).offset(10)
            make.height.equalTo(percentageLabel)
        }
        
        highLabel.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(30)
            make.leading.equalTo(currentPriceLabel)
            make.height.equalTo(20)
        }
        
        highPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(highLabel.snp.bottom).offset(12)
            make.leading.equalTo(currentPriceLabel)
            make.height.equalTo(20)
        }
        
        allTimeHighLabel.snp.makeConstraints { make in
            make.top.equalTo(highPriceLabel.snp.bottom).offset(20)
            make.leading.equalTo(currentPriceLabel)
            make.height.equalTo(20)
        }
        
        allTimeHighPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(allTimeHighLabel.snp.bottom).offset(12)
            make.leading.equalTo(currentPriceLabel)
            make.height.equalTo(20)
        }
        
        lowLabel.snp.makeConstraints { make in
            make.top.height.equalTo(highLabel)
            make.centerX.equalToSuperview()
        }
        
        lowPriceLabel.snp.makeConstraints { make in
            make.top.height.equalTo(highPriceLabel)
            make.leading.equalTo(lowLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        allTimeLowLabel.snp.makeConstraints { make in
            make.top.height.equalTo(allTimeHighLabel)
            make.leading.equalTo(lowLabel)
        }
        
        allTimeLowPriceLabel.snp.makeConstraints { make in
            make.top.height.equalTo(allTimeHighPriceLabel)
            make.leading.equalTo(lowLabel)
            make.trailing.equalTo(lowPriceLabel)
        }
        
        chart.snp.makeConstraints { make in
            make.top.equalTo(allTimeHighPriceLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(lastUpdateLabel)
        }
        
        lastUpdateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(15)
        }
    }
    
    override func configureView() {
        
    }
    
}


// MARK: - Custom Func
extension ChartView {
    func updateView(_ data: Market?) {
        guard let data else { return }
        
        let url = URL(string: data.image)
        coinImageView.kf.setImage(with: url)
        
        let manager = NumberFormatterManager.shared
        
        titleLabel.text = data.name
        currentPriceLabel.text = manager.formatted(data.current_price)
        percentageLabel.text = data.price_change_percentage_24h.formattedPercent
        highPriceLabel.text = manager.formatted(data.high_24h)
        lowPriceLabel.text = manager.formatted(data.low_24h)
        allTimeHighPriceLabel.text = manager.formatted(data.ath)
        allTimeLowPriceLabel.text = manager.formatted(data.atl)
        lastUpdateLabel.text = DateFormatterManager.shared.dateFormat(date: data.last_updated)
        configureChart(data)
    }
    
    func configureChart(_ data: Market) {
        guard let sparkline = data.sparkline_in_7d else { return }
        let datas = sparkline.price
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<datas.count {
            let value = ChartDataEntry(x: Double(i), y: datas[i])
            lineChartEntry.append(value)
        }
        
        let set = LineChartDataSet(entries: lineChartEntry)
        set.colors = [.sesacPuple]
        set.highlightEnabled = false
        set.circleRadius = 0
        
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.xAxis.enabled = false
        chart.doubleTapToZoomEnabled = false
        chart.data = LineChartData(dataSet: set)
        chart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chart.legend.enabled = false
    }
}
