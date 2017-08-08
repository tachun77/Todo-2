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
    @IBOutlet var switchbutton2 : RAMPaperSwitch!
    
    @IBOutlet var notificationlabel : UILabel!
    @IBOutlet var notificationview : UIView!
    @IBOutlet var notificationimage : UIImageView!
    
    @IBOutlet var cheeruplabel : UILabel!
    @IBOutlet var cheerupview : UIView!
    
    var exp = Int()
    let saveData = UserDefaults.standard
    var transition = ElasticTransition()
    var contentLength:CGFloat = 600
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    
    @IBOutlet var explabel : UILabel!
    
    var notification_onoff : Bool = false
    var notification_status : Int = 0
    
    var cheerup_onoff : Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        notification_onoff = saveData.bool(forKey:"notification")
        print(String(notification_onoff))
        // Do any additional setup after loading the view.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        notificationimage.isUserInteractionEnabled = true
        notificationimage.addGestureRecognizer(tapGestureRecognizer)
        
        exp = saveData.integer(forKey: "exp")
        explabel.text = String(exp)
        notification_onoff = saveData.bool(forKey: "notification")
        switchbutton.isOn = notification_onoff
        
        cheerup_onoff = saveData.bool(forKey:"cheerup")
        switchbutton2.isOn = cheerup_onoff
        
        
        if notification_onoff == true {
            notificationlabel.textColor = UIColor.white
        }
        
        if cheerup_onoff == true {
            cheeruplabel.textColor = UIColor.white
        }
        
        if exp < 100{
            switchbutton.isEnabled = false
            notificationview.backgroundColor = UIColor.gray
        }else{
            
            switchbutton.isEnabled = true
            notificationview.backgroundColor = UIColor.white
        }
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if exp < 100{
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let alert = UIAlertController(
            title : "アクセス不可",
            message : "経験値を貯めて機能を解除しよう！",
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
            
        }
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
        self.switchbutton2.animationDidStartClosure = {(onAnimation: Bool) in
            self.animateLabel(self.explabel, onAnimation: onAnimation, duration: self.switchbutton2.duration)
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
            todoru2.notification()
            todoru2.notification2()
            print("notification_on")
            notificationlabel.textColor = UIColor.white
            notification_onoff = true
            notification_status = 1
            saveData.set(notification_onoff,forKey:"notification")
        }else{
            todoru2.disnotification()
            print("notification_off")
            notificationlabel.textColor = UIColor.black
            notification_onoff = false
            notification_status = 0
            saveData.set(notification_onoff,forKey:"notification")
        }
        
    }
    @IBAction func cheerup(sender: UISwitch){
        
        if sender.isOn{
            
            cheerup_onoff = true
            saveData.set(cheerup_onoff,forKey:"cheerup")
            cheeruplabel.textColor = UIColor.white
            
        }else{
            
            cheerup_onoff = false
            saveData.set(cheerup_onoff,forKey:"cheerup")
            cheeruplabel.textColor = UIColor.black
            
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
