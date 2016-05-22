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
    
    @IBAction func plus(){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.toKey = nil
    }

    @IBAction func reset(){
        let alert = UIAlertController(title: "リセット", message: "OKを押すとデータがリセットされます \n アプリを閉じます", preferredStyle: UIAlertControllerStyle.Alert)
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{(action:UIAlertAction!) -> Void in
            self.userDefault.removeObjectForKey("title")
            self.userDefault.removeObjectForKey("text")
            self.userDefault.removeObjectForKey("time")
            self.tableView.removeFromSuperview()
            self.a = 1
            exit(EXIT_FAILURE)
        })
        let action2:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{(action:UIAlertAction!) -> Void in
            self.a = 0
            //            exit(EXIT_FAILURE)
        })
        alert.addAction(action1)
        alert.addAction(action2)
        presentViewController(alert, animated: true, completion: nil)
    }
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
