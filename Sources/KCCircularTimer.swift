//  KCCircularTimer.swift
//  KCCircularTimer
//
//  Created by Kevin on 12/19/17.
//  Copyright © 2018 Kevin. All rights reserved.

import UIKit

@IBDesignable public class KCCircularTimer: UIView {
    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        // Set default values.
        currentValue = 0
        maximumValue = 1
        borderFactor = 0.05
        circleFactor = 0.05
        insetFactor = 0.1
        progressColor = .gray
        circleColor = .gray
        circleAlpha = 0.2
        font = UIFont.systemFont(ofSize: 12.0)
        fontName = ""
        fontSize = 0
        clockwise = false
        showNumber = true
        decimalPlaces = 0
        lineCap = .round
    }

    // MARK: - Properties
    
    /// The current value of the timer.
    @IBInspectable public var currentValue: Double {
        set {
            circleLayer.currentValue = newValue
        }
        get {
            return circleLayer.currentValue
        }
    }

    /// The maximum value of the timer.  Along with the current value, it
    /// is used to determine how much of the circle is filled.
    @IBInspectable public var maximumValue: Double {
        set {
            circleLayer.maximumValue = newValue
        }
        get {
            return circleLayer.maximumValue
        }
    }

    /// The percent of the size of the view to use
    /// as the width of the line of the progress arc.
    @IBInspectable public var borderFactor: CGFloat {
        set {
            circleLayer.borderFactor = newValue
        }
        get {
            return circleLayer.borderFactor
        }
    }

    /// The percent of the size of the view to use
    /// as the width of the line of the circle in the
    /// background.
    @IBInspectable public var circleFactor: CGFloat {
        set {
            circleLayer.circleFactor = newValue
        }
        get {
            return circleLayer.circleFactor
        }
    }

    /// The percent of the size of the view used to determine the
    /// distance the circle is inset from its edge.
    @IBInspectable public var insetFactor: CGFloat {
        set {
            circleLayer.insetFactor = newValue
        }
        get {
            return circleLayer.insetFactor
        }
    }

    /// The color of the progress arc.  Setting this property overrides
    /// any previous color set via the tintColor property.
    @IBInspectable public var progressColor: UIColor {
        set {
            circleLayer.progressColor = newValue
        }
        get {
            return circleLayer.progressColor
        }
    }

    /// The color of the background circle.  This property allows setting
    /// explicit color not based on the tintColor.
    @IBInspectable public var circleColor: UIColor {
        set {
            circleLayer.circleColor = newValue
        }
        get {
            return circleLayer.circleColor
        }
    }

    /// The alpha of the background circle.  Only used when setting the
    /// color via the tintColor.  The tintColor and this alpha are used
    /// to set the color of the background circle.  If you need finer
    /// control, set the circleColor directly.
    @IBInspectable public var circleAlpha: CGFloat {
        set {
            circleLayer.circleAlpha = newValue
            setColorFromTint()
        }
        get {
            return circleLayer.circleAlpha
        }
    }

    /// The font of the numeric timer in the center of the circle.
    public var font: UIFont {
        set {
            circleLayer.font = newValue
        }
        get {
            return circleLayer.font
        }
    }

    /// The name of the font to use for the numeric timer in the center
    /// of the circle.  If set and the font name is valid, it overrides
    /// the default which is the system font.
    @IBInspectable public var fontName: String? {
        didSet {
            guard let fontName = fontName, let customFont =
                UIFont(name: fontName, size: 12.0) else { return }
            font = customFont
        }
    }

    /// The font size of the numeric timer in the center of the circle.
    /// The default is 0 which results in a font size used based on the
    /// inner dimensions of the circle.
    @IBInspectable public var fontSize: CGFloat {
        set {
            circleLayer.fontSize = newValue
        }
        get {
            return circleLayer.fontSize
        }
    }

    /// Does the timer move clockwise or counter-clockwise.
    @IBInspectable public var clockwise: Bool {
        set {
            circleLayer.clockwise = newValue
        }
        get {
            return circleLayer.clockwise
        }
    }

    /// Determines if the numeric timer should be shown.
    @IBInspectable public var showNumber: Bool {
        set {
            circleLayer.showNumber = newValue
        }
        get {
            return circleLayer.showNumber
        }
    }

    /// The number of decimal places to display for the value.
    /// Valid values are 0, 1, and 2.
    @IBInspectable public var decimalPlaces: Int {
        set {
            circleLayer.decimalPlaces = newValue
        }
        get {
            return circleLayer.decimalPlaces
        }
    }

    /// The style of the end of the line for the progress arc.  Defaults
    /// to rounded.
    public var lineCap: CGLineCap {
        set {
            circleLayer.lineCap = newValue
        }
        get {
            return circleLayer.lineCap
        }
    }

    private func setColorFromTint() {
        progressColor = tintColor
        circleColor = tintColor.withAlphaComponent(circleLayer.circleAlpha)
    }

    enum Constants {
        static let currentValue = "currentValue"
    }

    /**
     Animate the timer from start to end over the specified duration.
     - parameter from: The starting value.
     - parameter to: The ending value.
     - parameter duration: The duration of the animation.  Defaults to the absolute
     value of the difference of start and end.
     - parameter isRemovedOnCompletion: If the animation is removed from the view
     when the animation completes.  Defaults to true.
     - parameter completion: Optional closure to execute when the animation completes.
     */
    public func animate(from start: Double,
                        to end: Double,
                        duration: Double? = nil,
                        isRemovedOnCompletion: Bool? = true,
                        completion: (() -> Void)? = nil) {
        circleLayer.removeAnimation(forKey: Constants.currentValue)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        let animation = CABasicAnimation(keyPath: Constants.currentValue)
        animation.duration = duration ?? abs(start - end)
        animation.fromValue = start
        currentValue = end
        animation.toValue = end
        #if swift(>=4.2)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        #else
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        #endif
        animation.isRemovedOnCompletion = isRemovedOnCompletion ?? true
        circleLayer.add(animation, forKey: Constants.currentValue)
        CATransaction.commit()
    }

    // MARK: Overrides

    override public func didMoveToWindow() {
        guard let window = window else { return }
        contentScaleFactor = window.screen.scale
    }

    override public class var layerClass: AnyClass {
        return KCCircleLayer.self
    }

    public override func tintColorDidChange() {
        super.tintColorDidChange()
        setColorFromTint()
    }

    // MARK: Convenience

    var circleLayer: KCCircleLayer {
        return layer as! KCCircleLayer
    }
}
