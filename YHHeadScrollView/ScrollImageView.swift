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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("began")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.began)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Cancelled")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.cancelled)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Ended")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.ended)
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        print("Failed")
        if scrollImageViewClosure != nil {
            scrollImageViewClosure!(UIGestureRecognizerState.failed)
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
