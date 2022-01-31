//
//  UIView+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2022 RichAppz Limited (https://richappz.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

private let kBlurViewTag: Int = 55378008

public extension UIView {
    
    var convertToImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    //==================================================
    // MARK: Origins
    //==================================================
    
    var origin: CGPoint {
        get { return frame.origin }
        set (newOrigin) { frame.origin = newOrigin }
    }
    
    var originX: CGFloat {
        get { return frame.origin.x }
        set (newOriginX) { frame.origin.x = newOriginX }
    }
    
    var originY: CGFloat {
        get { return frame.origin.y }
        set (newOriginY) { frame.origin.y = newOriginY }
    }
    
    //==================================================
    // MARK: Size
    //==================================================
    
    var size: CGSize {
        get { return frame.size }
        set (newSize) { frame.size = newSize }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set (newWidth) { frame.size.width = newWidth }
    }
    
    var height: CGFloat {
        get { return frame.size.height }
        set (newHeight) { frame.size.height = newHeight }
    }
    
    //==================================================
    // MARK: Edges
    //==================================================
    
    var bottomEdge: CGFloat {
        get { return originY + height }
        set (newBottomEdge) { frame.origin.y = newBottomEdge - height }
    }
    
    var rightEdge: CGFloat {
        get { return originX + width }
        set (newRightEdge) { frame.size.height = newRightEdge - size.width }
    }
    
    //==================================================
    // MARK: Customizations
    //==================================================
    
    /**
     Sets up the `UIVisualEffect` on the view
     - Parameter effectType: UIBlurEffect.Style
     */
    func setBlur(_ effectType: UIBlurEffect.Style = .dark) {
        var blurEffect = UIVisualEffect()
        blurEffect = UIBlurEffect(style: effectType)
        
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.tag = kBlurViewTag
        blur.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blur, at: 0)
        
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor)]
        )
    }
    
    func removeBlur() {
        subviews.first(where: { $0.tag == kBlurViewTag })?.removeFromSuperview()
    }
    
    /**
     Adds a shadow to a `UIView` this can be default with already set parameters or you can provide a setup
     - Parameter path: CGPath? = nil
     - Parameter opacity: Float = 1
     - Parameter radius: CGFloat = 20
     - Parameter height: CGFloat = 19
     - Parameter color: UIColor = .black
     */
    func addShadow(path: CGPath? = nil, opacity: Float = 1, radius: CGFloat = 20, height: CGFloat = 19, color: UIColor = .black) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: height)
        layer.shadowRadius = radius
        
        if let path = path {
            layer.shadowPath = path
        }
    }
    
    /// function to create dotted line view
    func applyDottedLine(width: CGFloat, color: UIColor?) {
        createDashedLine(from: CGPoint(x: 0, y: 0), to: CGPoint(x: self.frame.size.width, y: 0), color: color ?? UIColor.black, strokeLength: 1, gapLength: 5, width: width)
    }
    
    func applyBorder(color: CGColor, width: CGFloat) {
        layer.borderColor = color
        layer.borderWidth = width
    }
    
    /**
     Removes any shadows that are on a `UIView`
     */
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = .zero
    }
    
    //==================================================
    // MARK: Animations
    //==================================================
    
    /**
     Shake the `UIView` great for showing an issue
     */
    func shakeView() {
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from_point: CGPoint = CGPoint(x: center.x - 10, y: center.y)
        let from_value: NSValue = NSValue(cgPoint: from_point)
        
        let to_point: CGPoint = CGPoint(x: center.x + 10, y: center.y)
        let to_value: NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        layer.add(shake, forKey: "position")
    }
    
    /**
     Bounce `UIView` animation - great for popping views onto the display
     - Parameter completion: (() -> Void)? = nil
     */
    func bounceView(completion: (() -> Void)? = nil) {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(
            withDuration: Animation.standard,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 2,
            options: [],
            animations: {
                self.alpha = 1
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            completion?()
        })
    }
    
    /**
     Fade in `UIView` - with default setup
     - Parameter time: TimeInterval = 0.3
     - Parameter alpha: CGFloat = 1
     - Parameter completion: (() -> Void)? = nil
     */
    func fadeIn(time: TimeInterval = Animation.standard, alpha: CGFloat = 1, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: time,
            animations: {
                self.alpha = alpha
        }, completion: { _ in
            completion?()
        })
    }
    
    /**
     Rotate `UIView`
     - Parameter toValue
     - Parameter duration
     */
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    /**
     Fade out `UIView` - with default setup
     - Parameter time: TimeInterval = 0.3
     - Parameter alpha: CGFloat = 1
     - Parameter completion: (() -> Void)? = nil
     */
    func fadeOut(time: TimeInterval = Animation.standard, alpha: CGFloat = 0, completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: time,
            animations: {
                self.alpha = alpha
        }, completion: { _ in
            completion?()
        })
    }
    
    /**
     Add specific corners to `UIView`
     - Parameter corners: UIRectCorner
     - Parameter radius: CGFloat
     */
    func addRoundedCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /**
     Inside a stackview this will follow a change alpha and hide pattern (which is animated)
     - Parameter isHidden: Bool
     */
    func setStackVisibliblity(isHidden: Bool) {
        guard self.isHidden != isHidden else { return }
        UIView.animate(withDuration: Animation.standard, animations: {
            if isHidden {
                self.alpha = 0
            } else {
                self.isHidden = isHidden
            }
        }, completion: { _ in
            UIView.animate(withDuration: Animation.standard) {
                if isHidden {
                    self.isHidden = isHidden
                } else {
                    self.alpha = 1
                }
            }
        })
    }
    
    /**
     Animated the layout of a `UIView` layoutIfNeeded
     - Parameter animated: Bool = false
     */
    func layoutIfNeeded(animated: Bool = false) {
        UIView.animate(
            withDuration: animated ? Animation.standard : Animation.none,
            delay: 0,
            options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
        })
    }
    
    //==================================================
    // MARK: Helpers
    //==================================================
    
    /**
     Find an image in a view subviews
     - Parameter image: UIImage?
     - Parameter completion: ((UIView) -> Void)
     */
    func findView(_ image: UIImage?, completion: ((UIView) -> Void)) {
        guard let image = image else { return }
        
        loopViewHierarchy { (view, stop) in
            if let view = view as? UIImageView {
                stop = view.image == image
                if stop {
                    completion(view)
                }
            }
        }
    }
    
    /**
     Find a view in a view subviews
     - Parameter v: UIView
     - Parameter completion: ((UIView) -> Void)
     */
    func findView(_ v: UIView, completion: ((UIView) -> Void)) {
        loopViewHierarchy { (view, stop) in
            if let view = view as? UIImageView {
                stop = view == v
                if stop {
                    completion(view)
                }
            }
        }
    }
    
    /**
     Loop hierarchy
     - Parameter block: (_ view: UIView, _ stop: inout Bool) -> Void
     */
    func loopViewHierarchy(block: (_ view: UIView, _ stop: inout Bool) -> Void) {
        var stop = false
        block(self, &stop)
        if !stop {
            self.subviews.forEach { $0.loopViewHierarchy(block: block) }
        }
    }
    
    /**
     Fetch an array of `T: UIView` views in a view
     eg: `let views: UITableView = view.getGenericViews()`
     */
    func getGenericViews<T: UIView>() -> [T] {
        var array = [T]()

        subviews.forEach {
            array += $0.getGenericViews()

            if let view = $0 as? T {
                array.append(view)
            }
        }
        return array
    }
    
    /**
     Loads instance from nib with the same name.
     */
    var loadNib: UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    /**
     adds dashed line on the view
     - Parameter effectType: UIBlurEffect.Style
     - Parameter point1: CGPoint
     - Parameter point2: CGPoint
     - Parameter color: UIColor
     - Parameter strokeLength: NSNumber
     - Parameter gapLength: NSNumber
     - Parameter width: CGFloat
     */
    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]
        
        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    //==================================================
    // MARK: Loading NIB Helpers
    //==================================================
    
    func prepare() {
        guard let view = loadViewFromNib() else {
            debugPrint("*** \(String(describing: type(of: self))) is not compiling - fix before deployment ***")
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view
    }
    
}
