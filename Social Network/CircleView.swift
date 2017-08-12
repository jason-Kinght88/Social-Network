//
//  CircleView.swift
//  Social Network
//
//  Created by Amy on 12/8/17.
//  Copyright © 2017 Jason Knight. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(displayP3Red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
}
