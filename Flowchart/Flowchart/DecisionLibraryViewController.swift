//
//  DecisionLibraryViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class DecisionLibraryViewController: UICollectionViewController {

    var didSelectDecision: (Decision) -> () = { _ in }
    var decisions: [Decision] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decisions.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DecisionCell", forIndexPath: indexPath) as? DecisionCell else { fatalError() }
        return decisions[indexPath.row].configure(cell)
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        didSelectDecision(decisions[indexPath.row])
    }


}

class DecisionCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!

}


extension Decision {

    func configure(cell: DecisionCell) -> DecisionCell {
        cell.label.text = self.title
        return cell
    }

}