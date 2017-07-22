//
//  FirstViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/26.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import MCSwipeTableViewCell
import XLPagerTabStrip
import BTNavigationDropdownMenu
import ElasticTransition


 class FirstViewController: UIViewController, ElasticMenuTransitionDelegate, UIViewControllerTransitioningDelegate, UITableViewDataSource{
    
    var customColor : UIColor!
    
    func getRandomColor(){
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        customColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var toadd : UIButton!
    
    var contentLength:CGFloat = 0
    
    var todoArray:[Dictionary<String,Any>] = []
    var contentArray:[String] = []
    let saveData = UserDefaults.standard
    var itemsCount: Int = 0
    var exp = Int()
    var selectedcontent = String()
  
//    var dismissByBackgroundDrag = true
 
    var menuView: BTNavigationDropdownMenu!

    var selectedtodoArray : [Dictionary<String,Any>] = []
    var timelytext = String()
    var timelynumber = Int()
    var transition = ElasticTransition()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRandomColor()
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.3
        transition.transformType = .translateMid
        
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo") as! [Dictionary<String, Any>]
        }
        if saveData.array(forKey: "content") != nil{
            contentArray = saveData.array(forKey: "content") as! [String]
        }
        exp = saveData.integer(forKey: "exp")
        
        contentArray.insert("All",at: 0)
        selectedtodoArray = todoArray
        
        //Dropdownmenuの設定
        let items = contentArray
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Todo List", items: items as [AnyObject])
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            
            self.selectedcontent = self.contentArray[indexPath]
            print("Did select item at index: \(indexPath)")
            print(self.selectedcontent)
            
            if self.selectedcontent == "All" {
                self.selectedtodoArray = self.todoArray
                self.tableView.reloadData()
            }else{
                //contents毎に表示するためにデータにfilterをかける
                self.selectedtodoArray =  self.todoArray.filter{ $0["content"] as! String == self.selectedcontent}
                self.tableView.reloadData()
            }
            print(self.selectedtodoArray)
        }
        self.navigationItem.titleView = menuView
        print(todoArray)
        self.tableView.reloadData()
    }

    
    //TableViewの設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedtodoArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! customTableViewCell
        let nowIndexPathDictionary: (AnyObject) = selectedtodoArray[indexPath.row] as (AnyObject)


        cell.name.text = nowIndexPathDictionary["task"] as? String
        cell.importance.text = nowIndexPathDictionary["importance"] as? String
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        
        cell.defaultColor = .lightGray
        if cell.importance.text == String(1){
            cell.backgroundColor = UIColor.red
        }
        
        cell.secondTrigger = 0.5
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")), color: .green, mode: .exit, state: .state1, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
            
            if let cell = cell, let indexPath = tableView.indexPath(for: cell) {
                
                // 該当のセルを削除
                self.selectedtodoArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.exp = self.exp + 50
                
                self.todoArray = self.selectedtodoArray
                self.saveData.set(self.todoArray, forKey:"todo")
                self.saveData.set(self.exp, forKey:"exp")
                print(self.exp)
            }
            })
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")), color: .blue, mode: .exit, state: .state2, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
            
            if let cell = cell, let indexPath = tableView.indexPath(for: cell) {
                
                self.timelytext = (nowIndexPathDictionary["task"] as? String)!
                self.timelynumber = indexPath.row
                
                print(self.timelytext)
                print(self.timelynumber)
                
                let timely = [self.timelytext,self.timelynumber] as [Any]
                self.saveData.set(timely, forKey:"timely")
                
            
                //segueをstroyboard上で引かないでsegueを発動させるコード
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "next") as! EditViewController
                self.present(nextView, animated: true, completion: nil)
                            }
        })
        
        return cell
    }

    func deleteCell(cell: MCSwipeTableViewCell) {
        tableView.beginUpdates()
        itemsCount -= 1
        //    items.removeAtIndex(items.indexOf((cell.textLabel?.text)!)!)
        tableView.indexPath(for: cell)
        tableView.deleteRows(at: [self.tableView.indexPath(for: cell)!], with: .fade)
        tableView.endUpdates()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toadd(_ sender : UIButton){
        //segueをstroyboard上で引かないでsegueを発動させるコード
//        let storyboard: UIStoryboard = self.storyboard!
//        let nextView = storyboard.instantiateViewController(withIdentifier: "add") as! AddTodoViewController
//        self.present(nextView, animated: true, completion: nil)¥
        performSegue(withIdentifier: "add", sender: self)
    }
    
    @IBAction func tosetting(_ sender : UIButton){
       transition.edge = .left
        transition.startingPoint = sender.center
        performSegue(withIdentifier: "tosetting", sender: self)
        
    }

    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "tosetting"{
            transition.edge = .left
        let vc = segue.destination
        vc.transitioningDelegate = self as UIViewControllerTransitioningDelegate
        vc.modalPresentationStyle = .custom
        }else{
            
            let vc = segue.destination
            vc.transitioningDelegate = self as UIViewControllerTransitioningDelegate
            vc.modalPresentationStyle = .custom
        }

    }
}

