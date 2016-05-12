//
//  LibraryViewController.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var items: Array<(title: String, configurators: [LibraryCellConfigurator])> = []
    
    var didSelectItem: (LibraryCellConfigurator) -> () = { _ in }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].configurators.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("LibraryCell") as? LibraryCell else { fatalError() }
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        cell.backgroundColor = UIColor.Mercury
        let item = items[indexPath.section].configurators[indexPath.row]
        return item.configure(cell)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectItem(items[indexPath.section].configurators[indexPath.row])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.Mercury.CGColor
        view.layer.borderWidth = 1.0
    }

}

public class LibraryCell: UITableViewCell { }

protocol LibraryCellConfigurator {
    func configure(cell: LibraryCell) -> LibraryCell
}

extension LibraryCellConfigurator where Self: CustomTitleConvertible {
    func configure(cell: LibraryCell) -> LibraryCell {
        cell.textLabel?.text = self.title
        return cell
    }
}

extension Decision: LibraryCellConfigurator { }
extension Process: LibraryCellConfigurator { }
extension Flowchart: LibraryCellConfigurator { }
