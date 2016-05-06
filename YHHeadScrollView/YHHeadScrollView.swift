//
//  YHHeadScrollView.swift
//  YHHeadScrollView
//
//  Created by SR on 16/4/29.
//  Copyright © 2016年 游辉. All rights reserved.
//

import UIKit
import Foundation
//import Kingfisher

typealias closure = (Int) -> Void

class YHHeadScrollView: UIView {
    
    deinit{
        cancelTimer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        
        loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - =LoadSubViews=
    func loadSubViews(){
        self.addSubview(scrollView!)
        
    }
    
    //MARK: - =Event=
    //无动效点击
    func noAnimationTapGes(tap:UITapGestureRecognizer){
        let imageView = tap.view as? ScrollImageView
        if (tap.view?.tag)! - 100 == self.currentShowTag {
            if (yHHeadScrollViewClosure != nil) {
                yHHeadScrollViewClosure!(imageView!.dataTag!)
            }
        }
    }
    
    //单击
    func tapGes(tap:UITapGestureRecognizer){
        
        let imageView = tap.view as? ScrollImageView
        if (tap.view?.tag)! - 100 == self.currentShowTag {
            if (yHHeadScrollViewClosure != nil) {
                yHHeadScrollViewClosure!(imageView!.dataTag!)
            }
        }
        
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            
            let currentTapTag = (tap.view?.tag)! - 100
            
            self.imageViewArr! = self.rotate(currentTapTag, array: self.imageViewArr!) as! [ScrollImageView]
            
            for var i = 0; i < self.imageViewArr?.count ; i++ {
                if i >= 3{
                    self.imageViewArr![i].frame = CGRectMake(0, self.frame.size.height / 2, 0, 0)
                    self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                }
                else{
                    if currentTapTag  < self.currentShowTag{
                        
                        if i == 0{
                            self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                        }
                        else{
                            self.scrollView!.bringSubviewToFront(self.imageViewArr![i])
                        }
                        
                    }
                    else{
                        self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                    }
                    
                    self.imageViewArr![i].frame = self.frameArray![i]
                }
                
                
                self.imageViewArr![i].tag = 100 + i
            }
            
            }, completion: nil)
        
    }
    
    //滑动
    func swipGes(swip: UISwipeGestureRecognizer){
        
        if swip.direction == UISwipeGestureRecognizerDirection.Left {
            UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.imageViewArr! = self.rotate(2, array: self.imageViewArr!) as! [ScrollImageView]
                
                for var i = 0; i < self.imageViewArr?.count ; i++ {
                    if i >= 3{
                        self.imageViewArr![i].frame = CGRectMake(0, self.frame.size.height / 2, 0, 0)
                    }
                    else{
                        self.imageViewArr![i].frame = self.frameArray![i]
                    }
                    self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                    self.imageViewArr![i].tag = 100 + i
                }
                }, completion: nil)
            
        }
        else if swip.direction == UISwipeGestureRecognizerDirection.Right {
            UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    self.imageViewArr! = self.rotate(0, array: self.imageViewArr!) as! [ScrollImageView]
                    
                    for var i = 0; i < self.imageViewArr?.count ; i++ {
                        if i >= 3{
                            self.imageViewArr![i].frame = CGRectMake(0, self.frame.size.height / 2, 0, 0)
                            self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                        }
                        else{
                            if i == 0{
                                self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                            }
                            else{
                                self.scrollView!.bringSubviewToFront(self.imageViewArr![i])
                            }
                            self.imageViewArr![i].frame = self.frameArray![i]
                            self.imageViewArr![i].tag = 100 + i
                        }
                    }
                }, completion: nil)
        }
        
    }
    
    //定时器触发函数:滚动图片
    func scrollImages() {
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.imageViewArr! = self.rotate(2, array: self.imageViewArr!) as! [ScrollImageView]
            
            for var i = 0; i < self.imageViewArr?.count ; i++ {
                if i >= 3{
                    self.imageViewArr![i].frame = CGRectMake(0, self.frame.size.height / 2, 0, 0)
                }
                else{
                    self.imageViewArr![i].frame = self.frameArray![i]
                }
                self.scrollView!.sendSubviewToBack(self.imageViewArr![i])
                self.imageViewArr![i].tag = 100 + i
            }
            }, completion: nil)
    }
    
    
    //MARK: - =Private=
    //无动效点击生成
    func noAnimationTapGes() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer.init(target: self, action: Selector("noAnimationTapGes:"))
        return tap
    }

    
    //单击生成
    func tapGes() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer.init(target: self, action: Selector("tapGes:"))
        return tap
    }
    
    //左滑生成
    func swipLeftGes() ->UISwipeGestureRecognizer{
        let swip = UISwipeGestureRecognizer.init(target: self, action: Selector("swipGes:"))
        swip.direction = UISwipeGestureRecognizerDirection.Left
        return swip
    }
    
    //右滑生成
    func swipRightGes() ->UISwipeGestureRecognizer{
        let swip = UISwipeGestureRecognizer.init(target: self, action: Selector("swipGes:"))
        swip.direction = UISwipeGestureRecognizerDirection.Right
        return swip
    }
    
    //使能timer
    func enableTimer(){
        if self.timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("scrollImages"), userInfo: nil, repeats: true)
            self.timer?.fireDate = NSDate.init(timeInterval: 3, sinceDate: NSDate.init())
        }
    }
    
    //注销timer
    func cancelTimer(){
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    
    //循环移动数组
    func rotate(index:Int, var array:[AnyObject]) -> [AnyObject]{
        let arrarHalfCount = self.currentShowTag
        
        if index == arrarHalfCount {
            
        }
        else if index > arrarHalfCount {
            let obj = array.first
            for var j = 0; j < array.count; j++ {
                if j != array.count - 1
                {
                    array[j] = array[j + 1]
                }
                else{
                    array[j] = obj!
                }
            }
        }
        else{
            let obj = array.last
            for var j = array.count - 1; j >= 0; j-- {
                if j != 0
                {
                    array[j] = array[j - 1]
                }
                else{
                    array[j] = obj!
                }
            }
        }
        return array
    }
    
    
    
    //MARK: - =Setter/Getter=
    private var currentShowTag = 1
    private var imageViewArr:[ScrollImageView]?
    private var timer:NSTimer?
    var placeImageUrlStr:String?
    var yHHeadScrollViewClosure:closure?
    var imageUrlStrArr:[NSString]? {
        
        didSet{
            self.imageViewArr = [ScrollImageView]()
            
            if imageUrlStrArr?.count == 0{
                let imageView =  ScrollImageView.init()
                imageView.scrollImageViewClosure = { (state) in
                    switch (state){
                    case UIGestureRecognizerState.Began:
                        self.cancelTimer()
                    case UIGestureRecognizerState.Ended:
                        self.enableTimer()
                    case UIGestureRecognizerState.Cancelled:
                        self.enableTimer()
                    case UIGestureRecognizerState.Failed:
                        self.enableTimer()
                    
                    default:
                        break
                    }
                }
                imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, self.frame.size.height)
                imageView.image = UIImage.init(named: "1")
                self.scrollView?.addSubview(imageView)
                self.imageViewArr?.append(imageView)
            }
            else if imageUrlStrArr?.count == 1 {
                let imageView =  ScrollImageView.init()
                imageView.scrollImageViewClosure = { (state) in
                    switch (state){
                    case UIGestureRecognizerState.Began:
                        self.cancelTimer()
                    case UIGestureRecognizerState.Ended:
                        self.enableTimer()
                    case UIGestureRecognizerState.Cancelled:
                        self.enableTimer()
                    case UIGestureRecognizerState.Failed:
                        self.enableTimer()
                    default:
                        break
                    }
                }
                imageView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, self.frame.size.height)
                imageView.userInteractionEnabled = true
                imageView.tag = 100
                imageView.dataTag = 100
//                imageView.sd_setImageWithURL(NSURL.init(string: imageUrlStrArr![0] as String), placeholderImage: UIImage.init(named: "1"))
                imageView.addGestureRecognizer(noAnimationTapGes())
                self.scrollView?.addSubview(imageView)
                self.imageViewArr?.append(imageView)
            }
            else{
                var style = 0
                if imageUrlStrArr?.count == 2 {
                    imageUrlStrArr?.append((imageUrlStrArr?.first)!)
                    style = 1
                }
                for var i = 0; i < imageUrlStrArr?.count; i++ {
                    let imageView =  ScrollImageView.init()
                    imageView.scrollImageViewClosure = { (state) in
                        switch (state){
                        case UIGestureRecognizerState.Began:
                            self.cancelTimer()
                        case UIGestureRecognizerState.Ended:
                            self.enableTimer()
                        case UIGestureRecognizerState.Cancelled:
                            self.enableTimer()
                        case UIGestureRecognizerState.Failed:
                            self.enableTimer()
                        default:
                            break
                        }
                    }
                    if i >= 3{
                        imageView.frame = CGRectMake(0, self.frame.size.height / 2, 0, 0)
                    }
                    else{
                        imageView.frame = self.frameArray![i]
                    }
                    
                    imageView.userInteractionEnabled = true
                    if style == 1 && i == 2{
                        imageView.dataTag = 100
                    }
                    else{
                        imageView.dataTag = 100 + i
                    }
                    
                    imageView.tag = 100 + i
//                    imageView.sd_setImageWithURL(NSURL.init(string: imageUrlStrArr![i] as String), placeholderImage: UIImage.init(named: "1"))
                    imageView.addGestureRecognizer(tapGes())
                    imageView.addGestureRecognizer(swipLeftGes())
                    imageView.addGestureRecognizer(swipRightGes())
                    self.scrollView?.addSubview(imageView)
                    self.imageViewArr?.append(imageView)
                    
                }
            }
            enableTimer()
        }
    }
    
    lazy var scrollView:UIScrollView? = {
        let scrollView = UIScrollView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width , 0))
        scrollView.backgroundColor = UIColor.yellowColor()
        scrollView.pagingEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 150)
        return scrollView
        
    }()
    
    lazy var frameArray:[CGRect]? = {
        let array =
        [
            CGRectMake(0, self.frame.size.height * 0.1, self.frame.size.width * 0.2, self.frame.size.height * 0.8),
            CGRectMake(self.frame.size.width * 0.2,  0 , self.frame.size.width * 0.6, self.frame.size.height),
            CGRectMake(self.frame.size.width * 0.8, self.frame.size.height * 0.1, self.frame.size.width * 0.2, self.frame.size.height * 0.8),
        ]
        return array
    }()
    
    lazy var colorArr:[UIColor]? = {
        let array = [UIColor.purpleColor(),UIColor.blackColor(),UIColor.brownColor(),UIColor.cyanColor(),UIColor.blueColor()]
        return array
    }()
    
    
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = scrollView?.frame
        frame?.size.height = self.frame.size.height
        scrollView?.frame = frame!
    }
    
}
