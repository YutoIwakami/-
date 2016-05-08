//
//  ViewController.swift
//  暗記Book
//
//  Created by T80 on 2016/04/01.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField:UITextField!
    @IBOutlet var textView:UITextView!
    var saveText: [AnyObject] = []
    let userDefault = NSUserDefaults.standardUserDefaults()
    var titleName:String!
    var text:String!
    var alertTitle:String!
    var alertText:String!
    var timeCell:String!
    @IBOutlet var time:UILabel!
    var a:Int = 0
    var fontSize:Double!
    @IBOutlet var stepper:UIStepper!
    
    let now = NSDate() // 現在日時の取得
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        stepper.value = fontSize
        //        stepper.minimumValue = 5
        //        stepper.maximumValue = 50
        //        textView.text = "\(stepper.value)"
        //        fontSize = 15
        //        textView.font = UIFont.systemFontOfSize(fontSize)
        
        if a == 1{
            userDefault.removeObjectForKey("title")
            userDefault.removeObjectForKey("text")
            userDefault.removeObjectForKey("time")
        }
        time.text = " "
        if userDefault.arrayForKey("text") != nil{
            saveText = userDefault.arrayForKey("text")!
        }
        if time.text == ""{
            dateFormatter.locale = NSLocale(localeIdentifier: "en_JP") // ロケールの設定
            dateFormatter.timeStyle = .LongStyle
            dateFormatter.dateStyle = .LongStyle
            time.text = (dateFormatter.stringFromDate(now))
        }
        
        time.text = timeCell
        textField.text = titleName
        textView.text = text
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func sizePlus(){
        fontSize = fontSize + 1
    }
    
    @IBAction func save(){
        self.view.endEditing(true)
        if textField.text == ""{
            alertTitle = ""
            alertText = "タイトルを入力してください"
            let alert = UIAlertController(title: "保存に失敗しました", message: "タイトルを入力してください", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }else{
            dateFormatter.locale = NSLocale(localeIdentifier: "en_JP") // ロケールの設定
            dateFormatter.timeStyle = .LongStyle
            dateFormatter.dateStyle = .LongStyle
            time.text = (dateFormatter.stringFromDate(now))
            
            let key: String = NSUUID().UUIDString
            let textData = ["text":textView.text,"title":textField.text,"time":time.text]
            
            userDefault.setObject(textData, forKey: key)
            var keyArray = userDefault.arrayForKey("keys")
            keyArray?.append(key)
            saveText.append(textData)
            userDefault.setObject(keyArray, forKey: "keys")
            userDefault.setObject(textData, forKey: "text")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

