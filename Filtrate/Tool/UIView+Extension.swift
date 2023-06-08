//
//  UIView+Extension.swift
//  DXDoctor
//
//  Created by wuliupai on 16/9/20.
//  Copyright © 2016年 wuliu. All rights reserved.
//

import UIKit

extension UIView {
    
    // x
  public  var jx : CGFloat {
        
        get {
            
            return frame.origin.x
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    
    // y
  public  var jy : CGFloat {
        
        get {
            
            return frame.origin.y
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    // height
  public  var jheight : CGFloat {
        
        get {
            
            return frame.size.height
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    // width
  public  var jwidth : CGFloat {
        
        get {
            
            return frame.size.width
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    // left
 public   var jleft : CGFloat {
        
        get {
            
            return jx
        }
        
        set(newVal) {
            
            jx = newVal
        }
    }
    
    // right
 public   var jright : CGFloat {
        
        get {
            
            return jx + jwidth
        }
        
        set(newVal) {
            
            jx = newVal - jwidth
        }
    }
    
    // top
   public var jtop : CGFloat {
        
        get {
            
            return jy
        }
        
        set(newVal) {
            
            jy = newVal
        }
    }
    
    // bottom
 public   var jbottom : CGFloat {
        
        get {
            
            return jy + jheight
        }
        
        set(newVal) {
            
            jy = newVal - jheight
        }
    }
    
  public  var jcenterX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
  public  var jcenterY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
 public   var jmiddleX : CGFloat {
        
        get {
            
            return jwidth / 2
        }
    }
    
 public   var jmiddleY : CGFloat {
        
        get {
            
            return jheight / 2
        }
    }
    
 public   var jmiddlePoint : CGPoint {
        
        get {
            
            return CGPoint(x: jmiddleX, y: jmiddleY)
        }
    }
  public  var size:CGSize{
        
        get{
            return frame.size
        }
        set{
            frame.size = newValue
        }
    }
  
/**
 *画边框虚线
 *v1.drawBoardDottedLine(3, lenth: 5, space: 3, cornerRadius: 10, color: UIColor.red)
 */
    func swiftDrawBoardDottedLine(width:CGFloat,lenth:CGFloat,space:CGFloat,cornerRadius:CGFloat,color:UIColor){
            self.layer.cornerRadius = cornerRadius
            let borderLayer =  CAShapeLayer()
            borderLayer.bounds = self.bounds
            
            borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY);
            borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: cornerRadius).cgPath
            borderLayer.lineWidth = width / UIScreen.main.scale
            
            //虚线边框---小边框的长度
            borderLayer.lineDashPattern = [lenth,space] as? [NSNumber]
            //前边是虚线的长度，后边是虚线之间空隙的长度
            borderLayer.lineDashPhase = 0.1;
            //实线边框
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = color.cgColor
            self.layer.addSublayer(borderLayer)
            
        }
    
    //返回该view所在VC
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    //设置渐变色背景
    func setGradientBackcolor(colors:[Any],gradientFrame:CGRect? = nil) {
        
        layoutIfNeeded()
        removeGradientLayer()
        let gradient = CAGradientLayer()
        if gradientFrame == nil{
            gradient.frame = self.bounds
        }else{
            gradient.frame = gradientFrame!
        }
        
        gradient.colors = colors
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    public func removeGradientLayer() {
        guard let layers = self.layer.sublayers else { return }
        for layer in layers {
            if layer.isKind(of: CAGradientLayer.self) {
                layer.removeFromSuperlayer()
            }
        }
    }
    // 创建部分半角
    func createPartRadius(cornerRadius:CGSize,corner:UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadius)
        let masklayer = CAShapeLayer()
        masklayer.frame = self.bounds
        masklayer.path = maskPath.cgPath
        self.layer.mask = masklayer
    }
    /// 设置view四周圆角
    ///view的frame不能使用约束
    /// - Parameter cornerRad: 圆角的角度
    func setlayerCorners(cornerRad:CGFloat,roundingCorners :UIRectCorner = .allCorners) {
       //        [UIRectCorner.topLeft,UIRectCorner.bottomLeft,UIRectCorner.topRight,UIRectCorner.bottomRight]
        //设置图片圆角
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRad, height: cornerRad))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}


