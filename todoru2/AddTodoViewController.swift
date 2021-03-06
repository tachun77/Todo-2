//
//  AddTodoViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/26.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition
import BubbleTransition
import TextFieldEffects

class AddTodoViewController: ElasticModalViewController,UIViewControllerTransitioningDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    
    var customColor : UIColor!
    
    func getRandomColor(){
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        customColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    var todoArray : [AnyObject]=[]
    var contentArray = [String]()
    
    let saveData = UserDefaults.standard
    var keiken: Int = 0
    
    @IBOutlet var taskTextField : UITextField!
    var importance : String = ""
    
    var decidedcontent = String()
    var decidedcontent2 = String()
    
    @IBOutlet var collectionView : UICollectionView!
    
    var transition = ElasticTransition()
    let lgr = UIScreenEdgePanGestureRecognizer()
    let rgr = UIScreenEdgePanGestureRecognizer()
    
   
//    var contentLength:CGFloat = 0
//    var dismissByBackgroundTouch = true
//    var dismissByBackgroundDrag = true
//    var dismissByForegroundDrag = true
    


//    var nextdecidedcontent = String()

    
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
    
    //セル選択時に呼び出されるメソッド
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        decidedcontent2 = contentArray[indexPath.row]
        saveData.set(decidedcontent2,forKey:"content2")
        
        print("選んだ項目は"+decidedcontent2)
        
        transition.edge = .right
        
        performSegue(withIdentifier: "tocontents", sender: nil)
//        //segueをstroyboard上で引かないでsegueを発動させるコード
//        let storyboard: UIStoryboard = self.storyboard!
//        let nextView = storyboard.instantiateViewController(withIdentifier: "contents") as! contentsViewController
//        self.present(nextView, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getRandomColor()
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
        }
        
        if saveData.array(forKey: "content") != nil{
            contentArray = saveData.array(forKey: "content") as! [String]
        }
      
        
        view.backgroundColor = customColor
        collectionView.backgroundColor = customColor
        taskTextField.backgroundColor = customColor
        
        importance = String(1)
        
        
        // customization of ElasticTransition
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.6
        transition.transformType = .subtle
        
        transition.overlayColor = UIColor(white: 0, alpha: 0.5)
        transition.shadowColor = UIColor(white: 0, alpha: 0.5)
    
        // gesture recognizer
        lgr.addTarget(self, action: #selector(AddTodoViewController.handlePan(_:)))

        lgr.edges = .left

        view.addGestureRecognizer(lgr)

        collectionView.reloadData()
    }
    
    func handlePan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .left
            transition.startInteractiveTransition(self, segueIdentifier: "modoru", gestureRecognizer: pan)
            
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    


//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("VIEWWILLAPPEAR")
//        if saveData.array(forKey: "content") != nil{
//            contentArray = saveData.array(forKey: "content") as! [String]
//        }
//        collectionView.reloadData()
//    }
    

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
        
//        todoArray.append(todoDictionary as AnyObject)
//        saveData.set(todoArray, forKey:"todo")
//        saveData.set(keiken, forKey:"keiken" )
//        saveData.synchronize()
        print(todoArray)
            
            performSegue(withIdentifier: "complete", sender: nil)

        //self.presentViewController(CompleteViewController, animated: true, completion: nil)        // Viewの移動
        }
    }
    
    @IBAction func endediting(sender : UIButton){
        
        taskTextField.endEditing(true);
        
    }
    

    @IBAction func toaddcontent(){
        
        transition.edge = .bottom
        
        performSegue(withIdentifier: "toaddcontent", sender: nil)
    }
    
    @IBAction func cancel(){
        
        dismiss(animated: true, completion: nil)
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "tocontents"{
        let contentsViewController:contentsViewController = segue.destination as! contentsViewController
        contentsViewController.writtentask = taskTextField.text!
        contentsViewController.content = decidedcontent2
        
        let vc = segue.destination
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
    }else{
        
        let controller = segue.destination
        controller.transitioningDelegate = transition
        controller.modalPresentationStyle = .custom
        //            let vc = segue.destination
        //            vc.transitioningDelegate = transition
        //            vc.modalPresentationStyle = .custom
        
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
