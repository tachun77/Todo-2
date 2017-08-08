//
//  aboutmeViewController.swift
//  todoru2
//
//  Created by 福島達也 on 2017/07/31.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class aboutmeViewController: UIViewController {

    let saveData = UserDefaults.standard
    
    var exp = Int()
    
    var videoURL: NSURL? // 再生用のアイテム.
    var playerItem : AVPlayerItem!  // AVPlayer.
    var videoPlayer : AVPlayer!
    var playerLayer : AVPlayerLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        exp = saveData.integer(forKey:"exp")
        print(exp)
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func magic(){
        
        exp = 10000000000000
        saveData.set(exp,forKey:"exp")
        
        let alert = UIAlertController(
            title : "魔法を使った！",
            message : "経験値が10000000000000になった！！",
            preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.default,
                handler : nil
            )
        )
        self.present(alert, animated : true, completion : nil)
    }
    
    @IBAction func time(){
        
        exp = 0
        saveData.set(exp,forKey:"exp")
        
        let alert = UIAlertController(
            title : "時間を戻した！",
            message : "経験値が0になった！！",
            preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.default,
                handler : nil
            )
        )
        self.present(alert, animated : true, completion : nil)
    }
    
    @IBAction func nice(){
        
        // アプリ内に組み込んだ動画ファイルを再生
            
            if let bundlePath = Bundle.main.path(forResource: "nice", ofType: "mp4") {
                
                let videoPlayer = AVPlayer(url: URL(fileURLWithPath: bundlePath))
                
                // 動画プレイヤーの用意
                let playerController = AVPlayerViewController()
                playerController.player = videoPlayer
                self.present(playerController, animated: true, completion: {
                    videoPlayer.play()
                })
            } else {
                print("no such file")
            }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var avPlayer: AVPlayer!
        
        let bundlePath = Bundle.main.path(forResource: "nice", ofType: "mp4")
        avPlayer = AVPlayer(url: URL(fileURLWithPath: bundlePath!))
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 3.0 / 4.0)
        self.view.layer.addSublayer(playerLayer)
        avPlayer.play()
  
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // 0.5秒後に実行したい処理
            playerLayer.isHidden = true
            print("二秒後")
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
