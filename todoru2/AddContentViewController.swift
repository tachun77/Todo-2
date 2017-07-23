//
//  AddContentViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/24.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit

class AddContentViewController: UIViewController {
    
    let saveData = UserDefaults.standard
    var contentArray = [String]()
    
    @IBOutlet var newcontentTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if saveData.array(forKey:"content") != nil{
            
            contentArray = saveData.array(forKey:"content") as! [String]
            
        }else{
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(){
        
        if newcontentTextField.text!.isEmpty == true {
            let alert = UIAlertController(
                title : "",
                message : "文字を入力してください。",
                preferredStyle : UIAlertControllerStyle.alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.default,
                    handler : nil
                )
            )
            self.present(alert, animated : true, completion : nil)
        }else{
    
        contentArray.append(newcontentTextField.text!)
        saveData.set(contentArray,forKey:"content")
            
            let nextView = presentingViewController as! AddTodoViewController
            nextView.contentArray = saveData.object(forKey:"content") as! [String]
            nextView.collectionView.reloadData()
           
            dismiss(animated: true, completion: nil)

        }
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
