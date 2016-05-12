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
    @IBAction func addFlowchartAction(sender: UIButton) {

        if Flowchart.store.filter({ $0.title == title }).count == 0 {
            Flowchart.store.append(flowchart)
            processLibraryVC.items[1].configurators = processLibraryVC.items[1].configurators + [flowchart]
            processLibraryVC.tableView.reloadData()
        }

        self.flowchart = Flowchart(
            decision: Decision.True,
            yes: Process(transformation: { x in x }, title: "Identity"),
            no: Process(transformation: { x in x }, title: "Identity")
        )
        
        decisionVC.updateUI()
        processTrueVC.updateUI()
        processFalseVC.updateUI()

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
    var processLibraryVC: LibraryViewController!

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

                    if self.activeProcess == nil {
                        self.activeProcess = .True
                    } else {
                        self.activeProcess = nil
                    }

                }
            }
            vc.block = flowchart.yes
            processTrueVC = vc
            
        case .ProcessFalse:

            guard let vc = segue.destinationViewController as? ProcessViewController else { fatalError() }
            vc.direction = .False
            vc.toggleProcessLibrary = {
                UIView.animateWithDuration(0.3) {

                    if self.activeProcess == nil {
                        self.activeProcess = .False
                    } else {
                        self.activeProcess = nil
                    }

                }
            }
            vc.block = flowchart.no
            processFalseVC = vc
            
        case .DecisionLibrary:

            guard let vc = segue.destinationViewController as? LibraryViewController else { fatalError() }
            vc.items = [("Decisions", Decision.store.map { $0 as LibraryCellConfigurator })]
            vc.didSelectItem = { decision in
                guard let decision = decision as? Decision else { fatalError() }
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

            guard let vc = segue.destinationViewController as? LibraryViewController else { fatalError() }
            vc.items = [
                ("Processes", Process.store.map { $0 as LibraryCellConfigurator }),
                ("Flowchart", Flowchart.store.map { $0 as LibraryCellConfigurator })
            ]
            vc.didSelectItem = { cellConfig in

                guard let flow = self.activeProcess else { return }
                guard let block = cellConfig as? Block else { return }

                switch flow {

                case .True:
                    self.processTrueVC.block = block
                    self.flowchart = Flowchart(
                        decision: self.flowchart.decision,
                        yes: block,
                        no: self.flowchart.no,
                        title: self.flowchart.title
                    )

                case .False:
                    self.processFalseVC.block = block
                    self.flowchart = Flowchart(
                        decision: self.flowchart.decision,
                        yes: self.flowchart.yes,
                        no: block,
                        title: self.flowchart.title
                    )
                }

            }

            processLibraryVC = vc
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
        case .True:
            return
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

    private var activeProcess: ControlFlowDirection? {
        didSet {

            if activeProcess == nil {

                self.processLibrary.hidden = true
                self.processFalseView.layer.borderWidth = 0.0
                self.processFalseView.layer.borderColor = nil
                self.processTrueView.layer.borderWidth = 0.0
                self.processTrueView.layer.borderColor = nil

            } else if activeProcess! == .True {

                self.processLibrary.hidden = false
                self.processTrueView.layer.borderWidth = 3.0
                self.processTrueView.layer.borderColor = UIColor.blueColor().CGColor
                self.processFalseView.layer.borderWidth = 0.0
                self.processFalseView.layer.borderColor = nil

            } else {

                self.processLibrary.hidden = false
                self.processFalseView.layer.borderWidth = 3.0
                self.processFalseView.layer.borderColor = UIColor.blueColor().CGColor
                self.processTrueView.layer.borderWidth = 0.0
                self.processTrueView.layer.borderColor = nil
                
            }
        }
    }


    @IBOutlet weak var processTrueView: UIView!
    @IBOutlet weak var processFalseView: UIView!
    
    @IBOutlet weak var decisionLibrary: UIView!
    @IBOutlet weak var processLibrary: UIView!

    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!

}


