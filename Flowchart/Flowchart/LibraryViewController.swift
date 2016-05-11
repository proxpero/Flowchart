//
//  LibraryViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var decisions: [Decision] = [
        Decision.IsEven,
        Decision.IsEqualTo(0),
        Decision.IsLessThan(0),
        Decision.IsGreaterThan(0)
    ]
    
    var didSelectDecision: (Decision) -> () = { _ in }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return decisions.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LibraryCell", forIndexPath: indexPath) as? LibraryCell else { fatalError() }
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        cell.backgroundColor = UIColor.Mercury
        return decisions[indexPath.row].configure(cell)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        didSelectDecision(decisions[indexPath.row])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.Mercury.CGColor
        view.layer.borderWidth = 1.0
    }

}

class LibraryCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}


extension Decision {

    func configure(cell: LibraryCell) -> LibraryCell {
        cell.label.text = self.title
        return cell
    }

}