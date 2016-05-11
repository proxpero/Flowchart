//
//  SegueHandlerType.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/9/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where
    Self: UIViewController,
    SegueIdentifier.RawValue == String
{

    func performSegueWithIdentifer(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }

    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else { fatalError("Invalid identifier for segue: \(segue)") }
        return segueIdentifier
    }

}