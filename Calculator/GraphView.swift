//
//  GraphView.swift
//  Calculator
//
//  Created by SangMee Specht on 4/12/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    @IBInspectable
    private var origin: CGPoint = CGPoint(x: 0, y: 0) { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    private var scale: CGFloat = 50.0 { didSet { setNeedsDisplay() } }
    
    private var originSet = false
    
    private let graph = AxesDrawer()
    
    var function: ((Double) -> Double)? {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        if !originSet {
            setStartingOrigin()
            originSet = true
        }
        
        graph.drawAxes(in: rect, origin: origin, pointsPerUnit: scale)
        
        drawFunction()
    }
    
    func changeScale(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .changed {
            scale *= recognizer.scale
            recognizer.scale = 1.0
        }
    }
    
    func pan(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .changed {
            let distancePanned = recognizer.translation(in: self)
            setNewOrigin(withDistance: distancePanned)
            recognizer.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    func moveOrigin(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            let locationTapped = recognizer.location(in: self)
            origin = locationTapped
        }
    }
    
    private func drawFunction() {
        let path = UIBezierPath()
        var startOfPathDrawn = false
        
        if function != nil {
            for x in 0...scaledMaxXValue() {
                let pointX = CGFloat(x) / scale
                
                let xVal = Double((pointX - origin.x) / scale)
                let yVal = function!(xVal)
                
                if noValueFoundFor(yVal: yVal) {
                    startOfPathDrawn = false
                    continue
                }
                
                let pointY = origin.y - CGFloat(yVal) * scale
                
                if !startOfPathDrawn {
                    path.move(to: CGPoint(x: pointX, y: pointY))
                    startOfPathDrawn = true
                } else {
                    path.addLine(to: CGPoint(x: pointX, y: pointY))
                }
            }
            path.stroke()
        }
    }

    private func setStartingOrigin() {
        origin.x = bounds.midX
        origin.y = bounds.midY
    }
    
    private func setNewOrigin(withDistance distancePanned: CGPoint) {
        origin = CGPoint(x: distancePanned.x + origin.x, y: distancePanned.y + origin.y)
    }
    
    private func noValueFoundFor(yVal: Double) -> Bool {
        return !yVal.isZero && !yVal.isNormal
    }
    
    private func scaledMaxXValue() -> Int {
        return Int(bounds.width * scale)
    }
}
