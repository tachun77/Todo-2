//
//  AddTodoViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/26.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import BubbleTransition



class AddTodoViewController:  UIViewController, UIViewControllerTransitioningDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    var todoArray : [AnyObject]=[]
    var contentArray = [String]()
    
    let saveData = UserDefaults.standard
    var keiken: Int = 0
        
    
    @IBOutlet var taskTextField : UITextField!
    @IBOutlet var newcontentTextField : UITextField!
    var importance : String = ""
    
    var decidedcontent = String()
    var decidedcontent2 = String()
    
    @IBOutlet var cancel : UIButton!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var newView : UIView!
    
    
    
    
    let transition = BubbleTransition()
    var startingPoint = CGPoint.zero
    var duration = -10.0
    var transitionMode: BubbleTransitionMode = .pop
    var bubbleColor: UIColor = .yellow

    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.cancel.center
        transition.bubbleColor = UIColor.blue
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.cancel.center
        transition.bubbleColor = cancel.backgroundColor!
        return transition
    }

       
    
//    var nextdecidedcontent = String()
    
    //セル選択時に呼び出されるメソッド
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        decidedcontent2 = contentArray[indexPath.row]
        saveData.set(decidedcontent2,forKey:"content2")
        
        print(decidedcontent2)
//        performSegue(withIdentifier:"tonextview",sender: nil)
//        nextdecidedcontent = decidedcontent2

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tonextview"{
            let contentsViewController:contentsViewController = segue.destination as! contentsViewController
        
            contentsViewController.writtentask = taskTextField.text!
        }else{
            
        }
    }
    
    //データの個数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return contentArray.count
    }
    
    
    //データを返すメソッド
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //コレクションビューから識別子contentcellを取得する。
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentcell", for: indexPath as IndexPath) as! contentsCollectionViewCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 0.8)
        
        cell.contentslabel.text = contentArray[indexPath.row]
        cell.contentslabel.textColor = UIColor.white
        
        
        return cell
        
    }

    
    
    let exp = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
        }
        view.backgroundColor = UIColor.rgb(r: 25, g: 148, b: 252, alpha: 1.0)
        importance = String(1)
        
        newView.isHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if saveData.array(forKey: "content") != nil{
            
            contentArray = saveData.array(forKey: "content") as! [String]
            
        }
        
        collectionView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func save(_ sender: UIButton){
        
        let todoDictionary = ["task":taskTextField.text!,"importance":importance]
        
        //保存
        
        if taskTextField.text!.isEmpty == true {
            
            print("empty")
            let alert = UIAlertController(
                title : "",
                message : "Taskが空欄です",
                preferredStyle : UIAlertControllerStyle.alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.default,
                    handler : nil
            )
            )
            self.present(alert, animated : true, completion : nil)
         } else {
        
        todoArray.append(todoDictionary as AnyObject)
        saveData.set(todoArray, forKey:"todo")
        saveData.set(keiken, forKey:"keiken" )
        saveData.synchronize()
        print(todoArray)
            
            performSegue(withIdentifier: "complete", sender: nil)

        //self.presentViewController(CompleteViewController, animated: true, completion: nil)        // Viewの移動
    }
        
    }
    
    @IBAction func endediting(sender : UIButton){
        
        taskTextField.endEditing(true);
        
    }
    
    @IBAction func addcontent(_ sender : UIButton){
        
        contentArray.append(newcontentTextField.text!)
        saveData.set(contentArray,forKey:"content")
        
        
        print("\(contentArray.count)")
        
        collectionView.reloadData()
        newView.isHidden = true
        
    }
    
    @IBAction func toaddcontent(){
        
        newView.isHidden = false
        
    }
    
    @IBAction func canceladdcontent(_ sender: UIButton){
        
        newView.isHidden = true
    }
    
    @IBAction func cancel(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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
