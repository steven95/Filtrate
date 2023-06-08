//
//  FiltrateTabCell.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/28.
//

import Foundation
import UIKit

class FilTabCell: UITableViewCell {
    
    open func setupUI(filtrateModel: FiltrateModel) {
        titleL.text = filtrateModel.title
        
        if filtrateModel.type == .left {
            iconV.isHidden = filtrateModel.iSmage
            titleL.textColor = filtrateModel.iSele ? FSHexColor(Hex: 0xF52938, alpha: 1) : FSHexColor(Hex: 0x85888C, alpha: 1)
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
            if filtrateModel.iSele {
                self.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }else{
                self.backgroundColor = FSHexColor(Hex: 0xECEEEF, alpha: 1)
            }
        }else if (filtrateModel.type == .cen){
            iconV.isHidden = filtrateModel.iSmage
            titleL.textColor = filtrateModel.iSele ? FSHexColor(Hex: 0xF52938, alpha: 1) : FSHexColor(Hex: 0x85888C, alpha: 1)
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
            if filtrateModel.iSele {
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            }else{
                self.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }
        }else if (filtrateModel.type == .right){
            iconV.isHidden = false
            self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            titleL.textColor = filtrateModel.iSele ? FSHexColor(Hex: 0xF52938, alpha: 1) : FSHexColor(Hex: 0x85888C, alpha: 1)
            iconV.image =  filtrateModel.iSele ? UIImage.init(named: "choose_select") : UIImage.init(named: "choose_unselect")
        }else if(filtrateModel.type == .sort){
            iconV.isHidden = true
            self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            if filtrateModel.iSele {
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
                titleL.textAlignment = .left
            }else{
                titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
                titleL.textAlignment = .left
            }
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(FRPRealValue(15))
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
        titleL.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
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
            make.right.equalToSuperview().offset(FRPRealValue(-8))
            make.width.height.equalTo(FRPRealValue(19))
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
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else{
                titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
                iconV.image = UIImage.init(named: "choose_unselect")
            }
            if filtrateModel.iSele {
                self.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }else{
                self.backgroundColor = FSHexColor(Hex: 0xECEEEF, alpha: 1)
            }
        }else if (filtrateModel.type == .cen){
            iconV.isHidden = filtrateModel.iSmage
            if filtrateModel.iSeleType == .all {
                iconV.image = UIImage.init(named: "choose_select")
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else{
                titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
                iconV.image = UIImage.init(named: "choose_unselect")
            }
            if filtrateModel.iSele {
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            }else{
                self.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
            }
        }else if (filtrateModel.type == .right){
            iconV.isHidden = false
            self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            if filtrateModel.iSeleType == .all {
                iconV.image = UIImage.init(named: "choose_select")
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else if filtrateModel.iSeleType == .cen {
                iconV.image = UIImage.init(named: "choose_cen")
                self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            }else{
                titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
                iconV.image = UIImage.init(named: "choose_unselect")
            }
        }else if(filtrateModel.type == .sort){
            iconV.isHidden = true
            self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
            if filtrateModel.iSele {
                titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
                titleL.textAlignment = .left
            }else{
                titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
                titleL.textAlignment = .left
            }
            titleL.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalToSuperview().offset(FRPRealValue(15))
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
        titleL.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        titleL.textColor = FSHexColor(Hex: 0x85888C, alpha: 1)
        return titleL
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(iconV)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleL.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(0)
        }
        iconV.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(FRPRealValue(-8))
            make.width.height.equalTo(FRPRealValue(19))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
