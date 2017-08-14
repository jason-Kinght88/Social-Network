//
//  CircleView.swift
//  Social Network
//
//  Created by Amy on 12/8/17.
//  Copyright © 2017 Jason Knight. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
       super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
