//
//  EditViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/06/30.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition

class EditViewController: ElasticModalViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var customColor : UIColor!
    
    func getRandomColor(){
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        customColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    @IBOutlet var taskTextField : UITextField!
    
    var task = String()
    
    var saveData = UserDefaults.standard
    var todoArray = [Dictionary<String,Any>]()
    var timelyArray = [Any]()
    var contentArray = [String]()
    var importance  = String()
    var selectedcontent = String()
    var touch : Int = 0
    var timelynumber : Int = 0
    
    @IBOutlet var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomColor()
        
        view.backgroundColor = customColor
        collectionView.backgroundColor = customColor
        taskTextField.backgroundColor = customColor
        taskTextField.textColor = UIColor.white

        if saveData.array(forKey: "todo") != nil{
            todoArray = saveData.array(forKey: "todo") as! [Dictionary<String, Any>]
        }
        if saveData.array(forKey: "timely") != nil{
            timelyArray = saveData.array(forKey: "timely")!
        }
        if saveData.array(forKey: "content") != nil{
            contentArray = saveData.array(forKey: "content") as! [String]
        }

        taskTextField.text = timelyArray[0] as? String
        
        timelynumber = timelyArray[1] as! Int
        print(timelyArray[1])
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentcell", for: indexPath as IndexPath) as! editCollectionViewCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 0.8)
        
        cell.contentslabel.text = contentArray[indexPath.row]
        cell.contentslabel.textColor = UIColor.white
        
        return cell
        
    }
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
    
    touch = touch + 1
    
    if touch % 2 == 1{
    cell?.layer.borderWidth = 5.0
    cell?.layer.borderColor = UIColor.red.cgColor
        
    selectedcontent = contentArray[indexPath.row]
    } else {
        
        cell?.layer.borderWidth = 0
        
    }
    print(selectedcontent)
    print(touch)

    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        
//        let cell = collectionView.cellForItem(at: indexPath)
//        
//        cell?.layer.zPosition = 0
//        selectedcontent = contentArray[indexPath.row]
//        
//        print(selectedcontent)
//        
//    }

    
    private func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) {
        
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "contentcell", for: indexPath as IndexPath) as! editCollectionViewCell
        
      collectionView.reloadData()
        
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(){
    
        let todoDictionary = ["task":taskTextField.text!,"content":selectedcontent,"importance":importance]
        todoArray.remove(at: timelynumber)
        todoArray.insert(todoDictionary, at:timelynumber)
        
        saveData.set(todoArray, forKey:"todo")
         
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        
//        super.viewWillDisappear(true)
//        
//        let firstView = self.storyboard?.instantiateViewController(withIdentifier: "first") as! FirstViewController
//        let presentingNavigationController = UINavigationController(rootViewController: firstView)
//        firstView.tableView.reloadData()
//    }
    
    @IBAction func cancel(){
        
        dismiss(animated: true, completion: nil)
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
