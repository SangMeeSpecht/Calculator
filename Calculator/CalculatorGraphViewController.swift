//
//  CalculatorGraphViewController.swift
//  Calculator
//
//  Created by SangMee Specht on 4/12/17.
//  Copyright © 2017 SangMee Specht. All rights reserved.
//

import UIKit

class CalculatorGraphViewController: UIViewController {

    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.changeScale(_:))))
        }
    }

}


