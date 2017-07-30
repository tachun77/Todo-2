//
//  settingViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/14.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import ElasticTransition
import RAMPaperSwitch


class settingViewController:  ElasticModalViewController {
    
   
    
    @IBOutlet var switchbutton : RAMPaperSwitch!
    
    @IBOutlet var notificationlabel : UILabel!
    
    var exp = Int()
    let saveData = UserDefaults.standard
    var transition = ElasticTransition()
    var contentLength:CGFloat = 600
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    
    @IBOutlet var explabel : UILabel!
    
    var notification_onoff : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        exp = saveData.integer(forKey: "exp")
        explabel.text = String(exp)
        notification_onoff = saveData.bool(forKey: "notification")
        switchbutton.isOn = notification_onoff
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
    
    fileprivate func setupPaperSwitch() {
        
        self.switchbutton.animationDidStartClosure = {(onAnimation: Bool) in
            
            self.animateLabel(self.explabel, onAnimation: onAnimation, duration: self.switchbutton.duration)
           
          
            self.view.backgroundColor = UIColor.red
        }
    }
    
        fileprivate func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
            UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                label.textColor = onAnimation ? UIColor.white : UIColor(red: 31/255.0, green: 183/255.0, blue: 252/255.0, alpha: 1)
            }, completion:nil)
        }
        
        fileprivate func animateImageView(_ imageView: UIImageView, onAnimation: Bool, duration: TimeInterval) {
            UIView.transition(with: imageView, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                imageView.image = UIImage(named: onAnimation ? "img_phone_on" : "img_phone_off")
            }, completion:nil)
        }
    
    @IBAction func notification(sender: UISwitch){
        if sender.isOn{
            
            print("notification_on")
            notificationlabel.textColor = UIColor.white
            todoru2.notification()
            todoru2.notification2()
            notification_onoff = true
            saveData.set(notification_onoff,forKey:"notification")
            
        }else{
            
            print("notification_off")
            notificationlabel.textColor = UIColor.black
            todoru2.disnotification()
            notification_onoff = false
            saveData.set(notification_onoff,forKey:"notification")
            
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
