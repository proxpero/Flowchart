//
//  DecisionViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/11/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class DecisionViewController: UIViewController {

    var decision: Decision! {
        didSet {
            guard label != nil else { return }
            guard inputField != nil else { return }
            updateUI()
            updateCallback(decision)
        }
    }

    func updateUI() {
        label.text = decision.title
        switch decision! {
        case .True:
            inputField.hidden = true
        case .IsEven:
            inputField.hidden = true
        case .IsEqualTo(let x):
            inputField.hidden = false
            inputField.text = String(x)
        case .IsLessThan(let x):
            inputField.hidden = false
            inputField.text = String(x)
        case .IsGreaterThan(let x):
            inputField.hidden = false
            inputField.text = String(x)
        }
    }

    var toggleDecisionLibrary: () -> () = { }
    var updateCallback: (Decision) -> () = { _ in }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputField: UITextField!

    @IBAction func didRecognizeTapGesture(sender: UITapGestureRecognizer) {
        toggleDecisionLibrary()
    }

    @IBAction func inputDidEndEditing(sender: UITextField) {

        guard let s = sender.text,
                  n = Int(s) else { return }
        decision = decision.decisionWithValue(n)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        for v in [view, inputField] {
            v.layer.cornerRadius = 5.0
            v.layer.borderColor = UIColor.Steel.CGColor
            v.layer.borderWidth = 1.0
        }
        view.backgroundColor = UIColor.Mercury
    }
}
