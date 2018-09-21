//  KCCircleLayer.swift
//  KCCircularTimer
//
//  Created by Kevin on 12/19/17.
//  Copyright © 2018 Kevin. All rights reserved.

import CoreGraphics
import UIKit

#if swift(>=4.2)
    typealias AttributedStringKey = NSAttributedString.Key
#else
    typealias AttributedStringKey = NSAttributedStringKey
#endif

final class KCCircleLayer: CALayer {
    // MARK: Constants
    let topPoint: CGFloat = -0.5 * .pi
    let fullRotation: CGFloat = 2 * .pi

    // MARK: Properties
    private static let NeedsDisplay = [
        "currentValue",
        "maximumValue",
        "tintColor",
        "progressColor",
        "circleColor",
        "circleAlpha",
        "borderFactor",
        "circleFactor",
        "insetFactor",
        "font",
        "fontSize",
        "clockwise",
        "showNumber",
        "decimalPlaces",
        "lineCap"
    ]

    // The underlying animation code requires @NSManaged for
    // properties that need to be copied to the animation layer.
    @NSManaged var currentValue: Double
    @NSManaged var maximumValue: Double
    @NSManaged var borderFactor: CGFloat
    @NSManaged var circleFactor: CGFloat
    @NSManaged var insetFactor: CGFloat
    @NSManaged var progressColor: UIColor
    @NSManaged var circleColor: UIColor
    @NSManaged var circleAlpha: CGFloat
    var font: UIFont = UIFont.systemFont(ofSize: 12.0)
    @NSManaged var fontSize: CGFloat
    @NSManaged var clockwise: Bool
    @NSManaged var showNumber: Bool
    @NSManaged var decimalPlaces: Int
    var lineCap: CGLineCap = .round

    // MARK: - Initializers
    override init() {
        super.init()
    }

    // Initializer for copying a layer.  Used for animations.
    override init(layer: Any) {
        super.init(layer: layer)
        guard let circleLayer = layer as? KCCircleLayer else { return }
        // Explicitly copy the non-NSManaged variables.
        lineCap = circleLayer.lineCap
        font = circleLayer.font
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override class func needsDisplay(forKey key: String) -> Bool {
        return NeedsDisplay.contains(key) ? true : super.needsDisplay(forKey: key)
    }

    // MARK: - Draw Code
    var currentPercent: CGFloat {
        return maximumValue == 0 ? 0 : CGFloat(currentValue/maximumValue)
    }

    override func draw(in context: CGContext) {
        super.draw(in: context)

        UIGraphicsPushContext(context)

        let size = min(bounds.width, bounds.height)

        let strokeWidth: CGFloat = borderFactor * size
        let circleWidth: CGFloat = circleFactor * size
        let circleInset: CGFloat = insetFactor * size

        // Calculate the outer border size.
        let outerDimension: CGFloat = size - 2.0 * circleInset
        // Center of the arc to draw.
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        // Set the width of the line of the circle.
        context.setLineWidth(circleWidth)
        // Set the tint color of the background circle.
        context.setStrokeColor(circleColor.cgColor)
        // Draw an underlying circle.
        context.addArc(center: center,
                       radius: outerDimension / 2,
                       startAngle: topPoint,
                       endAngle: fullRotation - topPoint,
                       clockwise: false)
        context.strokePath()

        // Draw the progress arc.
        context.setLineCap(lineCap)
        // Set the width of the arc.
        context.setLineWidth(strokeWidth)
        context.setStrokeColor(progressColor.cgColor)
        // Draw an arc for the partial circle.
        let currentPoint = topPoint + fullRotation * currentPercent
        context.addArc(center: center,
                       radius: outerDimension / 2,
                       startAngle: clockwise ? currentPoint : topPoint,
                       endAngle: clockwise ? topPoint : currentPoint,
                       clockwise: clockwise)
        context.strokePath()

        context.flush()

        if showNumber {
            // Compute the square that fits inside the circle then reduce it slightly.
            let innerSquareSide = outerDimension / sqrt(2.0) * 0.8
            let insetX = (bounds.width - innerSquareSide) / 2.0
            let insetY = (bounds.height - innerSquareSide) / 2.0
            let bounding = CGRect(x: bounds.minX + insetX,
                                  y: bounds.minY + insetY,
                                  width: innerSquareSide,
                                  height: innerSquareSide)
            // Draw the text in the rect of the inner circle.
            drawString(in: context, rect: bounding)
        }

        UIGraphicsPopContext()
    }

    private var numberFormat: String {
        switch decimalPlaces {
        case 1:
            return "%.01f"
        case 2:
            return "%.02f"
        default:
            return "%.0f"
        }
    }

    private func getFormattedValue() -> String {
        return String(format: numberFormat, currentValue)
    }

    func drawString(in context: CGContext, rect: CGRect) {
        let string = NSString(string: getFormattedValue())
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byClipping
        paragraphStyle.alignment = .center
        let textFontSize = fontSize > 0 ? fontSize : rect.height / 1.6
        let textAttributes: [AttributedStringKey: Any] = [
            .font: font.withSize(textFontSize),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor(cgColor: progressColor.cgColor)
        ]
        let size = string.size(withAttributes: textAttributes)
        let point = CGPoint(x: rect.midX - size.width / 2,
                            y: rect.midY - size.height / 2)
        string.draw(at: point, withAttributes: textAttributes)
    }
}
