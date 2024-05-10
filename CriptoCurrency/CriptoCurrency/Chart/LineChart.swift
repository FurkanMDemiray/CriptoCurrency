//
//  LineChart.swift
//  CriptoCurrency
//
//  Created by Melik Demiray on 9.05.2024.
//

import Foundation
import UIKit

struct PointEntry {
    let value: CGFloat
    let label: String
}

class LineChart: UIView {

    var dataEntries: [PointEntry]? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let dataEntries = dataEntries else { return }

        let maxValue = dataEntries.max { $0.value < $1.value }?.value ?? 0
        let minValue = dataEntries.min { $0.value < $1.value }?.value ?? 0

        let lineGraph = UIBezierPath()
        UIColor.systemBlue.set()

        for (i, entry) in dataEntries.enumerated() {
            let x = getXPoint(index: i, totalEntries: dataEntries.count)
            let y = getYPoint(value: entry.value, maxValue: maxValue, minValue: minValue)

            if i == 0 {
                lineGraph.move(to: CGPoint(x: x, y: y))
            } else {
                lineGraph.addLine(to: CGPoint(x: x, y: y))
            }
        }

        lineGraph.stroke()
        drawAxisLines(maxValue: maxValue, minValue: minValue)
    }

    func getXPoint(index: Int, totalEntries: Int) -> CGFloat {
        let padding: CGFloat = 8
        let availableWidth = frame.width - padding * 2
        let pointSpacing: CGFloat = availableWidth / CGFloat(totalEntries - 1)
        return padding + CGFloat(index) * pointSpacing
    }

    func getYPoint(value: CGFloat, maxValue: CGFloat, minValue: CGFloat) -> CGFloat {
        let padding: CGFloat = 30
        let graphHeight = frame.height - padding * 2
        let yPoint = graphHeight * ((maxValue - value) / (maxValue - minValue)) + padding
        return yPoint
    }

    func drawAxisLines(maxValue: CGFloat, minValue: CGFloat) {
        let axisPath = UIBezierPath()
        UIColor.black.set()

        let padding: CGFloat = 8
        _ = frame.height - padding * 2
        let minValueY = getYPoint(value: minValue, maxValue: maxValue, minValue: minValue)
        let maxValueY = getYPoint(value: maxValue, maxValue: maxValue, minValue: minValue)

        let xStartPoint = CGPoint(x: padding, y: frame.height - 30)
        let xEndPoint = CGPoint(x: frame.width - padding, y: frame.height - 30)
        axisPath.move(to: xStartPoint)
        axisPath.addLine(to: xEndPoint)

        let minValueLabel = UILabel(frame: CGRect(x: xStartPoint.x, y: minValueY, width: 80, height: 15))
        minValueLabel.textAlignment = .left
        minValueLabel.font = UIFont.systemFont(ofSize: 10)
        minValueLabel.textColor = UIColor.black
        if minValue < 1 {
            minValueLabel.text = String(format: "%.5f", minValue)
        } else {
            minValueLabel.text = String(format: "%.2f", minValue)
        }
        addSubview(minValueLabel)

        let maxValueLabel = UILabel(frame: CGRect(x: xStartPoint.x, y: maxValueY - 24, width: 80, height: 15))
        maxValueLabel.textAlignment = .left
        maxValueLabel.font = UIFont.systemFont(ofSize: 10)
        maxValueLabel.textColor = UIColor.black
        if maxValue < 1 {
            maxValueLabel.text = String(format: "%.5f", maxValue)
        } else {
            maxValueLabel.text = String(format: "%.2f", maxValue)
        }
        addSubview(maxValueLabel)

        axisPath.move(to: CGPoint(x: padding, y: 20))
        axisPath.addLine(to: CGPoint(x: padding, y: frame.height - 30))

        axisPath.stroke()
    }

    func convertToPointEntry(_ dataEntries: [String]) -> [PointEntry] {
        return dataEntries.enumerated().map { PointEntry(value: CGFloat(Double($0.element) ?? 0), label: "\($0.offset)") }
    }
}
