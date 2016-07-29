//
//  TableViewController.swift
//  PetraDirectory
//
//  Created by Justinus Andjarwirawan on 10/1/15.
//  Copyright © 2015 Petra Christian University. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {

    var userName: [String] = []
    var realName: [String] = []
    var otherInfo: [String] = []
    
    var filteredUserName: [String] = []
    var filteredRealName: [String] = []
    var filteredOtherInfo: [String] = []
    
    var searchResult = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.searchResult = UISearchController(searchResultsController: nil)
        self.searchResult.searchResultsUpdater = self
        self.searchResult.dimsBackgroundDuringPresentation = false
        self.searchResult.searchBar.sizeToFit()
        self.searchResult.searchBar.placeholder = "Search name"
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.tableHeaderView = self.searchResult.searchBar
        //dibawah ini untuk hide searchbar di awal, jumlah elemen array harus lebih dari 1 layar!
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        self.tableView.reloadData()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.searchResult.active {
            return self.filteredRealName.count
        } else {
            return userName.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "myCell";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
        // Configure the cell...
        if self.searchResult.active {
            cell.userName.text = self.userName[indexPath.row]
            cell.realName.text = self.filteredRealName[indexPath.row]
            cell.otherInfo.text = self.otherInfo[indexPath.row]
        } else {
            cell.userName.text = self.userName[indexPath.row]
            cell.realName.text = self.realName[indexPath.row]
            cell.otherInfo.text = self.otherInfo[indexPath.row]
        }
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredRealName.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.realName as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredRealName = array as! [String]
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


}
