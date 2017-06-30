//
//  EditViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/06/30.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet var taskTextField : UITextField!
    
    var task = String()
    
    var saveData = UserDefaults.standard
    var todoArray = [Dictionary<String,Any>]()
    var timelyArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo") as! [Dictionary<String, Any>]
            
        }
        
        if saveData.array(forKey: "timely") != nil{
            timelyArray = saveData.array(forKey: "timely")!
            
        }
        
        
        
        taskTextField.text = timelyArray[0] as! String
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
