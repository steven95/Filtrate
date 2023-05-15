//
//  FiltrateBotView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/28.
//

import Foundation
import UIKit

class FiltrateBotView: UIView {
    
    func JSHexColor(Hex:NSInteger,alpha:CGFloat) -> UIColor {
        return UIColor(red:((CGFloat)((Hex & 0xFF0000) >> 16))/255.0,green:((CGFloat)((Hex & 0xFF00) >> 8))/255.0,blue:((CGFloat)(Hex & 0xFF))/255.0,alpha:alpha)
    }

    let JSCREENW = UIScreen.main.bounds.size.width

    let JSCREENH = UIScreen.main.bounds.size.height

    let IPHONE_6_SCREENW = 375.0
    let RealWidth = JSCREENW < JSCREENH ? JSCREENW : JSCREENH
    let kRPViewRatio = RealWidth / CGFloat(IPHONE_6_SCREENW)
    func kRPRealValue(_ value: CGFloat) -> CGFloat {
        return kRPViewRatio * value
    }
    
    lazy var goBtn :UIButton = {
        var goBtn = UIButton.init(frame: CGRect.zero)
        goBtn.adjustsImageWhenHighlighted = false
        goBtn.setTitle("确定", for: .normal)
        goBtn.titleLabel?.font =  UIFont.systemFont(ofSize: kRPRealValue(19))
        goBtn.setTitleColor(.white, for: .normal)
        goBtn.setTitleColor(UIColor.whiteColor, for: .normal)
        goBtn.backgroundColor = JSHexColor(Hex: 0xFC3D4B, alpha: 1)
        goBtn.addTarget(self, action: #selector(click_goBtn), for: .touchUpInside)
        return goBtn
    }()
    
    lazy var reBtn :UIButton = {
        var reBtn = UIButton.init(frame: CGRect.zero)
        reBtn.setTitle("重置", for: .normal)
        reBtn.adjustsImageWhenHighlighted = false
        reBtn.titleLabel?.font =  UIFont.systemFont(ofSize: kRPRealValue(18))
        reBtn.setTitleColor(JSHexColor(Hex: 0x261919, alpha: 1), for: .normal)
        reBtn.addTarget(self, action: #selector(click_reBtn), for: .touchUpInside)
        return reBtn
    }()
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = .separColor
        return lineV
    }()
    
    
    open lazy var blineV : UIView = {
        let blineV = UIView.init()
        blineV.backgroundColor = .separColor
        return blineV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .whiteColor
        self.addSubview(lineV)
        self.addSubview(reBtn)
        self.addSubview(goBtn)
        self.addSubview(blineV)
    }
    
    override func layoutSubviews() {
        
        lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset((0))
            make.height.equalTo(kRPRealValue(0.5))
        }
        
        reBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(kRPRealValue(0))
            make.left.equalToSuperview().offset(kRPRealValue(40))
            make.width.equalTo(kRPRealValue(130))
            make.height.equalTo(kRPRealValue(42))
        }
        reBtn.layer.cornerRadius = kRPRealValue(4)
        reBtn.layer.borderColor = JSHexColor(Hex: 0x979797, alpha: 1).cgColor
        reBtn.layer.borderWidth = kRPRealValue(1)
        reBtn.layer.masksToBounds = true
        
        goBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(kRPRealValue(0))
            make.height.equalTo(kRPRealValue(42))
            make.left.equalTo(reBtn.snp_right).offset(kRPRealValue(16))
            make.right.equalToSuperview().offset(-kRPRealValue(21))
        }
        goBtn.layer.cornerRadius = kRPRealValue(4)
        goBtn.layer.masksToBounds = true
        
        blineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset((-kRPRealValue(0.5)))
            make.height.equalTo(kRPRealValue(0.5))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    open func returnBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (@convention(block) () -> Void))?
    
    @objc func click_goBtn(_:UIButton){
        if returnAction != nil {
            returnAction?()
        }
    }
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnReSetAction = callback
    }
    private  var returnReSetAction: ( (@convention(block) () -> Void))?
    
    @objc func click_reBtn(_:UIButton){
        if returnReSetAction != nil {
            returnReSetAction?()
        }
    }
}
