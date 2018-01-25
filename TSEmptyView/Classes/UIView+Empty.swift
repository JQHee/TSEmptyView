//
//  UIView+Empty.swift
//  TSEmptyView
//
//  Created by 李棠松 on 2018/1/24.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit

extension UIView{
     var ts_origin : CGPoint {
        get{
            return  self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
     var ts_x : CGFloat {
        get{
            return  self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
     var ts_y : CGFloat {
        get{
            return  self.frame.origin.y
        }
        set{
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    
     var ts_maxX : CGFloat {
        return  self.ts_x+self.ts_width
    }
    
     var ts_maxY : CGFloat {
        return  self.ts_y+self.ts_height
    }
    
     var ts_width : CGFloat {
        get{
            return  self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
     var ts_height : CGFloat {
        get{
            return  self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
     var ts_size : CGSize {
        get{
            return  self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    
     var ts_centerX : CGFloat {
        get{
            return  self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
     var ts_centerY : CGFloat {
        get{
            return  self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
}

