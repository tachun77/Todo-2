//
//  notification.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/30.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import UserNotifications

let saveData = UserDefaults.standard
var todoArray = [Any]()
var todocount : Int = 0

func notification(){
    
    todoArray = saveData.object(forKey: "todo") as! [Any]
    todocount = todoArray.count
    
    //通知を初期化(繰り返し同じ通知がこないように)
    // 通知の削除
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["morning"])
    
     let date = DateComponents(hour:9, minute:00)
    // 通知内容の作成
    let contents = UNMutableNotificationContent()
    contents.title = "This is title."
    //        contents.subtitle = "This is subtitle."
    contents.body = "You have "+String(todocount)+" Tasks to finish!"
        print("作動")
    //トリガー(指定の時間)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats :true)
        // リクエストの作成
        let identifier = "morning"
        let request = UNNotificationRequest(identifier: identifier, content: contents, trigger: trigger)
    
        // リクエスト実行
        UNUserNotificationCenter.current().add(request){
            error in print(error?.localizedDescription as Any)
        }
}
func notification2(){
    
    todoArray = saveData.object(forKey: "todo") as! [Any]
    todocount = todoArray.count
    
    //通知を初期化(繰り返し同じ通知がこないように)
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["evening"])
    
    let date = DateComponents(hour:23, minute:00)
    
    // 通知内容の作成
    let contents = UNMutableNotificationContent()
    contents.title = "This is title."
    //        contents.subtitle = "This is subtitle."
    contents.body = "You have "+String(todocount)+" Tasks left!"
    
    print("作動")
    
    
    //トリガー(指定の時間)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: date, repeats :true)
    // リクエストの作成
    let identifier = "evening"
    let request = UNNotificationRequest(identifier: identifier, content: contents, trigger: trigger)
    
    // リクエスト実行
    UNUserNotificationCenter.current().add(request){
        error in print(error?.localizedDescription as Any)
    }
}

extension UNUserNotificationCenter {
    func removeNotificationsCompletely(withIdentifiers identifiers: [String]) {
        self.removePendingNotificationRequests(withIdentifiers: identifiers)
        self.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
}

    func disnotification(){
        
        // Pendingのものを全て削除
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // Deliveredのものを全て削除
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
    }



    
    
