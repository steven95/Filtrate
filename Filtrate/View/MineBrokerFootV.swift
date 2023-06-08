//
//  MineBrokerFootV.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/23.
//

import Foundation
import UIKit

@objc enum BrokerType: Int {
     case normal
     case exclusive
 }


class MineBrokerFootV: UIView {
    
    lazy var goBtn :GradientButton = {
        var goBtn = GradientButton.init(frame: CGRect.zero)
        goBtn.adjustsImageWhenHighlighted = false
        goBtn.setTitle("设为专属经纪人", for: .normal)
        goBtn.titleLabel?.font =  UIFont.systemFont(ofSize: FRPRealValue(19))
        goBtn.setTitleColor(.white, for: .normal)
        let firstColor = FSHexColor(Hex: 0xF52938, alpha: 1)
        let secondColor = FSHexColor(Hex: 0xF52938, alpha: 1)
        goBtn.direction = .topToBottom
        goBtn.gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        goBtn.addTarget(self, action: #selector(click_goBtn), for: .touchUpInside)
        return goBtn
    }()
    
    lazy var goBtn2 :GradientButton = {
        var goBtn2 = GradientButton.init(frame: CGRect.zero)
        goBtn2.adjustsImageWhenHighlighted = false
        goBtn2.setTitle("解除专属", for: .normal)
        goBtn2.titleLabel?.font =  UIFont.systemFont(ofSize: FRPRealValue(19))
        goBtn2.setTitleColor(FSHexColor(Hex: 0x000000, alpha: 1), for: .normal)
        goBtn2.direction = .topToBottom
        goBtn2.backgroundColor = .white
        goBtn2.tag = 2
        goBtn2.addTarget(self, action: #selector(click_goBtn), for: .touchUpInside)
        goBtn2.isHidden = true
        return goBtn2
    }()
    
    var brokerType: BrokerType = BrokerType.init(rawValue: 0)!
    
    open func setupUI(brokerType: BrokerType) {
        self.brokerType = brokerType
        if brokerType == .normal {
            goBtn2.isHidden = true
            goBtn.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(FRPRealValue(32))
                make.right.equalToSuperview().offset(-FRPRealValue(32))
                make.height.equalTo(FRPRealValue(50))
                make.centerY.equalToSuperview().offset(0)
            }
            goBtn.setTitle("设为专属经纪人", for: .normal)
            goBtn.layer.cornerRadius = FRPRealValue(5)
            goBtn.layer.masksToBounds = true
        }else{
            
            goBtn2.isHidden = false
            goBtn2.snp.remakeConstraints { make in
                make.width.equalTo(FRPRealValue(147))
                make.right.equalTo(self.snp_centerX).offset(-FRPRealValue(7.5))
                make.height.equalTo(FRPRealValue(50))
                make.centerY.equalToSuperview().offset(0)
            }
            goBtn2.layer.cornerRadius = FRPRealValue(5)
            goBtn2.layer.borderColor = FSHexColor(Hex: 0x85888C, alpha: 1).cgColor
            goBtn2.layer.borderWidth = FRPRealValue(0.5)
            goBtn2.layer.masksToBounds = true
            
            goBtn.setTitle("去评价", for: .normal)
            goBtn.snp.remakeConstraints { make in
                make.width.equalTo(FRPRealValue(147))
                make.left.equalTo(self.snp_centerX).offset(FRPRealValue(7.5))
                make.height.equalTo(FRPRealValue(50))
                make.centerY.equalToSuperview().offset(0)
            }
            goBtn.layer.cornerRadius = FRPRealValue(5)
            goBtn.layer.masksToBounds = true
        }
         
    }
    
    private var _titleStr:String = ""
    public   var  titleStr:String {
          get {
              return _titleStr
          }
          set {
              _titleStr = newValue
              goBtn.setTitle(newValue, for: .normal)
          }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(goBtn)
        self.addSubview(goBtn2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func onButtonClick(_ callback: @escaping @convention(block) (BrokerType) -> Void) {
        onButton1Action = callback
    }
    private var onButton1Action:(@convention(block) (BrokerType) -> Void)?
    
    open func onButton2Click(_ callback: @escaping @convention(block) (BrokerType) -> Void) {
        onButton2Action = callback
    }
    private var onButton2Action:(@convention(block) (BrokerType) -> Void)?
    
    @objc func click_goBtn(_ btn :UIButton){
        if btn.tag == 2 {
            onButton2Action?(self.brokerType)
        }else{
            onButton1Action?(self.brokerType)
        }
    }
}
