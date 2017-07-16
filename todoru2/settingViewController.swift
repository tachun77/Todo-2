//
//  settingViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/14.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition

class settingViewController:  ElasticModalViewController {
    
    var exp = Int()
    let saveData = UserDefaults.standard
    var transition = ElasticTransition()
    
    @IBOutlet var explabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        exp = saveData.integer(forKey: "exp")
        explabel.text = String(exp)
        
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.6
        transition.transformType = .subtle
        transition.edge = .bottom
        
        transition.overlayColor = UIColor(white: 0, alpha: 0.5)
        transition.shadowColor = UIColor(white: 0, alpha: 0.5)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destination
        vc.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        vc.modalPresentationStyle = .custom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func back(sender: UIButton){
        transition.edge = .bottom
        transition.startingPoint = sender.center
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
