//
//  TableViewController.swift
//  暗記Book
//
//  Created by T80 on 2016/04/01.
//
//

import UIKit

class TableViewController: UITableViewController ,UIAlertViewDelegate{
    
    //var saveText: [AnyObject] = []
    let userDefault = NSUserDefaults.standardUserDefaults()
    var keys:[String]?
    //    var title2:String!
    var a:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = editButtonItem()
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toKey = nil
        a = 0
        tableView.registerNib(UINib(nibName: "TableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let keys = userDefault.valueForKey("keys") as? [String] {
            self.keys = keys
        }
        self.tableView.reloadData()
    }

//⇩編集
//    //edit
//    override func setEditing(editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        self.tableView.editing = editing
//    }
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    
//    }

    //
    
    override func tableView(tableView: UITableView,canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        keys?.removeAtIndex(indexPath.row)
        userDefault.setObject(keys, forKey: "keys")
        
        self.tableView.reloadData()
    }
//⇧編集
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let keys = self.keys {
            return keys.count
        } else {
            print("error")
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        guard let keys = self.keys else { return UITableViewCell() }
        let key = keys[indexPath.row]
        guard let dictionary = userDefault.objectForKey(key) else { return UITableViewCell() }
        
        tableViewCell.cell.text = dictionary["title"] as? String
        tableViewCell.subtitle.text = dictionary["text"] as? String
        tableViewCell.timeLabel.text = dictionary["time"] as? String
        
        return tableViewCell
    }
    
    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toKey = keys![indexPath.row]
        performSegueWithIdentifier("toViewController",sender: nil)
        //        let viewController: UIViewController = ViewController()
        //        self.presentViewController(viewController, animated: true, completion: nil)
    }
}
