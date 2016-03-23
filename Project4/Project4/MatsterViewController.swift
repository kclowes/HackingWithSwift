//
//  MatsterViewController.swift
//  Project4
//
//  Created by Keri Clowes on 3/22/16.
//  Copyright © 2016 Keri Clowes. All rights reserved.
//

import UIKit

class MatsterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = websites[indexPath.row]
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = object
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return websites.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    let object = websites[indexPath.row]
    cell.textLabel!.text = object
    return cell
  }

}
