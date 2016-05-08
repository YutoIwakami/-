//
//  TableViewController.swift
//  暗記Book
//
//  Created by T80 on 2016/04/01.
//
//

import UIKit

class TableViewController: UITableViewController ,UIAlertViewDelegate{
    
    var saveText: [AnyObject] = []
    let userDefault = NSUserDefaults.standardUserDefaults()
    var title2:String!
    var a:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print(userDefault.arrayForKey("keys"))
        
        a = 0
        
        tableView.registerNib(UINib(nibName: "TableViewCell",bundle: nil), forCellReuseIdentifier: "cell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
//        text2 = "a"
//        userDefault.setObject(text2, forKey: "text")
        
        if userDefault.arrayForKey("text") != nil{
        saveText = userDefault.arrayForKey("text")!
            super.viewWillAppear(animated)
        tableView.reloadData()
        }else{
            print("error")
        }
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
        return saveText.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        let dictionary: (AnyObject) = saveText[indexPath.row]
        
//        userDefault.setObject(text, forKey: "title")
        tableViewCell.cell.text = dictionary["title"] as? String
        tableViewCell.subtitle.text = dictionary["text"] as? String
        tableViewCell.timeLabel.text = dictionary["time"] as? String
        
        return tableViewCell
    }

    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        performSegueWithIdentifier("toViewController",sender: nil)
//        let viewController: UIViewController = ViewController()
//        self.presentViewController(viewController, animated: true, completion: nil)
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc:ViewController = (segue.destinationViewController as? ViewController)!
        var keyArray = userDefault.arrayForKey("keys")
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
        
    }
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


