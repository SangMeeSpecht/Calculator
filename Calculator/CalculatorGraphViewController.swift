//
//  CalculatorGraphViewController.swift
//  Calculator
//
//  Created by SangMee Specht on 4/12/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

class CalculatorGraphViewController: UIViewController {
    var function: ((Double) -> Double)?
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.function = function
            
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.changeScale(_:))))
            
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: #selector(GraphView.pan(_:))))
            
            let doubleTap = UITapGestureRecognizer(target: graphView, action: #selector(GraphView.moveOrigin(_:)))
            doubleTap.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(doubleTap)
        }
    }
}



