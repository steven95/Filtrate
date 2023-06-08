//
//  FilTypePriceView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/2.
//

import Foundation
import UIKit

public class FilTypePriceView: UIView {
    
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
        titleL.font = UIFont.boldSystemFont(ofSize: FRPRealValue(16))
        titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
        titleL.text = "自定义"
        return titleL
    }()
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = FSHexColor(Hex: 0x3B4559, alpha: 1)
        return lineV
    }()
    
    open lazy var descL : UILabel = {
        let descL = UILabel.init()
        descL.textAlignment = .center
        descL.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        descL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
        descL.text = "元"
        return descL
    }()
    
    open lazy var descL1 : UILabel = {
        let descL1 = UILabel.init()
        descL1.textAlignment = .center
        descL1.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        descL1.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
        descL1.text = "元"
        descL1.isHidden = true
        return descL1
    }()
    
    open lazy var descL2 : UILabel = {
        let descL2 = UILabel.init()
        descL2.textAlignment = .center
        descL2.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        descL2.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
        descL2.text = "元"
        descL2.isHidden = true
        return descL2
    }()
    
    open lazy var tf1 : UITextField = {
        let tf1 = UITextField.init()
        tf1.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        tf1.textAlignment = .center
        tf1.textColor = FSHexColor(Hex: 0x261919, alpha: 1)
        tf1.placeholder = "输入最低价"
        tf1.keyboardType = .decimalPad
        tf1.backgroundColor = FSHexColor(Hex: 0xECEEEF, alpha: 1)
        unowned let uSelf = self
        tf1.delegate = uSelf
        tf1.tag = 1
        return tf1
    }()
    
    open lazy var tf2 : UITextField = {
        let tf2 = UITextField.init()
        tf2.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        tf2.textAlignment = .center
        tf2.textColor = FSHexColor(Hex: 0x261919, alpha: 1)
        tf2.placeholder = "输入最高价"
        tf2.keyboardType = .decimalPad
        tf2.backgroundColor = FSHexColor(Hex: 0xECEEEF, alpha: 1)
        unowned let uSelf = self
        tf2.delegate = uSelf
        tf2.tag = 2
        return tf2
    }()
    
    open lazy var tf3 : UITextField = {
        let tf3 = UITextField.init()
        tf3.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        tf3.textAlignment = .center
        tf3.textColor = FSHexColor(Hex: 0x261919, alpha: 1)
        tf3.placeholder = "输入最高价"
        tf3.keyboardType = .decimalPad
        tf3.backgroundColor = FSHexColor(Hex: 0xECEEEF, alpha: 1)
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
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.width.equalTo( FRPRealValue(60))
            }
            layoutPriceV()
        }else if priceTypeAler == .priceMore {
            titleL.isHidden = false
            descL.isHidden = false
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(FRPRealValue(15))
//                make.width.equalTo(FRPRealValue(10))
            }
            layoutPriceV()
        }else if priceTypeAler == .priceSing {
            titleL.isHidden = false
            descL.isHidden = true
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.width.equalTo(FRPRealValue(100))
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
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.width.equalTo(FRPRealValue(40))
            }
            
            tf1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalTo(titleL.snp_right).offset(FRPRealValue(5.5))
                make.height.equalTo(FRPRealValue(36))
            }
            tf1.layer.cornerRadius = FRPRealValue(2)
            tf1.layer.masksToBounds = true
            
            descL.snp.remakeConstraints { make in
                make.center.equalToSuperview().offset(0)
                make.width.equalTo( FRPRealValue(60))
                make.left.equalTo(tf1.snp_right).offset(FRPRealValue(10))
            }
            
            descL1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.right.equalToSuperview().offset(-FRPRealValue(15))
                make.width.equalTo( FRPRealValue(60))
            }
            
            tf2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.right.equalTo(descL1.snp_left).offset(-FRPRealValue(5.5))
                make.height.equalTo(FRPRealValue(36))
                make.width.equalTo(tf1.snp_width).offset(0)
                make.left.equalTo(descL.snp_right).offset(FRPRealValue(10))
            }
            tf2.layer.cornerRadius = FRPRealValue(2)
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
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.height.equalTo(FRPRealValue(36))
            }
           
            descL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalTo(tf1.snp_right).offset(0)
            }
            
            tf2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(36))
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalTo(descL.snp_right).offset(0)
            }
          
            descL1.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalTo(tf2.snp_right).offset(0)
            }
            
            tf3.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(36))
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalTo(descL1.snp_right).offset(0)
            }
         
            descL2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.width.equalTo((UIScreen.main.bounds.size.width - FRPRealValue(30)) / 6)
                make.left.equalTo(tf3.snp_right).offset(0)
                make.right.equalToSuperview().offset(-FRPRealValue(15))
            }
        }
       
    }
    
    func layoutPriceV() {
        descL2.isHidden = true
        tf3.isHidden = true
        tf1.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            if priceType == .price {
                make.left.equalToSuperview().offset(FRPRealValue(15))
            }else{
                make.left.equalTo(titleL.snp_right).offset(FRPRealValue(5.5))
            }
            make.height.equalTo(FRPRealValue(36))
        }

         lineV.snp.remakeConstraints { make in
             make.centerY.equalToSuperview().offset(0)
             make.height.equalTo(FRPRealValue(1))
             make.width.equalTo(FRPRealValue(16))
             make.left.equalTo(tf1.snp_right).offset(FRPRealValue(10))
         }
        
        tf1.layer.cornerRadius = FRPRealValue(2)
        tf1.layer.masksToBounds = true
        descL.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-FRPRealValue(15))
            make.width.equalTo(!descL.isHidden ? FRPRealValue(60) : FRPRealValue(10))
        }
        
        tf2.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalTo(descL.snp_left).offset(-FRPRealValue(5.5))
            make.height.equalTo(FRPRealValue(36))
            make.width.equalTo(tf1.snp_width).offset(0)
            make.left.equalTo(lineV.snp_right).offset(FRPRealValue(10))
        }
        tf2.layer.cornerRadius = FRPRealValue(2)
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
