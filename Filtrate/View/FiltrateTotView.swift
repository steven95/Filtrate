//
//  FiltrateTotView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/2.
//

import Foundation
import UIKit

public class FiltrateTotView: UIView {
    
    open var filtrateGroups:NSMutableArray = []
    private var _groups:NSMutableArray = []
    public   var  groups:NSMutableArray { //FiltrateModel
          get {
              return _groups
          }
          set {
              _groups = newValue
              if filtrateGroups.count == 0 {
                  filtrateGroups = newValue.mutableCopy() as! NSMutableArray
              }
              self.subviews.forEach { view in
                  view.removeFromSuperview()
              }
              _groups.enumerateObjects { (object, index, stop) in
                  let filtrateModel:FiltrateModel = object as! FiltrateModel
                  let regionBtn = UIButton.init(frame: CGRect.zero)
                  regionBtn.setTitle(filtrateModel.title ?? "", for: .normal)
                  regionBtn.setTitle(filtrateModel.title ?? "", for: .selected)
                  if filtrateModel.iSele {
                    
                      regionBtn.setTitleColor(FSHexColor(Hex: 0xF52938, alpha: 1), for: .normal)
                  }else{
                      regionBtn.setTitleColor(FSHexColor(Hex: 0x261919, alpha: 1), for: .normal)
                  }
                  regionBtn.setTitleColor(FSHexColor(Hex: 0xF52938, alpha: 1), for: .selected)
                  regionBtn.tag = index
                  regionBtn.titleLabel?.font = UIFont.systemFont(ofSize: FRPRealValue(14))
                  regionBtn.addTarget(self, action:#selector(click_region), for: .touchUpInside)
                  addSubview(regionBtn)
                  regionBtn.snp.makeConstraints { make in
                      make.centerY.top.bottom.equalToSuperview().offset(0)
                      make.width.equalTo(UIScreen.main.bounds.size.width / CGFloat(groups.count))
                      make.left.equalTo(CGFloat(index) * UIScreen.main.bounds.size.width / CGFloat(groups.count))
                  }
                  if filtrateModel.iSmage {
                      regionBtn.set(image: UIImage.init(named: "arrow_down"), title:  filtrateModel.title ?? "" , titlePosition: .left, additionalSpacing: FRPRealValue(4), state: .normal)
                      regionBtn.set(image: UIImage.init(named: "arrow_up"), title:  filtrateModel.title ?? "" , titlePosition: .left, additionalSpacing: FRPRealValue(4), state: .selected)
                  }else{
                      regionBtn.setTitle(filtrateModel.title ?? "", for: .normal)
                      regionBtn.setTitle(filtrateModel.title ?? "", for: .selected)
                  }
              }
          }
    }
    
    private var _topHeight:CGFloat = 0
    public   var  topHeight:CGFloat { //特殊情况下的微调高度
          get {
              return _topHeight
          }
          set {
              _topHeight = newValue
          }
    }
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        return lineV
    }()
    
    open lazy var bgView : UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = FSHexColor(Hex: 0x000000, alpha: 0.1).withAlphaComponent(0.1)
        return bgView
    }()
    
    open lazy var botView : UIView = {
        let botView = UIView.init()
        botView.backgroundColor = .clear
        botView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        return botView
    }()
    
    open func returnRegionBlock(_ callback: @escaping (_ indexPath:IndexPath,_ filtrates: Array<FiltrateModel>?) -> Void) {
        returnRegionAction = callback
    }
    private  var returnRegionAction: ((_ indexPath:IndexPath,_ filtrates: Array<FiltrateModel>?) -> Void)?
    
    open func returnTagBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void) {
        returnTagAction = callback
    }
    private  var returnTagAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void))?
    
    
    open func returnTagSetBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
    private  var returnTagSetAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void))?
    
    open func returnPriceBlock(_ callback: @escaping(_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
    private  var returnPriceAction: ( (_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) (NSMutableArray) -> Void) {
        returnReSetAction = callback
    }
    private  var returnReSetAction: ( (@convention(block) (NSMutableArray) -> Void))?
    
    public var filtrates:Array<FiltrateModel> = []
    public var filtrateIndexPath : IndexPath = IndexPath.init()
    public var dismissIndexPath : IndexPath = IndexPath.init()
    public var filChildren:Array<CustorData> = []
    public var firChildren:Array<CustorData> = []
    
    public var fchildren:Array<CustorData> = []
    
    open lazy var filtrateAlerView : FiltrateAlerView = {
        let filtrateAlerView = FiltrateAlerView.init()
        filtrateAlerView.backgroundColor = .white
        filtrateAlerView.returnBlock { [weak  self] in
            guard let uSelf = self  else { return }
            uSelf.dismissView()
        }
        
        filtrateAlerView.returnReSetBlock { [weak self] in
            guard let uSelf = self  else { return }
            uSelf.groups =  uSelf.filtrateGroups

            if uSelf.returnReSetAction != nil {
                uSelf.returnReSetAction!(uSelf.filtrateGroups)
            }
        }
        
        filtrateAlerView.returnRegionBlock { [weak self] (indexPath, filtrates) in
            guard let uSelf = self  else { return }
            uSelf.dismissIndexPath = indexPath
            uSelf.filtrates = filtrates ?? []
            if uSelf.returnRegionAction != nil {
                uSelf.returnRegionAction!(indexPath,filtrates)
            }
        }
        
        filtrateAlerView.returnSegBlock { [weak self] in
            guard let uSelf = self  else { return }
            uSelf.filtrateAlerView.snp.remakeConstraints { make in
                make.top.left.right.equalToSuperview().offset(0)
                make.height.equalTo(uSelf.filtrateAlerView.filtrateAlerViewHeight())
            }
            uSelf.botView.snp.remakeConstraints { make in
                make.bottom.left.right.equalToSuperview().offset(0)
                make.top.equalTo(uSelf.filtrateAlerView.snp_bottom).offset(0)
            }
        }
        
        filtrateAlerView.returnTagBlock {[weak self] (indexPath, index) in
            guard let uSelf = self  else { return }
            if uSelf.returnTagAction != nil {
                uSelf.returnTagAction!(indexPath, index)
            }
        }
        
        filtrateAlerView.returnTagSetBlock { [weak self] ( indexPath, index, groupsele) in
            guard let uSelf = self  else { return }
            if uSelf.returnTagSetAction != nil {
                uSelf.returnTagSetAction!(indexPath, index,groupsele)
            }
        }
        
        filtrateAlerView.returnPriceBlock { [weak self] (type, text) in
            guard let uSelf = self  else { return }
            if uSelf.returnPriceAction != nil {
                uSelf.returnPriceAction!(type, text)
            }
        }

        return filtrateAlerView
    }()
    
    var filTypeAler: FilTypeAler = FilTypeAler.region
    
    var filIndex = 0
    
    @objc  func click_region(btn:UIButton)  {
         filIndex = btn.tag
        if btn.isSelected {
            btn.isSelected = false
            dismissView()
        }else{
            btn.isSelected = true
            subviews.forEach { view in
                if view != btn {
                    if view.isKind(of: UIButton.classForCoder()) {
                        (view as! UIButton).isSelected = false
                    }
                }
            }
        }
        
        let filtrateModel:FiltrateModel = groups[btn.tag] as! FiltrateModel
        filTypeAler = filtrateModel.filType ?? .region
        if returnAction != nil {
            returnAction!(filtrateModel,filtrateModel.filType,btn.isSelected)
        }
        if filtrateModel.iSmage {
            showInWindow()
        }
    }
    
    open func filtrateBlock(_ callback: @escaping @convention(block) () -> Void) {
        filtrateAction = callback
    }
    private  var filtrateAction: ( (@convention(block) () -> Void))?
    
    
    open func dismissBlock(_ callback: @escaping @convention(block) () -> Void) {
        dismissAction = callback
    }
    open  var dismissAction: ( (@convention(block) () -> Void))?
    
    open func returnBlock(_ callback: @escaping(_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void)?
    
    
    public  override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(lineV)
        lineV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset((-FRPRealValue(0.5)))
            make.height.equalTo(FRPRealValue(0.5))
        }
    }
    
    @objc public func dismissView(){
        
           filtrateAlerView.segmentBar.selectItemAt(index: 0)
            UIView.animate(withDuration: 0.3, animations: {[self] in
                self.bgView.alpha = 0
            }) { (true) in
                self.bgView.isHidden = true
            }
            subviews.forEach { view in
                if view.isKind(of: UIButton.classForCoder()) {
                    (view as! UIButton).isSelected = false
                }
           }
        
          if dismissAction != nil {
              dismissAction!()
          }
        }
    public  func showInWindow(){
            
            if filtrateAction != nil {
                filtrateAction!()
            }
            
            UIApplication.shared.keyWindow?.addSubview(bgView)
            bgView.addSubview(filtrateAlerView)
            bgView.addSubview(botView)
            bgView.isHidden = false
            filtrateAlerView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(filtrateAlerView.filtrateAlerViewHeight())
                make.top.equalToSuperview().offset(FRPRealValue(-1))
            }
           
            botView.snp.remakeConstraints { make in
                make.bottom.left.right.equalToSuperview().offset(0)
                make.top.equalTo(filtrateAlerView.snp_bottom).offset(0)
            }
        
            self.bgView.snp.remakeConstraints { make in
                make.left.bottom.right.equalToSuperview().offset(0)
                make.top.equalTo(FRPRealValue(CGFloat((( UIScreen.main.bounds.size.height <= 667.0) ? 50 : (UIScreen.main.bounds.size.height >= 812.0) ? 50 : 40) +  ((UIScreen.main.bounds.size.height >= 812.0) ? 44 : 20)) + topHeight) )
            }
            
            UIView.animate(withDuration: 0.25, animations: { [self] in
                self.filtrateAlerView.layoutIfNeeded()
                self.botView.layoutIfNeeded()
                self.bgView.layoutIfNeeded()
                self.bgView.alpha = 1
            }, completion: nil)
        }
         
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
