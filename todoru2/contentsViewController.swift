//
//  contentsViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/29.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition


class contentsViewController: UIViewController, ElasticMenuTransitionDelegate {
    
    var customColor : UIColor!
    
    func getRandomColor(){
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        customColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    var dismissByForegroundDrag = true
    
    @IBOutlet var contentLabel : UILabel!
    @IBOutlet var tasklabel : UILabel!
    
    var selectedcontent = String()
    var writtentask = String()
    var importance = String()
    
    let saveData = UserDefaults.standard
    var todoArray = [Any]()
    var exp = Int()
    var expcompare = Int()
    var content = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getRandomColor()
        view.backgroundColor = customColor
        
        contentLabel.text = content
        tasklabel.text = writtentask
        
        if saveData.object(forKey:"content2") != nil{
        
         content = saveData.object(forKey: "content2") as! String!
        }
        
        
        if saveData.integer(forKey: "exp") != nil{
            exp = saveData.integer(forKey:"exp") as Int
            expcompare = saveData.integer(forKey: "exp") as Int
        }
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
        }
        print(selectedcontent)
    }

    @IBAction func importance(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
            
        case 0 : importance = "1"

        case 1 : importance = "2"
    
        case 2 : importance = "3"
       
        case 3 : importance = "4"
        
        case 4 : importance = "5"
        
        default : importance = "1"
            
        }
        exp = Int(arc4random_uniform(100))

    }

    
    @IBAction func save(_ sender: UIButton){
        
        let todoDictionary = ["task":writtentask,"content":content,"importance":importance]
        
        //保存
            exp = exp*10
        
            todoArray.append(todoDictionary as AnyObject)
            saveData.set(todoArray, forKey:"todo")
            saveData.set(exp, forKey:"exp")
            saveData.synchronize()
            print(todoArray)
            print("現在の経験値は"+String(exp)+"です")
            
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
