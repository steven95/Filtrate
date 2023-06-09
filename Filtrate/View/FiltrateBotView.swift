//
//  FiltrateBotView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/28.
//

import Foundation
import UIKit

open class FiltrateBotView: UIView {
    
    lazy var goBtn :UIButton = {
        var goBtn = UIButton.init(frame: CGRect.zero)
        goBtn.adjustsImageWhenHighlighted = false
        goBtn.setTitle("确定", for: .normal)
        goBtn.titleLabel?.font =  UIFont.systemFont(ofSize: FRPRealValue(19))
        goBtn.setTitleColor(.white, for: .normal)
        goBtn.setTitleColor(FSHexColor(Hex: 0xFFFFFF, alpha: 1), for: .normal)
        goBtn.backgroundColor = FSHexColor(Hex: 0xFC3D4B, alpha: 1)
        goBtn.addTarget(self, action: #selector(click_goBtn), for: .touchUpInside)
        return goBtn
    }()
    
    lazy var reBtn :UIButton = {
        var reBtn = UIButton.init(frame: CGRect.zero)
        reBtn.setTitle("重置", for: .normal)
        reBtn.adjustsImageWhenHighlighted = false
        reBtn.titleLabel?.font =  UIFont.systemFont(ofSize: FRPRealValue(18))
        reBtn.setTitleColor(FSHexColor(Hex: 0x261919, alpha: 1), for: .normal)
        reBtn.addTarget(self, action: #selector(click_reBtn), for: .touchUpInside)
        return reBtn
    }()
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        return lineV
    }()
    
    
    open lazy var blineV : UIView = {
        let blineV = UIView.init()
        blineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        return blineV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        self.addSubview(lineV)
        self.addSubview(reBtn)
        self.addSubview(goBtn)
        self.addSubview(blineV)
    }
    
    open override func layoutSubviews() {
        
        lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset((0))
            make.height.equalTo(FRPRealValue(0.5))
        }
        
        reBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(FRPRealValue(0))
            make.left.equalToSuperview().offset(FRPRealValue(40))
            make.width.equalTo(FRPRealValue(130))
            make.height.equalTo(FRPRealValue(42))
        }
        reBtn.layer.cornerRadius = FRPRealValue(4)
        reBtn.layer.borderColor = FSHexColor(Hex: 0x979797, alpha: 1).cgColor
        reBtn.layer.borderWidth = FRPRealValue(1)
        reBtn.layer.masksToBounds = true
        
        goBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(FRPRealValue(0))
            make.height.equalTo(FRPRealValue(42))
            make.left.equalTo(reBtn.snp_right).offset(FRPRealValue(16))
            make.right.equalToSuperview().offset(-FRPRealValue(21))
        }
        goBtn.layer.cornerRadius = FRPRealValue(4)
        goBtn.layer.masksToBounds = true
        
        blineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset((-FRPRealValue(0.5)))
            make.height.equalTo(FRPRealValue(0.5))
        }
    }
    
    required public init?(coder: NSCoder) {
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
