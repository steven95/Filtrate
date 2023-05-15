//
//  FiltrateTabCell.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/28.
//

import Foundation
import UIKit

class FilTabCell: UITableViewCell {
    
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
    
    open func setupUI(filtrateModel: FiltrateModel) {
        titleL.text = filtrateModel.title
        
        if filtrateModel.type == .left {
            iconV.isHidden = filtrateModel.iSmage
            titleL.textColor = filtrateModel.iSele ? .tintColor : .labelColor
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
            if filtrateModel.iSele {
                self.backgroundColor = JSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }else{
                self.backgroundColor = JSHexColor(Hex: 0xECEEEF, alpha: 1)
            }
        }else if (filtrateModel.type == .cen){
            iconV.isHidden = filtrateModel.iSmage
            titleL.textColor = filtrateModel.iSele ? .tintColor : .labelColor
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
            if filtrateModel.iSele {
                self.backgroundColor = .whiteColor
            }else{
                self.backgroundColor = JSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }
        }else if (filtrateModel.type == .right){
            iconV.isHidden = false
            self.backgroundColor = .whiteColor
            titleL.textColor = filtrateModel.iSele ? .tintColor : .labelColor
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
        }else if(filtrateModel.type == .sort){
            iconV.isHidden = true
            self.backgroundColor = .whiteColor
            if filtrateModel.iSele {
                titleL.textColor = .tintColor
                titleL.textAlignment = .left
            }else{
                titleL.textColor = .labelColor
                titleL.textAlignment = .left
            }
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
            }
        }
    }
    
    open func returnBlock(_ callback: @escaping() -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( () -> Void)?
    
    open lazy var iconV : UIImageView = {
        let iconV = UIImageView.init(image: UIImage.init(named: "choose_unselect"))
        iconV.isUserInteractionEnabled = true
        iconV.isHidden = false
        iconV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click_iconV)))
        return iconV
    }()
    
    @objc func click_iconV() {
        if returnAction != nil {
            returnAction!()
        }
    }
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .center
        titleL.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        titleL.textColor = .labelColor
        return titleL
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleL)
        contentView.addSubview(iconV)
    }
    
    override func layoutSubviews() {
        titleL.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(0)
        }
        iconV.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(kRPRealValue(-8))
            make.width.height.equalTo(kRPRealValue(19))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FiltrateTabCell: UITableViewCell {
    
    open func setupUI(filtrateModel: FiltrateModel) {
        titleL.text = filtrateModel.title
        
        if filtrateModel.type == .left {
            iconV.isHidden = filtrateModel.iSmage
            if filtrateModel.iSeleType == .all {
                iconV.image = UIImage.init(named: "choose_select")
                titleL.textColor = .tintColor
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                titleL.textColor = .tintColor
            }else{
                titleL.textColor = .labelColor
                iconV.image = UIImage.init(named: "choose_unselect")
            }
            if filtrateModel.iSele {
                self.backgroundColor = JSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }else{
                self.backgroundColor = JSHexColor(Hex: 0xECEEEF, alpha: 1)
            }
        }else if (filtrateModel.type == .cen){
            iconV.isHidden = filtrateModel.iSmage
            if filtrateModel.iSeleType == .all {
                iconV.image = UIImage.init(named: "choose_select")
                self.backgroundColor = .whiteColor
                titleL.textColor = .tintColor
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                self.backgroundColor = .whiteColor
                titleL.textColor = .tintColor
            }else{
                titleL.textColor = .labelColor
                iconV.image = UIImage.init(named: "choose_unselect")
            }
            if filtrateModel.iSele {
                self.backgroundColor = .whiteColor
            }else{
                self.backgroundColor = JSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }
        }else if (filtrateModel.type == .right){
            iconV.isHidden = false
            self.backgroundColor = .whiteColor
            if filtrateModel.iSeleType == .all {
                iconV.image = UIImage.init(named: "choose_select")
                self.backgroundColor = .whiteColor
                titleL.textColor = .tintColor
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                self.backgroundColor = .whiteColor
                titleL.textColor = .tintColor
            }else{
                titleL.textColor = .labelColor
                iconV.image = UIImage.init(named: "choose_unselect")
            }
        }else if(filtrateModel.type == .sort){
            iconV.isHidden = true
            self.backgroundColor = .whiteColor
            if filtrateModel.iSele {
                titleL.textColor = .tintColor
                titleL.textAlignment = .left
            }else{
                titleL.textColor = .labelColor
                titleL.textAlignment = .left
            }
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(kRPRealValue(15))
            }
        }
    }
    
    open func returnBlock(_ callback: @escaping() -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( () -> Void)?
    
    open lazy var iconV : UIImageView = {
        let iconV = UIImageView.init(image: UIImage.init(named: "choose_unselect"))
        iconV.isUserInteractionEnabled = true
        iconV.isHidden = false
        iconV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click_iconV)))
        return iconV
    }()
    
    @objc func click_iconV() {
        if returnAction != nil {
            returnAction!()
        }
    }
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .center
        titleL.font = UIFont.systemFont(ofSize: kRPRealValue(14))
        titleL.textColor = .labelColor
        return titleL
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleL)
        contentView.addSubview(iconV)
    }
    
    override func layoutSubviews() {
        titleL.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(0)
        }
        iconV.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(kRPRealValue(-8))
            make.width.height.equalTo(kRPRealValue(19))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
