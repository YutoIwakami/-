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
    var keys:[String]? = []
    var title2:String!
    var a:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        a = 0
        tableView.registerNib(UINib(nibName: "TableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        if let keys = userDefault.objectForKey("keys") as? [String] {
            self.keys = keys
        }
        self.tableView.reloadData()
        print(keys)
        /*if userDefault.arrayForKey("text") != nil{
            saveText = userDefault.arrayForKey("text")!
            super.viewWillAppear(animated)
            tableView.reloadData()
        }else{
            print("error")
        }*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let indexPath = self.tableView.indexPathForSelectedRow
        let key = keys![(indexPath?.row)!]
        let dictionary = userDefault.objectForKey(key)
        appDelegate.data = dictionary as? String
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let keys = self.keys {
            return keys.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        if let keys = self.keys {
            let key = keys[indexPath.row]
            let dictionary = userDefault.objectForKey(key as! String)
            
            tableViewCell.cell.text = dictionary!["title"] as? String
            tableViewCell.subtitle.text = dictionary!["text"] as? String
            tableViewCell.timeLabel.text = dictionary!["time"] as? String
        }
        
        return tableViewCell
    }
    
    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        performSegueWithIdentifier("toViewController",sender: nil)
        //        let viewController: UIViewController = ViewController()
        //        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc:ViewController = (segue.destinationViewController as? ViewController)!
        let keyArray = userDefault.arrayForKey("keys")
        print(keyArray)
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let dictionary: (AnyObject) = saveText[indexPath.row]
            NSLog("index:%d",indexPath.row)
            if indexPath.section == 0{
                vc.titleName = dictionary["title"] as? String
                vc.text = dictionary["text"] as? String
                vc.timeCell = dictionary["time"] as? String
                vc.a = a
            }
        }
        
    }*/
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

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


