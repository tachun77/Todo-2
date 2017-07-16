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

class AddTodoViewController: UIViewController, ElasticMenuTransitionDelegate,UIViewControllerTransitioningDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    @IBOutlet var newcontentTextField : UITextField!
    var importance : String = ""
    
    var decidedcontent = String()
    var decidedcontent2 = String()
    
    @IBOutlet var cancel : UIButton!
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var newView : UIView!
    
    
    var transition = ElasticTransition()
    let lgr = UIScreenEdgePanGestureRecognizer()
    let rgr = UIScreenEdgePanGestureRecognizer()
    
   
    var contentLength:CGFloat = 0
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    var dismissByForegroundDrag = true
    
    public var sticky:Bool = true
    public var startingPoint:CGPoint?
    public var damping:CGFloat = 0.0
    public var stiffness:CGFloat = 0.6
    public var radiusFactor:CGFloat = 10
    public var containerColor:UIColor = UIColor(red: 152/255, green: 174/255, blue: 196/255, alpha: 1.0)
    public var overlayColor:UIColor = UIColor(red: 152/255, green: 174/255, blue: 196/255, alpha: 0.5)

//    var nextdecidedcontent = String()
    
    //セル選択時に呼び出されるメソッド
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, sender: UICollectionView) {
        
        decidedcontent2 = contentArray[indexPath.row]
        saveData.set(decidedcontent2,forKey:"content2")
        
        print(decidedcontent2)
        
        transition.edge = .right
        transition.startingPoint = sender.center
        performSegue(withIdentifier:"tonextview",sender: nil)
//        nextdecidedcontent = decidedcontent2

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tonextview"{
            let contentsViewController:contentsViewController = segue.destination as! contentsViewController
            contentsViewController.writtentask = taskTextField.text!
            
            let vc = segue.destination
            vc.transitioningDelegate = transition
            vc.modalPresentationStyle = .custom
        }else{
            
            let controller = segue.destination
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
//            let vc = segue.destination
//            vc.transitioningDelegate = transition
//            vc.modalPresentationStyle = .custom

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getRandomColor()
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
        }
        view.backgroundColor = customColor
        collectionView.backgroundColor = customColor
        taskTextField.backgroundColor = customColor
        
        importance = String(1)
        
        newView.isHidden = true
        
        // customization of ElasticTransition
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.6
        transition.transformType = .subtle
        
        transition.overlayColor = UIColor(white: 0, alpha: 0.5)
        transition.shadowColor = UIColor(white: 0, alpha: 0.5)
    
        // gesture recognizer
        lgr.addTarget(self, action: #selector(AddTodoViewController.handlePan(_:)))
//        rgr.addTarget(self, action: #selector(AddTodoViewController.handleRightPan(_:)))
        lgr.edges = .left
//        rgr.edges = .right
        view.addGestureRecognizer(lgr)
//        view.addGestureRecognizer(rgr)
  
    }
    
    func handlePan(_ pan:UIPanGestureRecognizer){
        if pan.state == .began{
            transition.edge = .left
            transition.startInteractiveTransition(self, segueIdentifier: "modoru", gestureRecognizer: pan)
        }else{
            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
//    func handleRightPan(_ pan:UIPanGestureRecognizer){
//        if pan.state == .began{
//            transition.edge = .right
//            transition.startInteractiveTransition(self, segueIdentifier: "about", gestureRecognizer: pan)
//        }else{
//            _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
//        }
//    }

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
        
        if newcontentTextField.text!.isEmpty == true {
            
            print("empty")
            let alert = UIAlertController(
                title : "",
                message : "Contentが空欄です",
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
        
        print("\(contentArray.count)")
        
        collectionView.reloadData()
        newView.isHidden = true
        }
    }
    
    @IBAction func toaddcontent(){
        
        newView.isHidden = false
        
    }
    
    @IBAction func canceladdcontent(_ sender: UIButton){
        
        newView.isHidden = true
    }
    @IBAction func codeBtnTouched(_ sender: AnyObject) {
        
        let transition = BubbleTransition()
        transition.transitionMode = .present
        transition.startingPoint = cancel.center
        transition.bubbleColor = customColor
        
       dismiss(animated: true, completion: nil )
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
