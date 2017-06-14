//
//  YHHeadScrollView.swift
//  YHHeadScrollView
//
//  Created by SR on 16/4/29.
//  Copyright © 2016年 游辉. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


public typealias closure = (Int) -> Void

open class YHHeadScrollView: UIView {
    
    deinit{
        cancelTimer()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        loadSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - =LoadSubViews=
    func loadSubViews(){
        self.addSubview(scrollView!)
        
    }
    
    //MARK: - =Event=
    //无动效点击
    func noAnimationTapGes(_ tap:UITapGestureRecognizer){
        let imageView = tap.view as? ScrollImageView
        if (tap.view?.tag)! - 100 == self.currentShowTag {
            if (yHHeadScrollViewClosure != nil) {
                yHHeadScrollViewClosure!(imageView!.dataTag!)
            }
        }
    }
    
    //单击
    func tapGes(_ tap:UITapGestureRecognizer){
        
        let imageView = tap.view as? ScrollImageView
        if (tap.view?.tag)! - 100 == self.currentShowTag {
            if (yHHeadScrollViewClosure != nil) {
                yHHeadScrollViewClosure!(imageView!.dataTag!)
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: { () -> Void in
            
            
            let currentTapTag = (tap.view?.tag)! - 100
            
            self.imageViewArr! = self.rotate(currentTapTag, array: self.imageViewArr!) as! [ScrollImageView]
            
            for i in 0..<self.imageViewArr!.count {
                if i >= 3{
                    self.imageViewArr![i].frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 0, height: 0)
                    self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                }
                else{
                    if currentTapTag  < self.currentShowTag{
                        
                        if i == 0{
                            self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                        }
                        else{
                            self.scrollView!.bringSubview(toFront: self.imageViewArr![i])
                        }
                        
                    }
                    else{
                        self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                    }
                    
                    self.imageViewArr![i].frame = self.frameArray![i]
                }
                
                
                self.imageViewArr![i].tag = 100 + i
            }
            
            }, completion: nil)
        
    }
    
    //滑动
    func swipGes(_ swip: UISwipeGestureRecognizer){
        
        if swip.direction == UISwipeGestureRecognizerDirection.left {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: { () -> Void in
                self.imageViewArr! = self.rotate(2, array: self.imageViewArr!) as! [ScrollImageView]
                
                for i in 0..<self.imageViewArr!.count{
                    if i >= 3{
                        self.imageViewArr![i].frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 0, height: 0)
                    }
                    else{
                        self.imageViewArr![i].frame = self.frameArray![i]
                    }
                    self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                    self.imageViewArr![i].tag = 100 + i
                }
                }, completion: nil)
            
        }
        else if swip.direction == UISwipeGestureRecognizerDirection.right {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: { () -> Void in
                    self.imageViewArr! = self.rotate(0, array: self.imageViewArr!) as! [ScrollImageView]
                
                for i in 0..<self.imageViewArr!.count{
                    if i >= 3{
                        self.imageViewArr![i].frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 0, height: 0)
                        self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                    }
                    else{
                        if i == 0{
                            self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                        }
                        else{
                            self.scrollView!.bringSubview(toFront: self.imageViewArr![i])
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
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.imageViewArr! = self.rotate(2, array: self.imageViewArr!) as! [ScrollImageView]
            
            for i in 0..<self.imageViewArr!.count{
                if i >= 3{
                    self.imageViewArr![i].frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 0, height: 0)
                }
                else{
                    self.imageViewArr![i].frame = self.frameArray![i]
                }
                self.scrollView!.sendSubview(toBack: self.imageViewArr![i])
                self.imageViewArr![i].tag = 100 + i
            }
        
            }, completion: nil)
    }
    
    
    //MARK: - =Private=
    //无动效点击生成
    func noAnimationTapGes() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(YHHeadScrollView.noAnimationTapGes(_:)))
        return tap
    }

    
    //单击生成
    func tapGes() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(YHHeadScrollView.tapGes(_:)))
        return tap
    }
    
    //左滑生成
    func swipLeftGes() ->UISwipeGestureRecognizer{
        let swip = UISwipeGestureRecognizer.init(target: self, action: #selector(YHHeadScrollView.swipGes(_:)))
        swip.direction = UISwipeGestureRecognizerDirection.left
        return swip
    }
    
    //右滑生成
    func swipRightGes() ->UISwipeGestureRecognizer{
        let swip = UISwipeGestureRecognizer.init(target: self, action: #selector(YHHeadScrollView.swipGes(_:)))
        swip.direction = UISwipeGestureRecognizerDirection.right
        return swip
    }
    
    //使能timer
    open func enableTimer(){
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: timeScrollInterval, target: self, selector: #selector(YHHeadScrollView.scrollImages), userInfo: nil, repeats: true)
            self.timer?.fireDate = Date.init(timeInterval: 3, since: Date.init())
        }
    }
    
    //注销timer
    open func cancelTimer(){
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }

    
    //循环移动数组
    func rotate(_ index:Int, array:[AnyObject]) -> [AnyObject]{
        var array = array
        let arrarHalfCount = self.currentShowTag
        
        if index == arrarHalfCount {
            
        }
        else if index > arrarHalfCount {
            let obj = array.first
            for j in 0 ..< array.count {
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
            for j in (0...array.count).reversed() {
                if j != 0 {
                    array[j] = array[j - 1]
                }else{
                    array[j] = obj!
                }
            }
//            for var j = array.count - 1; j >= 0; j -= 1 {
//                if j != 0
//                {
//                    array[j] = array[j - 1]
//                }
//                else{
//                    array[j] = obj!
//                }
//            }
        }
        return array
    }
    
    
    
    //MARK: - =Setter/Getter=
    fileprivate var currentShowTag = 1
    fileprivate var imageViewArr:[ScrollImageView]?
    fileprivate var timer:Timer?
    open var placeImageStr:String?
    open var timeScrollInterval:Double = 2
    open var yHHeadScrollViewClosure:closure?
    open var imageUrlStrArr:[NSString]? {
        
        didSet{
            self.imageViewArr = [ScrollImageView]()
            
            if imageUrlStrArr?.count == 0{
                let imageView =  ScrollImageView.init()
                imageView.scrollImageViewClosure = { (state) in
                    switch (state){
                    case UIGestureRecognizerState.began:
                        self.cancelTimer()
                    case UIGestureRecognizerState.ended:
                        self.enableTimer()
                    case UIGestureRecognizerState.cancelled:
                        self.enableTimer()
                    case UIGestureRecognizerState.failed:
                        self.enableTimer()
                    
                    default:
                        break
                    }
                }
                imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
                if placeImageStr != nil {
                    imageView.image = UIImage.init(named: placeImageStr!)
                }
                self.scrollView?.addSubview(imageView)
                self.imageViewArr?.append(imageView)
            }
            else if imageUrlStrArr?.count == 1 {
                let imageView =  ScrollImageView.init()
                imageView.scrollImageViewClosure = { (state) in
                    switch (state){
                    case UIGestureRecognizerState.began:
                        self.cancelTimer()
                    case UIGestureRecognizerState.ended:
                        self.enableTimer()
                    case UIGestureRecognizerState.cancelled:
                        self.enableTimer()
                    case UIGestureRecognizerState.failed:
                        self.enableTimer()
                    default:
                        break
                    }
                }
                imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
                imageView.isUserInteractionEnabled = true
                imageView.tag = 100
                imageView.dataTag = 100
                imageView.kf.setImage(with: URL.init(string: imageUrlStrArr![0] as String)!)
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
                
                for i in (0..<(imageUrlStrArr?.count)!) {
                    let imageView =  ScrollImageView.init()
                    imageView.scrollImageViewClosure = { (state) in
                        switch (state){
                        case UIGestureRecognizerState.began:
                            self.cancelTimer()
                        case UIGestureRecognizerState.ended:
                            self.enableTimer()
                        case UIGestureRecognizerState.cancelled:
                            self.enableTimer()
                        case UIGestureRecognizerState.failed:
                            self.enableTimer()
                        default:
                            break
                        }
                    }
                    if i >= 3{
                        imageView.frame = CGRect(x: 0, y: self.frame.size.height / 2, width: 0, height: 0)
                    }
                    else{
                        imageView.frame = self.frameArray![i]
                    }
                    
                    imageView.isUserInteractionEnabled = true
                    if style == 1 && i == 2{
                        imageView.dataTag = 100
                    }
                    else{
                        imageView.dataTag = 100 + i
                    }
                    
                    imageView.tag = 100 + i
                    imageView.kf.setImage(with: URL.init(string: imageUrlStrArr![i] as String)!)
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
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 0))
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = true
        scrollView.delaysContentTouches = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        return scrollView
        
    }()
    
    lazy var frameArray:[CGRect]? = {
        let array =
        [
            CGRect(x: 0, y: self.frame.size.height * 0.1, width: self.frame.size.width * 0.2, height: self.frame.size.height * 0.8),
            CGRect(x: self.frame.size.width * 0.2,  y: 0 , width: self.frame.size.width * 0.6, height: self.frame.size.height),
            CGRect(x: self.frame.size.width * 0.8, y: self.frame.size.height * 0.1, width: self.frame.size.width * 0.2, height: self.frame.size.height * 0.8),
        ]
        return array
    }()
    
    lazy var colorArr:[UIColor]? = {
        let array = [UIColor.purple,UIColor.black,UIColor.brown,UIColor.cyan,UIColor.blue]
        return array
    }()
    
    
    //布局
    override open func layoutSubviews() {
        super.layoutSubviews()
        var frame = scrollView?.frame
        frame?.size.height = self.frame.size.height
        scrollView?.frame = frame!
    }
    
}
