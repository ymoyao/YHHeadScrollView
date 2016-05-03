//
//  YHHeadScrollView.swift
//  YHHeadScrollView
//
//  Created by SR on 16/4/29.
//  Copyright © 2016年 游辉. All rights reserved.
//

import UIKit
import Foundation


class YHHeadScrollView: UIView {
    
    
    var arry:[NSString]?
    enum Order {
        case OrderLeftInvisible
        case OrderLeftVisible
        case OrderMiddleVisible
        case OrderRightVisible
        case OrderRightInvisible
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
    
    //MARK: - =Network=
    //MARK: - =Superclass=
    //MARK: - =Event=
    //单击
    func tapGes(tap:UITapGestureRecognizer){
        print("count = \(self.imageViewArr!.count)")
        
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            self.imageViewArr! = self.rotate((tap.view?.tag)! - 100, array: self.imageViewArr!) as! [UIImageView]
            
            for var i = 0; i < self.imageViewArr?.count ; i++ {
                if i >= 5{
                     self.imageViewArr![i].frame = CGRectZero
                }
                else{
                     self.imageViewArr![i].frame = self.frameArray![i]
                }

               
                self.imageViewArr![i].tag = 100 + i
            }
            self.currentShowTag = (tap.view?.tag)! - 100
            
            }, completion: nil)
        
    }
    
    
    
    
    //MARK: - =Delegate=
    
    //MARK: - =Setter/Getter=
    private var currentShowTag = 2
    private var imageViewArr:[UIImageView]?
    var imageUrlStrArr:[NSString]? {
        
        didSet{
            self.imageViewArr = [UIImageView]()
            for var i = 0; i < imageUrlStrArr?.count; i++ {
                let imageView =  UIImageView.init()
                if i >= 5{
                    imageView.frame = CGRectZero
                }
                else{
                    imageView.frame = self.frameArray![i]
                }
  
                imageView.userInteractionEnabled = true
                imageView.tag = 100 + i
                imageView.sd_setImageWithURL(NSURL.init(string: imageUrlStrArr![i] as String), placeholderImage: UIImage.init(named: "1"))
                imageView.addGestureRecognizer(tapGes())
                self.scrollView?.addSubview(imageView)
                self.imageViewArr?.append(imageView)
                
            }
        }
    }
    
    lazy var scrollView:UIScrollView? = {
        let scrollView = UIScrollView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width , 0))
        scrollView.backgroundColor = UIColor.yellowColor()
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 150)
        return scrollView
        
    }()
    
    lazy var frameArray:[CGRect]? = {
        let array =
        [CGRectMake(0, self.frame.size.height / 2, 0, 0),
            CGRectMake(0, self.frame.size.height * 0.1, self.frame.size.width * 0.2, self.frame.size.height * 0.8),
            CGRectMake(self.frame.size.width * 0.2,  0 , self.frame.size.width * 0.6, self.frame.size.height),
            CGRectMake(self.frame.size.width * 0.8, self.frame.size.height * 0.1, self.frame.size.width * 0.2, self.frame.size.height * 0.8),
            CGRectMake(self.frame.size.width, self.frame.size.height / 2, 0, 0)]
        return array
    }()
    
    lazy var colorArr:[UIColor]? = {
        let array = [UIColor.purpleColor(),UIColor.blackColor(),UIColor.brownColor(),UIColor.cyanColor(),UIColor.blueColor()]
        return array
    }()
    
    
    //MARK: - =Private=
    func tapGes() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer.init(target: self, action: Selector("tapGes:"))
        return tap
    }
    
    
    func rotate(index:Int, var array:[AnyObject]) -> [AnyObject]{
        var arrarHalfCount = 2

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
    
    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = scrollView?.frame
        frame?.size.height = self.frame.size.height
        scrollView?.frame = frame!
    }
    
}
