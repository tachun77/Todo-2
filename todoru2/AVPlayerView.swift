//
//  AVPlayerView.swift
//  todoru2
//
//  Created by 福島達也 on 2017/08/07.
//  Copyright © 2017年 Tatsuya Fukushima. All rights reserved.
//

import AVFoundation
import UIKit

// レイヤーをAVPlayerLayerにする為のラッパークラス.
class AVPlayerView : UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
