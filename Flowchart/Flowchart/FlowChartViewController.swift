//
//  FlowChartViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class FlowChartViewController: UIViewController, SegueHandlerType {

    @IBOutlet weak var nameField: UITextField!
    @IBAction func nameEditingDidEnd(sender: UITextField) {
        if let title = sender.text where !title.isEmpty {
            flowchart = Flowchart(
                decision: flowchart.decision,
                yes: flowchart.yes,
                no: flowchart.no,
                title: title)
        }
    }

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextField!

    @IBAction func inputEditingDidEnd(sender: UITextField) {
        evaluate()
    }

    var flowchart = Flowchart(
        decision: Decision.IsEqualTo(5),
        yes: Process(transformation: { x in x - 1 }, title: "Decrement"),
        no:  Process(transformation: { x in x + 1 }, title: "Increment")
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
            processTrueVC.isChosen = flowchart.decision.evaluate(n) == true
            processFalseVC.isChosen = flowchart.decision.evaluate(n) == false
            
        }

    }

    var decisionVC: DecisionViewController!
    var processTrueVC: ProcessViewController!
    var processFalseVC: ProcessViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        for v in [nameField, inputField, outputField] {
            v.layer.cornerRadius = 5.0
            v.layer.borderColor = UIColor.Steel.CGColor
            v.layer.borderWidth = 1.0
            
        }

    }

    enum SegueIdentifier: String {
        case Decision = "DecisionViewControllerSegueIdentifier"
        case ProcessTrue = "ProcessTrueViewControllerSegueIdentifier"
        case ProcessFalse = "ProcessFalseViewControllerSegueIdentifier"
        case DecisionLibrary = "DecisionLibraryViewControllerSegueIdentifier"
        case ProcessLibrary = "ProcessLibraryViewControllerSegueIdentifier"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        switch segueIdentifierForSegue(segue) {
            
        case .Decision:
            guard let vc = segue.destinationViewController as? DecisionViewController else { fatalError() }
            vc.decision = flowchart.decision
            vc.toggleDecisionLibrary = {
                UIView.animateWithDuration(0.3) {
                    self.decisionLibrary.hidden = !self.decisionLibrary.hidden
                }
            }
            vc.updateCallback = { decision in
                self.flowchart = Flowchart(
                    decision: decision,
                    yes: self.flowchart.yes,
                    no: self.flowchart.no,
                    title: self.flowchart.title
                )
            }
            decisionVC = vc

        case .ProcessTrue:
            guard let vc = segue.destinationViewController as? ProcessViewController else { fatalError() }
            vc.direction = .True
            vc.toggleProcessLibrary = {
                UIView.animateWithDuration(0.3) {
                    self.processLibrary.hidden = !self.processLibrary.hidden
                }
            }
            vc.block = flowchart.yes
            processTrueVC = vc
            
        case .ProcessFalse:
            guard let vc = segue.destinationViewController as? ProcessViewController else { fatalError() }
            vc.direction = .False
            vc.block = flowchart.no
            processFalseVC = vc
            
        case .DecisionLibrary:
            guard let vc = segue.destinationViewController as? DecisionLibraryViewController else { fatalError() }

            vc.didSelectDecision = { decision in
                switch decision {
                case .IsEven:
                    self.decisionVC.inputField.hidden = true
                default:
                    self.decisionVC.inputField.hidden = false
                }
                self.decisionVC.label.text = decision.title

                self.flowchart = Flowchart(
                    decision: decision,
                    yes: self.flowchart.yes,
                    no: self.flowchart.no,
                    title: self.flowchart.title
                )
            }

        case .ProcessLibrary:
            guard let vc = segue.destinationViewController as? ProcessLibraryViewController else { fatalError() }
            
        }

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }

    @IBOutlet weak var decisionLabel: UILabel!
    @IBOutlet weak var decisionInput: UITextField!

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
    @IBOutlet weak var processLibrary: UIView!

//    @IBAction func decisionViewAction(sender: AnyObject) {
//
//        UIView.animateWithDuration(0.3) {
//            self.decisionLibrary.hidden = !self.decisionLibrary.hidden
//        }
//    }

    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!

}


