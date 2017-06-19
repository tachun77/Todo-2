//
//  contentsViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/29.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit

class contentsViewController: UIViewController {
    
    
    @IBOutlet var contentLabel : UILabel!
    @IBOutlet var tasklabel : UILabel!
    
    var selectedcontent = String()
    var writtentask = String()
    var importance = String()
    var keiken = Int()
    
    let saveData = UserDefaults.standard
    var todoArray = [Any]()
    var exp = Int()
    var content = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         content = saveData.object(forKey: "content2") as! String
        
        contentLabel.text = content
        tasklabel.text = writtentask
        
         exp = saveData.integer(forKey: "keikenchi")
        
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
            
        }
        
        print(selectedcontent)
    }

    @IBAction func importance(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
            
            
        case 0 : importance = "1"
        self.view.backgroundColor = UIColor.blue
     
        print(keiken)
        case 1 : importance = "2"
        print(keiken)
        self.view.backgroundColor = UIColor(red: 25, green: 148, blue: 252, alpha: 0.8)
      
        print(keiken)
        case 2 : importance = "3"
        self.view.backgroundColor = UIColor.blue
       
        print(keiken)
        case 3 : importance = "4"
        self.view.backgroundColor = UIColor.blue
        
        print(keiken)
        case 4 : importance = "5"
        self.view.backgroundColor = UIColor.blue
        
        print(keiken)
        default : importance = "1"
        self.view.backgroundColor = UIColor.blue
            
        }
        saveData.set(keiken, forKey:"keikenchi")
    }

    
    @IBAction func save(_ sender: UIButton){
        
        let todoDictionary = ["task":writtentask,"content":content,"importance":importance]
        
        //保存
        
        
            keiken = exp + 50
        
            todoArray.append(todoDictionary as AnyObject)
            saveData.set(todoArray, forKey:"todo")
            saveData.set(keiken, forKey:"keiken" )
            saveData.synchronize()
            print(todoArray)
            
            performSegue(withIdentifier: "complete", sender: nil)
            
            //self.presentViewController(CompleteViewController, animated: true, completion: nil)        // Viewの移動
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
