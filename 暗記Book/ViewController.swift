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
        time.text = "T"
        
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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        guard let key = appDelegate.toKey else { return }
        let data = userDefault.objectForKey(key) as! [String : String]
        print(data)
        textView.text = data["text"]
        textField.text = data["title"]
        time.text = data["time"]
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
            dateFormatter.timeStyle = .MediumStyle
            dateFormatter.dateStyle = .MediumStyle
            time.text = (dateFormatter.stringFromDate(now))
            
            let key: String = NSUUID().UUIDString
            print(key)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let textData = ["text":textView.text,"title":textField.text,"time":time.text]
            if appDelegate.toKey == nil{
            userDefault.setObject(textData, forKey: key)
            }else{
                userDefault.setObject(textData, forKey: appDelegate.toKey!)
            }
            if let keys = userDefault.valueForKey("keys") as? [String] {
                var keysArray = keys
                keysArray.append(key)
                userDefault.setObject(keysArray, forKey: "keys")
            } else {
                let keysArray = [key]
                userDefault.setObject(keysArray, forKey: "keys")
            }
            userDefault.synchronize()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    }

