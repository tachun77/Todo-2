//
//  editContentsViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/26.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit

class editContentsViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var tableView: UITableView!
    
    let saveData = UserDefaults.standard
    var contentArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if saveData.array(forKey: "content") != nil{
            
            contentArray = saveData.array(forKey: "content") as! [String]
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableViewの設定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create
        let cell = tableView.dequeueReusableCell(withIdentifier: "editcell", for: indexPath) as! editContentsTableViewCell
        cell.contentsLabel.text = contentArray[indexPath.row]
        return cell
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
