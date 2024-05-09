//
//  BarChart.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 9.05.2024.
//

import Foundation
import UIKit

class BarChartView: UIScrollView {

    var dataEntries: [PointEntry]? {
        didSet {
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        showsHorizontalScrollIndicator = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach { $0.removeFromSuperview() }

        guard let dataEntries = dataEntries else { return }

        let maxValue = dataEntries.max { $0.value < $1.value }?.value ?? 0
        let minValue = dataEntries.min { $0.value < $1.value }?.value ?? 0

        let barWidth: CGFloat = 20
        let padding: CGFloat = 8
        var contentWidth: CGFloat = padding

        for (i, entry) in dataEntries.enumerated() {
            let barHeight = frame.height - 2 * padding
            let x = CGFloat(i) * (barWidth + padding) + padding
            let y = getYPoint(value: entry.value, maxValue: maxValue, minValue: minValue)

            let barRect = CGRect(x: x, y: y, width: barWidth, height: barHeight)
            let barView = UIView(frame: barRect)
            barView.backgroundColor = UIColor.blue
            addSubview(barView)

            let valueLabel = UILabel()
            valueLabel.textAlignment = .left
            valueLabel.numberOfLines = 0
            valueLabel.font = UIFont.systemFont(ofSize: 10)
            valueLabel.textColor = UIColor.black
            valueLabel.text = String(format: "%.2f", entry.value)
            valueLabel.frame = CGRect(x: x, y: y - 45, width: 30, height: 56)
            addSubview(valueLabel)

            contentWidth += barWidth + padding
        }

        contentSize = CGSize(width: contentWidth, height: frame.height)
    }

    func getYPoint(value: CGFloat, maxValue: CGFloat, minValue: CGFloat) -> CGFloat {
        let padding: CGFloat = 30
        let graphHeight = frame.height - 2 * padding
        return padding + (1 - (value - minValue) / (maxValue - minValue)) * graphHeight
    }

    func convertToPointEntry(_ dataEntries: [String]) -> [PointEntry] {
        return dataEntries.enumerated().map { PointEntry(value: CGFloat(Double($0.element) ?? 0), label: "\($0.offset)") }
    }
}

