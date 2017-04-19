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
    
    private var newGraph = true
    
    private let graph = AxesDrawer()
    
    var expression = "no function entered"
    
    override func draw(_ rect: CGRect) {
        if newGraph {
            setStartingOrigin()
            newGraph = false
        }
        graph.drawAxes(in: rect, origin: origin, pointsPerUnit: scale)
        
        print("Drawing a function using this expression: \(expression)")

//            let aPath = UIBezierPath()
//        
//            aPath.move(to: CGPoint(x: origin.x + (1 * scale), y: origin.y - (2 * scale)))
//            aPath.addLine(to: CGPoint(x: 0, y: 400))
//        
//            aPath.close()
//        
//            //If you want to stroke it with a red color
//            UIColor.red.set()
//            aPath.stroke()
//            //If you want to fill it as well 
//            aPath.fill()
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

    private func setStartingOrigin() {
        origin.x = bounds.midX
        origin.y = bounds.midY
    }
    
    private func setNewOrigin(withDistance distancePanned: CGPoint) {
        origin = CGPoint(x: distancePanned.x + origin.x, y: distancePanned.y + origin.y)
    }
}
