//
//  notification.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/30.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import UserNotifications

func notification(){
    
     let date = DateComponents(hour:9, minute:00)
    
    // 通知内容の作成
    let contents = UNMutableNotificationContent()
    contents.title = "This is title."
    //        contents.subtitle = "This is subtitle."
    contents.body = "You have 3 Tasks to finish!"
        
        print("作動")
        
    // トリガーの作成(5秒後に通知実行)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
    //トリガー(指定の時間)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats :true)
        // リクエストの作成
        let identifier = NSUUID().uuidString
        let request = UNNotificationRequest(identifier: identifier, content: contents, trigger: trigger)
    
        // リクエスト実行
        UNUserNotificationCenter.current().add(request){
            error in print(error?.localizedDescription as Any)
        }
}
func notification2(){
    
    let date = DateComponents(hour:23, minute:00)
    
    // 通知内容の作成
    let contents = UNMutableNotificationContent()
    contents.title = "This is title."
    //        contents.subtitle = "This is subtitle."
    contents.body = "You have 3 Tasks left!"
    
    print("作動")
    
    //トリガー(指定の時間)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats :true)
    // リクエストの作成
    let identifier = NSUUID().uuidString
    let request = UNNotificationRequest(identifier: identifier, content: contents, trigger: trigger)
    
    // リクエスト実行
    UNUserNotificationCenter.current().add(request){
        error in print(error?.localizedDescription as Any)
    }
}

    func disnotification(){
        
        NotificationCenter.default.removeObserver((Any).self)
        
    }
    
    
