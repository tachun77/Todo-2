//
//  FirstViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/05/26.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import BubbleTransition
import MCSwipeTableViewCell
import XLPagerTabStrip
import BTNavigationDropdownMenu


class FirstViewController:  UIViewController, UIViewControllerTransitioningDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var toadd : UIButton!
    
    
    var todoArray:[AnyObject] = []
    var contentArray:[String] = []
    let saveData = UserDefaults.standard
    var itemsCount: Int = 0
    var keiken: Int = 0
    
    var menuView: BTNavigationDropdownMenu!

    
 
    
    //BubbleTransitionの設定
    
    let transition = BubbleTransition()
    var startingPoint = CGPoint.zero
    var duration = 10.0
    var transitionMode: BubbleTransitionMode = .present
    var bubbleColor: UIColor = .yellow
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = toadd.center
        transition.bubbleColor = UIColor.rgb(r: 25, g: 148, b: 252, alpha: 1.0)
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = toadd.center
        transition.bubbleColor = toadd.backgroundColor!
        return transition
    }
    
    
    
    //TableViewの設定
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! customTableViewCell
    
        let nowIndexPathDictionary: (AnyObject) = todoArray[indexPath.row]
//        let exp : AnyObject = saveData.integer(forKey: "keikenchi") as AnyObject
        

        
        cell.name.text = nowIndexPathDictionary["task"] as? String
        cell.importance.text = nowIndexPathDictionary["importance"] as? String
        
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        
        cell.defaultColor = .lightGray
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: .green, mode: .exit, state: .state1, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
            
            
            if let cell = cell, let indexPath = tableView.indexPath(for: cell) {
                
                // 該当のセルを削除
                self.todoArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
                self.saveData.set(self.todoArray, forKey:"todo")
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
            
        }
        
        
        
        if saveData.array(forKey: "content") != nil{
            
            contentArray = saveData.array(forKey: "content") as! [String]
            
        }
        
        contentArray.insert("All",at: 0)

        //Dropdownmenuの設定
    
        let items = contentArray
       
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Todo List", items: items as [AnyObject])
//        menuView.cellHeight = 50
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
            
            print("Did select item at index: \(indexPath)")
            
        }
        
        self.navigationItem.titleView = menuView

        
        print(todoArray)
        tableView.reloadData()
        print( )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if saveData.array(forKey: "todo") != nil{
//            todoArray = saveData.array(forKey: "todo")! as [AnyObject]
//            
//        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toadd(_ sender : UIButton){
        performSegue(withIdentifier: "toadd", sender: nil)
    }
    
}

