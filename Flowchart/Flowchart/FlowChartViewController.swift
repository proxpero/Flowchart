//
//  FlowChartViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class FlowChartViewController: UIViewController, SegueHandlerType {

    var flowcharts: [Flowchart] = []
    var processes: [Process] = []

    enum SegueIdentifier: String {
        case Decision = "DecisionViewControllerSegueIdentifier"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        switch segueIdentifierForSegue(segue) {
        case .Decision:
            guard let vc = segue.destinationViewController as? DecisionLibraryViewController else { fatalError() }
            vc.didSelectDecision = didSelectDecision
        }

    }


    @IBOutlet weak var decisionLabel: UILabel!

    func didSelectDecision(decision: Decision) {
        decisionLabel.text = decision.title
        
    }

    @IBOutlet weak var decisionLibrary: UIView!

    @IBAction func decisionViewAction(sender: AnyObject) {

        UIView.animateWithDuration(0.3) {
            self.decisionLibrary.hidden = !self.decisionLibrary.hidden
        }
    }
    
}


