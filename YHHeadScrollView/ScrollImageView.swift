//
//  ScrollImageView.swift
//  YHHeadScrollView
//
//  Created by SR on 16/5/4.
//  Copyright © 2016年 游辉. All rights reserved.
//

import UIKit

class ScrollImageView: UIImageView {
    
    typealias closure = (UIGestureRecognizerState) -> Void
    
    //数据id
    var dataTag:Int?
    var scrollImageViewClosure:closure?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("began")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.Began)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("Cancelled")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.Cancelled)
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Ended")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.Ended)
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        print("Failed")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.Failed)
        }
    }



    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        event?.subtype
//        print(NSStringFromCGPoint(point))
//
//        let view  = UIView.init()
//        return view
//    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
