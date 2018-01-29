//
//  TSProgressLayer.swift
//  TSPlayerView
//
//  Created by 李棠松 on 2018/1/5.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit

class TSProgressLayer: CAShapeLayer {
    var isSpinning = false
    init(frame:CGRect) {
        super.init()
        self.frame = frame
        self.cornerRadius = frame.width/2
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.white.cgColor
        self.lineWidth = 4
        self.lineCap = kCALineCapRound
        self.strokeStart = 0
        self.strokeEnd = 0.33
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5).cgColor
        
        let path = UIBezierPath.init(roundedRect: self.bounds.insetBy(dx: 2, dy: 2), cornerRadius: frame.width/2-2)
        self.path = path.cgPath
        
        
    }
    func startSpin(){
        
        if !isSpinning {
            spin(with: CGFloat(Double.pi))
        }
        isSpinning = true
        self.isHidden = false
    }
    func stopSpin(){
        self.isHidden = true
        self.isSpinning = false
        self.removeAllAnimations()
        
    }
    
    func spin(with angle: CGFloat){
        self.strokeEnd = 0.33
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi-0.5
        rotationAnimation.duration = 0.4
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = HUGE
        self.add(rotationAnimation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
