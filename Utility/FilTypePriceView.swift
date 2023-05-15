//
//  FilTypePriceView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/2.
//

import Foundation
import UIKit

class FilTypePriceView: UIView {
    
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

    enum PriceTypeAler: Int {
        case price //无头
        case priceSing //有头没单位
        case priceMore //有头有单位
        case priceSingMore //有头单位不一样
        case priceThreeMore //有头单位不一样
    }
    
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .left
        titleL.font = UIFont.systemFont(ofSize: kRPRealValue(16))
        titleL.textColor = .labelColor
        titleL.text = "自定义"
        return titleL
    }()
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = JSHexColor(Hex: 0x3B4559, alpha: 1)
        return lineV
    }()
    
    open lazy var descL : UILabel = {
        let descL = UILabel.init()
        descL.textAlignment = .center
        descL.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        descL.textColor = .labelColor
        descL.text = "元"
        return descL
    }()
    
    open lazy var descL1 : UILabel = {
        let descL1 = UILabel.init()
        descL1.textAlignment = .center
        descL1.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        descL1.textColor = .labelColor
        descL1.text = "元"
        descL1.isHidden = true
        return descL1
    }()
    
    open lazy var descL2 : UILabel = {
        let descL2 = UILabel.init()
        descL2.textAlignment = .center
        descL2.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        descL2.textColor = .labelColor
        descL2.text = "元"
        descL2.isHidden = true
        return descL2
    }()
    
    open lazy var tf1 : UITextField = {
        let tf1 = UITextField.init()
        tf1.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        tf1.textAlignment = .center
        tf1.textColor = .blckColor
        tf1.placeholder = "输入最低价"
        tf1.keyboardType = .decimalPad
        tf1.backgroundColor = JSHexColor(Hex: 0xECEEEF, alpha: 1)
        unowned let uSelf = self
        tf1.delegate = uSelf
        tf1.tag = 1
        return tf1
    }()
    
    open lazy var tf2 : UITextField = {
        let tf2 = UITextField.init()
        tf2.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        tf2.textAlignment = .center
        tf2.textColor = .blckColor
        tf2.placeholder = "输入最高价"
        tf2.keyboardType = .decimalPad
        tf2.backgroundColor = JSHexColor(Hex: 0xECEEEF, alpha: 1)
        unowned let uSelf = self
        tf2.delegate = uSelf
        tf2.tag = 2
        return tf2
    }()
    
    open lazy var tf3 : UITextField = {
        let tf3 = UITextField.init()
        tf3.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        tf3.textAlignment = .center
        tf3.textColor = .blckColor
        tf3.placeholder = "输入最高价"
        tf3.keyboardType = .decimalPad
        tf3.backgroundColor = JSHexColor(Hex: 0xECEEEF, alpha: 1)
        unowned let uSelf = self
        tf3.delegate = uSelf
        tf3.tag = 2
        return tf3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(titleL)
        self.addSubview(lineV)
        self.addSubview(descL)
        self.addSubview(descL1)
        self.addSubview(descL2)
        self.addSubview(tf1)
        self.addSubview(tf2)
        self.addSubview(tf3)
       
    }
    
    var priceType:PriceTypeAler = .price
    
    open func setupUI(priceTypeAler: PriceTypeAler) {
        priceType = priceTypeAler
        descL1.isHidden = true
        if priceTypeAler == .price {
            titleL.isHidden = true
            descL.isHidden = true
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
                make.width.equalTo( kRPRealValue(60))
            }
            layoutPriceV()
        }else if priceTypeAler == .priceMore {
            titleL.isHidden = false
            descL.isHidden = false
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
//                make.width.equalTo(kRPRealValue(10))
            }
            layoutPriceV()
        }else if priceTypeAler == .priceSing {
            titleL.isHidden = false
            descL.isHidden = true
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
                make.width.equalTo(kRPRealValue(100))
            }
            layoutPriceV()
        }else if priceTypeAler == .priceSingMore {
            titleL.isHidden = false
            descL.isHidden = false
            descL1.isHidden = false
            lineV.isHidden = true
            descL2.isHidden = true
            tf3.isHidden = true
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
                make.width.equalTo(kRPRealValue(40))
            }
            
            tf1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalTo(titleL.snp_right).offset(kRPRealValue(5.5))
                make.height.equalTo(kRPRealValue(36))
            }
            tf1.layer.cornerRadius = kRPRealValue(2)
            tf1.layer.masksToBounds = true
            
            descL.snp.remakeConstraints { make in
                make.center.equalToSuperview().offset(0)
                make.width.equalTo( kRPRealValue(60))
                make.left.equalTo(tf1.snp_right).offset(kRPRealValue(10))
            }
            
            descL1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.right.equalToSuperview().offset(-kRPRealValue(15))
                make.width.equalTo( kRPRealValue(60))
            }
            
            tf2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.right.equalTo(descL1.snp_left).offset(-kRPRealValue(5.5))
                make.height.equalTo(kRPRealValue(36))
                make.width.equalTo(tf1.snp_width).offset(0)
                make.left.equalTo(descL.snp_right).offset(kRPRealValue(10))
            }
            tf2.layer.cornerRadius = kRPRealValue(2)
            tf2.layer.masksToBounds = true

        }else if priceTypeAler == .priceThreeMore {
            titleL.isHidden = true
            descL.isHidden = false
            descL1.isHidden = false
            lineV.isHidden = false
            descL2.isHidden = false
            tf3.isHidden = false
            
            tf1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalToSuperview().offset(kRPRealValue(15))
                make.height.equalTo(kRPRealValue(36))
            }
           
            descL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalTo(tf1.snp_right).offset(0)
            }
            
            tf2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(kRPRealValue(36))
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalTo(descL.snp_right).offset(0)
            }
          
            descL1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalTo(tf2.snp_right).offset(0)
            }
            
            tf3.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(kRPRealValue(36))
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalTo(descL1.snp_right).offset(0)
            }
         
            descL2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((JSCREENW - kRPRealValue(30)) / 6)
                make.left.equalTo(tf3.snp_right).offset(0)
                make.right.equalToSuperview().offset(-kRPRealValue(15))
            }
        }
       
    }
    
    func layoutPriceV() {
        descL2.isHidden = true
        tf3.isHidden = true
        tf1.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            if priceType == .price {
                make.left.equalToSuperview().offset(kRPRealValue(15))
            }else{
                make.left.equalTo(titleL.snp_right).offset(kRPRealValue(5.5))
            }
            make.height.equalTo(kRPRealValue(36))
        }

         lineV.snp.remakeConstraints { make in
             make.centerY.equalToSuperview().offset(0)
             make.height.equalTo(kRPRealValue(1))
             make.width.equalTo(kRPRealValue(16))
             make.left.equalTo(tf1.snp_right).offset(kRPRealValue(10))
         }
        
        tf1.layer.cornerRadius = kRPRealValue(2)
        tf1.layer.masksToBounds = true
        descL.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-kRPRealValue(15))
            make.width.equalTo(!descL.isHidden ? kRPRealValue(60) : kRPRealValue(10))
        }
        
        tf2.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalTo(descL.snp_left).offset(-kRPRealValue(5.5))
            make.height.equalTo(kRPRealValue(36))
            make.width.equalTo(tf1.snp_width).offset(0)
            make.left.equalTo(lineV.snp_right).offset(kRPRealValue(10))
        }
        tf2.layer.cornerRadius = kRPRealValue(2)
        tf2.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    open func returnBlock(_ callback: @escaping @convention(block) (UITextField) -> Void) {
        returnAction = callback
    }
    
    private var returnEndAction:(@convention(block) (UITextField) -> Void)?
    
    open func returnEndBlock(_ callback: @escaping @convention(block) (UITextField) -> Void) {
        returnEndAction = callback
    }
    
    private var returnAction:(@convention(block) (UITextField) -> Void)?
}

extension FilTypePriceView:UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if returnAction != nil {
            returnAction!(textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if returnEndAction != nil {
            returnEndAction!(textField)
        }
    }
}
