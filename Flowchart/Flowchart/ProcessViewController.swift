//
//  ProcessViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/11/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

enum ControlFlowDirection {

    case True
    case False

    var caption: String {
        switch self {
        case .True:
            return "If True:"
        case .False:
            return "If False:"
        }
    }
}

class ProcessViewController: UIViewController {

    var block: Block! {
        didSet {
            guard let _ = imageView, _ = captionView, _ = descriptionView else { return }
            updateUI()
        }
    }

    var direction: ControlFlowDirection = .True {
        didSet {
            guard imageView != nil else { return }
            updateUI()
        }
    }

    var isChosen: Bool? {
        didSet {
            guard imageView != nil else { return }
            updateUI()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!

    func updateUI() {

        if isChosen != nil {
            imageView.image = isChosen! ? UIImage(named: "Check")! : UIImage(named: "Cross")!
        } else {
            imageView.image = UIImage(named: "Unknown")!
        }

        captionView.text = direction.caption
        descriptionView.text = block.title
    }

    var toggleProcessLibrary: () -> () = { }

    @IBAction func didRecognizeTapGesture(sender: UITapGestureRecognizer) {
        toggleProcessLibrary()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.Steel.CGColor
        view.layer.borderWidth = 1.0
        view.backgroundColor = UIColor.Mercury
    }

    
}
