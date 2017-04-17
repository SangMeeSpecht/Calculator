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
    private var origin = CGPoint(x: 0, y: 0){ didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    private var scale: CGFloat = 50.0 { didSet { setNeedsDisplay() } }
    
    private var newGraph = true
    
    private let graph = AxesDrawer()
    
    override func draw(_ rect: CGRect) {
        if newGraph {
            setStartingOrigin()
            newGraph = false
        }
        
        graph.drawAxes(in: rect, origin: origin, pointsPerUnit: scale)
    }
    
    func changeScale(_ recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    func pan(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .ended || recognizer.state == .changed {
            let distancePanned = recognizer.translation(in: self)
            
            setNewOrigin(withDistance: distancePanned)
            
            recognizer.setTranslation(CGPoint.zero, in: self)
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
