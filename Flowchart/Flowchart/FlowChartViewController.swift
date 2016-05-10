//
//  FlowChartViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class FlowChartViewController: UIViewController {

    @IBOutlet weak var libraryView: UIStackView!








    @IBAction func toggleLibraryAction(sender: UIButton) {

        UIView.animateWithDuration(0.3) {
            self.libraryView.hidden = !self.libraryView.hidden
        }

    }
    
}


