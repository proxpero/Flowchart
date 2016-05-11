//
//  FlowChartViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class FlowChartViewController: UIViewController, SegueHandlerType {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextField!

    @IBAction func inputEditingDidEnd(sender: UITextField) {
        evaluate()
    }

    var flowchart = Flowchart(
        decision: Decision.IsEven,
        yes: Process(transformation: { x in x - 1 }),
        no:  Process(transformation: { x in x + 1 })
    ) {
        didSet {
            evaluate()
        }
    }

    func evaluate() {

        outputField.text = ""
        if let s = inputField.text,
               n = Int(s)
        {
            let output = flowchart.transform(n)
            outputField.text = String(output)
        }

    }

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

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }

    @IBOutlet weak var decisionLabel: UILabel!
    @IBOutlet weak var decisionInput: UITextField!

    func didSelectDecision(decision: Decision) {

        switch decision {
        case .IsEven:
            decisionInput.hidden = true
        default:
            decisionInput.hidden = false
        }

        decisionLabel.text = decision.title
        setDecision(decision)
    }

    @IBAction func decisionInputDidEndEditing(sender: UITextField) {

        // A lens would make this nicer

        setDecision(flowchart.decision)
        
    }

    func setDecision(decision: Decision) {

        guard let
            s = decisionInput.text,
            n = Int(s)
            else { print(decisionInput.text); print(Int(decisionInput.text!)); return }
        let newDecision: Decision
        switch decision {
        case .IsEven:
            return
        case .IsEqualTo(_):
            newDecision = .IsEqualTo(n)
        case .IsGreaterThan(_):
            newDecision = .IsGreaterThan(n)
        case .IsLessThan(_):
            newDecision = .IsLessThan(n)
        }
        self.flowchart = Flowchart(decision: newDecision, yes: flowchart.yes, no: flowchart.no)

    }

    @IBOutlet weak var decisionLibrary: UIView!

    @IBAction func decisionViewAction(sender: AnyObject) {

        UIView.animateWithDuration(0.3) {
            self.decisionLibrary.hidden = !self.decisionLibrary.hidden
        }
    }
    
}


