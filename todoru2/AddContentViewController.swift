//
//  AddContentViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/24.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition

class AddContentViewController: ElasticModalViewController {
    
    let saveData = UserDefaults.standard
    var contentArray = [String]()
    
    @IBOutlet var newcontentTextField: UITextField!
    
    var transition = ElasticTransition()
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if saveData.array(forKey:"content") != nil{
            
            contentArray = saveData.array(forKey:"content") as! [String]
            
        }else{
            
        }

        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.6
        transition.transformType = .subtle
        
        transition.overlayColor = UIColor(white: 0, alpha: 0.5)
        transition.shadowColor = UIColor(white: 0, alpha: 0.5)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination
        controller.transitioningDelegate = transition
        controller.modalPresentationStyle = .custom
        
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
            
            if newcontentTextField.text == "さくしゃはふくしまたつや"{
                
                //            segueをstroyboard上で引かないでsegueを発動させるコード
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "aboutme") as! aboutmeViewController
                self.present(nextView, animated: true, completion: nil)
                
            }else{
          
            contentArray.append(newcontentTextField.text!)
            saveData.set(contentArray,forKey:"content")
            
            
            let nextView = presentingViewController as! AddTodoViewController
            nextView.contentArray = saveData.object(forKey:"content") as! [String]
            nextView.collectionView.reloadData()
            
                let alert = UIAlertController(
                    title : "",
                    message : "項目追加完了しました！",
                    preferredStyle : UIAlertControllerStyle.alert)
                alert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: UIAlertActionStyle.default,
                        handler : {(action: UIAlertAction!)-> Void in
                            self.dismiss(animated: true, completion: nil)
                    }
                    )
                )
            
                self.present(alert, animated : true, completion : nil)
            }
        }
    }

    @IBAction func back(sender:UIButton){
        
        
        dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func endediting(sender : UIButton){
        
        newcontentTextField.endEditing(true);
        
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
