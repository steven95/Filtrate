//
//  FiltrateTotView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/2.
//

import Foundation
import UIKit

class FiltrateTotView: UIView {
    
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
                    
                      regionBtn.setTitleColor(.tintColor, for: .normal)
                  }else{
                      regionBtn.setTitleColor(.blckColor, for: .normal)
                  }
                  regionBtn.setTitleColor(.tintColor, for: .selected)
                  regionBtn.tag = index
                  regionBtn.titleLabel?.font = UIFont.systemFont(ofSize: kRPRealValue(14))
                  regionBtn.addTarget(self, action:#selector(click_region), for: .touchUpInside)
                  addSubview(regionBtn)
                  regionBtn.snp.makeConstraints { make in
                      make.centerY.top.bottom.equalToSuperview().offset(0)
                      make.width.equalTo(JSCREENW / CGFloat(groups.count))
                      make.left.equalTo(CGFloat(index) * JSCREENW / CGFloat(groups.count))
                  }
                  if filtrateModel.iSmage {
                      regionBtn.set(image: UIImage.init(named: "arrow_down"), title:  filtrateModel.title ?? "" , titlePosition: .left, additionalSpacing: kRPRealValue(4), state: .normal)
                      regionBtn.set(image: UIImage.init(named: "arrow_up"), title:  filtrateModel.title ?? "" , titlePosition: .left, additionalSpacing: kRPRealValue(4), state: .selected)
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
        lineV.backgroundColor = .separColor
        return lineV
    }()
    
    open lazy var bgView : UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = JSHexColor(Hex: 0x000000, alpha: 0.1).withAlphaComponent(0.1)
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
    
    var filtrates:Array<FiltrateModel> = []
    var filtrateIndexPath : IndexPath = IndexPath.init()
    var dismissIndexPath : IndexPath = IndexPath.init()
    var filChildren:Array<CustorData> = []
    var firChildren:Array<CustorData> = []
    
    var fchildren:Array<CustorData> = []
    
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
                
                if filtrates?.count == 1 {
                    
                    uSelf.filtrateIndexPath = indexPath
                    var  regions:[CustorData] = []

                    let regionsArr:NSMutableArray = NSMutableArray.init()

                    user.filtrateAlerData.regionList?.forEach({ region in
                        regionsArr.add(region)
                    })
                    uSelf.firChildren.removeAll()
                    user.filtrateAlerData.regionList?.forEach({ regionList in
                        (regionList as CustorData).children?.forEach({ children in
                            if children.iSele == true {
                                uSelf.firChildren.append(children)
                            }
                        })
                    })

                    for (inx,region) in regionsArr.enumerated() {
                        if inx == indexPath.row - 1 {
                            (region as! CustorData).iSele = true
                            
                            if uSelf.firChildren.count > 1 {

                                var hchildren:Array<CustorData> = []

                                uSelf.firChildren.forEach { children in
                                    if !hchildren.contains(where: { $0.code == children.code }) {
                                        hchildren.append(children)
                                    }
                                }
                                uSelf.firChildren = hchildren

                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: "多选(\(uSelf.firChildren.count ))" , _filType: .region ,_iSele: ((region as! CustorData).iSele), _iSmage: true))
                            }else if  uSelf.firChildren.count == 1{
                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: uSelf.firChildren.count > 0 ? uSelf.firChildren.first?.name ?? "区域" : (filtrates?.first ?? FiltrateModel.init()).title ?? "区域" , _filType: .region ,_iSele: uSelf.firChildren.count > 0 ? uSelf.firChildren.first?.iSele ?? false : (filtrates?.first ?? FiltrateModel.init()).iSele , _iSmage: true))
                            }else {
                                
                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: ((region as! CustorData).iSele ) ? (region as! CustorData).name ?? "区域" : "区域" , _filType: .region ,_iSele: ((region as! CustorData).iSele ), _iSmage: true))
                            }
                        }else{
                            (region as! CustorData).iSele = false
                        }
                        regions.append((region as! CustorData))
                    }
                    uSelf.filChildren.removeAll()
                    user.filtrateAlerData.regionList =  regions
                }

                if filtrates?.count == 2 {
                    
                    var  regions:[CustorData] = []
    
                    let regionsArr:NSMutableArray = NSMutableArray.init()
    
    
                    user.filtrateAlerData.regionList?.forEach({ regionList in
                        (regionList as CustorData).children?.forEach({ children in
                            children.iSele = false
                        })
                    })
    
                    user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children?.forEach({ region in
                        regionsArr.add(region)
                    })
    
                    for (inx,region) in regionsArr.enumerated() {
                        if inx == indexPath.row  {
                            (region as! CustorData).iSele = true

                            uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: ((region as! CustorData).iSele) ? (region as! CustorData).name ?? "区域" : "区域" , _filType: .region ,_iSele: ((region as! CustorData).iSele), _iSmage: true))
                        }else{
                            (region as! CustorData).iSele = false
                        }
    
                        regions.append((region as! CustorData))
                    }
    
                    user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children =  regions
                                    
                }
                
                if filtrates?.count == 3 {
                    
                let model =  filtrates?.last ?? FiltrateModel.init()
                    
                    if model.type == .cen {
                        
                        var  regions:[CustorData] = []
        
                        let regionsArr:NSMutableArray = NSMutableArray.init()
        
                        user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children?.forEach({ region in
                            if region.iSele == true {
                                uSelf.filChildren.append((region ))
                            }
                        })
                        user.filtrateAlerData.regionList?.forEach({ regionList in
                            (regionList as CustorData).children?.forEach({ children in
                                children.iSele = false
                            })
                        })
        
                        user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children?.forEach({ region in
                            regionsArr.add(region)
                        })
        
                        for (inx,region) in regionsArr.enumerated() {
                            if inx == indexPath.row  {
                                
                                if  (region as! CustorData).iSele == false{
                                    (region as! CustorData).iSele = true
                                    
                                    if uSelf.filChildren.count == 0 {
                                        uSelf.filChildren.append((region as! CustorData))
                                    }else {
                                        if  !uSelf.filChildren.contains(where: { $0.code == (region as! CustorData).code }) {
                                            uSelf.filChildren.append((region as! CustorData))
                                        }else{
                                            let children:NSMutableArray = NSMutableArray.init()
                                            uSelf.filChildren.forEach { c in
                                                children.add(c)
                                            }
                                            uSelf.filChildren.removeAll()
                                            for (idx,itam) in children.enumerated() {
                                                if (itam as! CustorData ).name  == (region as! CustorData).name  {
                                                    children.remove((itam as! CustorData ))
                                                }else{
                                                    uSelf.filChildren.append((itam as! CustorData ))
                                                }
                                            }
                                            
                                            if !uSelf.filChildren.contains(where: { $0.code == (region as! CustorData).code }) {
                                                (region as! CustorData).iSele = false
                                            }else{
                                                (region as! CustorData).iSele = true
                                            }
                                        }
                                    }
                                   
                                }
                                
                                if uSelf.filChildren.count > 1 {
                                      
                                    var hchildren:Array<CustorData> = []
                                    
                                    uSelf.filChildren.forEach { children in
                                        if !hchildren.contains(where: { $0.code == children.code }) {
                                            hchildren.append(children)
                                        }
                                    }
                                    uSelf.filChildren = hchildren
                                    
                                    uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: "多选(\(uSelf.filChildren.count ))" , _filType: .region ,_iSele: ((region as! CustorData).iSele ), _iSmage: true))
                                }else{
                                    uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: uSelf.filChildren.count > 0 ? uSelf.filChildren.first?.name ?? "区域" : (filtrates?.first ?? FiltrateModel.init()).title ?? "区域" , _filType: .region ,_iSele: uSelf.filChildren.count > 0 ? uSelf.filChildren.first?.iSele ?? false : (filtrates?.first ?? FiltrateModel.init()).iSele , _iSmage: true))
                                }

                            }else{
                                if uSelf.filChildren.contains(where: { $0.code == (region as! CustorData).code }) {
                                    (region as! CustorData).iSele = !((region as! CustorData).iSele )
                                }else{
                                    (region as! CustorData).iSele = false
                                }
                            }
        
                            regions.append((region as! CustorData))
                        }
        
                        user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children =  regions
                        
                    }else if model.type == .right{
                        
                        var  regions:[CustorData] = []
        
                        let regionsArr:NSMutableArray = NSMutableArray.init()
        
                        user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children?[indexPath.row].children?.forEach({ region in
                            regionsArr.add(region)
                        })
                       
                        for (inx,region) in regionsArr.enumerated() {
                            
                            if inx == indexPath.row  {
                                (region as! CustorData).iSele = model.iSele

                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: ((region as! CustorData).iSele ) ? (region as! CustorData).name ?? "区域" : "区域" , _filType: .region ,_iSele: ((region as! CustorData).iSele ), _iSmage: true))
                            }
                            regions.append((region as! CustorData))
                        }
                        user.filtrateAlerData.regionList?[ uSelf.filtrateIndexPath.row - 1].children?[indexPath.row].children =  regions
                    }
                }
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
            if uSelf.filTypeAler == .price {
                let model:EntryModel =  uSelf.filtrateAlerView.groups[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init()
                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "价格"  , _filType: .price ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                
                var  prices:[CustorData] = []
                
                let priceArr:NSMutableArray = NSMutableArray.init()
                
                if (user.filtrateAlerData.totalPriceList?.count ?? 0) > 0  {
            
                    user.filtrateAlerData.totalPriceList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.totalPriceList = prices
                    
                }else if (user.filtrateAlerData.unitPriceList?.count ?? 0) > 0  {
                    
                    user.filtrateAlerData.totalPriceList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.totalPriceList = prices
                }
            }
            
            if uSelf.filTypeAler == .houseType || uSelf.filTypeAler == .none || uSelf.filTypeAler == .more{
                
                if uSelf.filTypeAler == .houseType {
                    let model:EntryModel =  uSelf.filtrateAlerView.groups[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init()
    
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    
                    if (user.filtrateAlerData.houseTypeList?.count ?? 0) > 0  {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "户型"  , _filType: .houseType ,_iSele: true, _iSmage: true))
                        
                        var  prices:[CustorData] = []
                        
                        user.filtrateAlerData.houseTypeList?.forEach({ total in
                            priceArr.add(total)
                        })
                        for (inx,itam) in priceArr.enumerated() {
                            if inx == index?.row ?? 0 {
                                (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            }else{
                                (itam as! CustorData).iSele = false
                            }
                            
                            prices.append(itam as! CustorData)
                        }
                        user.filtrateAlerData.houseTypeList = prices
                    }
                }
                
                if uSelf.filTypeAler == .none {
                    let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()
                    uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "房龄"  , _filType: .none ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                    
                    var  prices:[CustorData] = []
                    
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    
                    if (user.filtrateAlerData.houseAgeList?.count ?? 0) > 0  {
                
                        user.filtrateAlerData.houseAgeList?.forEach({ total in
                            priceArr.add(total)
                        })
                        for (inx,itam) in priceArr.enumerated() {
                            if inx == index?.row ?? 0 {
                                (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            }else{
                                (itam as! CustorData).iSele =  false
                            }
                            if (itam as! CustorData).iSele == true {
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "房龄"  , _filType: .none ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                            }
                            prices.append(itam as! CustorData)
                        }
                        user.filtrateAlerData.houseAgeList = prices
                    }
                    
                }

                if uSelf.filTypeAler == .more {
                    let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()
    
                    uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多"  , _filType: .more ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                    if model.title == "建筑面积选择"  {
                        var  arealist:[CustorData] = []
                        
                        let areaArr:NSMutableArray = NSMutableArray.init()
                                                
                        if (user.filtrateAlerData.buildAreaList?.count ?? 0) > 0  {
                    
                            user.filtrateAlerData.buildAreaList?.forEach({ total in
                                areaArr.add(total)
                            })
                            for (inx,itam) in areaArr.enumerated() {
                                if inx == index?.row ?? 0 {
                                    (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                                    uSelf.fchildren.append(itam as! CustorData)
                                }else{
                                    (itam as! CustorData).iSele = false
                                }
                                arealist.append(itam as! CustorData)
                                if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                    if (itam as! CustorData).iSele == false {
                                        for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                  }
                                }
                            }
                            
                            if uSelf.fchildren.count > 1 {
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else  if uSelf.fchildren.count == 1{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "建筑面积"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                            }
                            user.filtrateAlerData.buildAreaList = arealist
                        }
                        
                        if (user.fixturesAlerData.areaList?.count ?? 0) > 0  {
                            
                            user.fixturesAlerData.areaList?.forEach({ total in
                                areaArr.add(total)
                            })
                            for (inx,itam) in areaArr.enumerated() {
                                if inx == index?.row ?? 0 {
                                    (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                                    uSelf.fchildren.append(itam as! CustorData)
                                }else{
                                    (itam as! CustorData).iSele = false
                                }
                                arealist.append(itam as! CustorData)
                                if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                    if (itam as! CustorData).iSele == false {
                                        for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                  }
                                }
                            }
                            
                            if uSelf.fchildren.count > 1 {
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else  if uSelf.fchildren.count == 1{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "建筑面积"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                            }
                            user.fixturesAlerData.areaList = arealist
                        }
                    }
        
                    if model.title == "开盘时间"  {
                        var  arealist:[CustorData] = []
                        
                        let areaArr:NSMutableArray = NSMutableArray.init()
                        user.filtrateAlerData.openDateList?.forEach({ total in
                            areaArr.add(total)
                        })
                        for (inx,itam) in areaArr.enumerated() {
                            if inx == index?.row ?? 0 {
                                (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                                uSelf.fchildren.append(itam as! CustorData)
                            }else{
                                (itam as! CustorData).iSele = false
                            }
                            arealist.append(itam as! CustorData)
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                    if it.label == (itam as! CustorData).label {
                                        uSelf.fchildren.remove(at: ix)
                                    }
                                }
                              }
                            }
                        }
                        
                        if uSelf.fchildren.count > 1 {
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                        }else  if uSelf.fchildren.count == 1{
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "开盘时间"  , _filType: .more ,_iSele: true, _iSmage: true))
                        }else{
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                        }
                        user.filtrateAlerData.openDateList = arealist
                    }
                    
                    if model.title == "房源特色" {
                        var  arealist:[CustorData] = []
                        
                        let areaArr:NSMutableArray = NSMutableArray.init()
                        
                        if (user.filtrateAlerData.featureList?.count ?? 0) > 0  {
                    
                            user.filtrateAlerData.featureList?.forEach({ total in
                                areaArr.add(total)
                            })
                            for (inx,itam) in areaArr.enumerated() {
                                if inx == index?.row ?? 0 {
                                    (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                                    uSelf.fchildren.append(itam as! CustorData)
                                }else{
                                    (itam as! CustorData).iSele = false
                                }
                                arealist.append(itam as! CustorData)
                                if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                    if (itam as! CustorData).iSele == false {
                                        for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                  }
                                }
                            }
                            
                            if uSelf.fchildren.count > 1 {
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else  if uSelf.fchildren.count == 1{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "房源特色"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                            }
                            user.filtrateAlerData.featureList = arealist
                            
                        }else{
                         
                            user.filtrateAlerData.labelList?.forEach({ total in
                                areaArr.add(total)
                            })
                            for (inx,itam) in areaArr.enumerated() {
                                if inx == index?.row ?? 0 {
                                    (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                                    uSelf.fchildren.append(itam as! CustorData)
                                }else{
                                    (itam as! CustorData).iSele = false
                                }
                                arealist.append(itam as! CustorData)
                                if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                    if (itam as! CustorData).iSele == false {
                                        for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                  }
                                }
                            }
                            
                            if uSelf.fchildren.count > 1 {
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else  if uSelf.fchildren.count == 1{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "房源特色"  , _filType: .more ,_iSele: true, _iSmage: true))
                            }else{
                                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                            }
                            user.filtrateAlerData.labelList = arealist
                        }
                    
                    }
                    
                }
                
            }
            
            if uSelf.filTypeAler == .sort {
                let model:FiltrateModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as! FiltrateModel
                
                if model.code == "10086" {
                    uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: indexPath?.section == 0 ? "排序" : model.title ?? "" , _filType:.sort  ,_iSele: false, _iSmage: true))
                }else{
                    uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: indexPath?.section == 0 ? "排序" : model.title ?? "" , _filType:.sort  ,_iSele: true, _iSmage: true))
                }
                var  prices:[CustorData] = []
                
                let priceArr:NSMutableArray = NSMutableArray.init()
                
                if (user.filtrateAlerData.sort?.count ?? 0) > 0  {
            
                    user.filtrateAlerData.sort?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.section ?? 0 {
                            (itam as! CustorData).iSele = true
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.sort = prices
                } else  if (user.filtrateAlerData.sortList?.count ?? 0) > 0  {
            
                    user.filtrateAlerData.sortList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.section ?? 0 {
                            (itam as! CustorData).iSele = !((itam as! CustorData).iSele )
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.sortList = prices
                    
                }else  if (user.fixturesAlerData.sortList?.count ?? 0) > 0  {
                    var  prices:[CustorData] = []
                    user.fixturesAlerData.sortList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.section ?? 0 {
                            (itam as! CustorData).iSele = !((itam as! CustorData).iSele )
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.fixturesAlerData.sortList = prices
                    
                }else  if (user.fixturesAlerData.typeList?.count ?? 0) > 0  {
                    var  prices:[CustorData] = []
                    user.fixturesAlerData.typeList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.section ?? 0 {
                            (itam as! CustorData).iSele = !((itam as! CustorData).iSele )
                        }else{
                            (itam as! CustorData).iSele = false
                        }
                        
                        prices.append(itam as! CustorData)
                    }
                    user.fixturesAlerData.typeList = prices
                }
            }
        }
        
        filtrateAlerView.returnTagSetBlock { [weak self] ( indexPath, index, groupsele) in
            guard let uSelf = self  else { return }
            if uSelf.returnTagSetAction != nil {
                uSelf.returnTagSetAction!(indexPath, index,groupsele)
            }
            
            if uSelf.filTypeAler == .none {
                
                let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()
                
                if (user.fixturesAlerData.priceList?.count ?? 0) > 0  {
                    
                    var fchildren:Array<CustorData> = []
                    
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.fixturesAlerData.priceList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            
                            if fchildren.contains(where: { $0.dicDataCode == (itam as! CustorData).dicDataCode }) {
                                if (itam as! CustorData).iSele == false {
                                    fchildren.remove(at: inx)
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            
                            fchildren.append(itam as! CustorData)
                        
                        }
                        prices.append(itam as! CustorData)
                    }
                    
                    if fchildren.count > 0 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .none ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "费用"  , _filType: .none ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                    }
                    user.fixturesAlerData.priceList = prices
                    
                    return
                }
            }
            
            if uSelf.filTypeAler == .houseType {

                let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()
                
                if (user.fixturesAlerData.styleList?.count ?? 0) > 0  {
                    
                    var fchildren:Array<CustorData> = []
        
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.fixturesAlerData.styleList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            
                            if fchildren.contains(where: { $0.dicDataCode == (itam as! CustorData).dicDataCode }) {
                                if (itam as! CustorData).iSele == false {
                                    fchildren.remove(at: inx)
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            
                            fchildren.append(itam as! CustorData)
                        }
                
                        prices.append(itam as! CustorData)
                    }
                    
                    if fchildren.count > 0 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .houseType ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : "风格"  , _filType: .houseType ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele, _iSmage: true))
                    }
                    user.fixturesAlerData.styleList = prices
                    return
                }
                uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "户型"  , _filType: .houseType ,_iSele: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? true : false , _iSmage: true))
                
                var  beds:[CustorData] = []
                
                let bedArr:NSMutableArray = NSMutableArray.init()
                
                if (user.filtrateAlerData.layoutBedroomList?.count ?? 0) > 0   {
            
                    user.filtrateAlerData.layoutBedroomList?.forEach({ total in
                        bedArr.add(total)
                    })
                    for (inx,itam) in bedArr.enumerated() {
                        if inx == index?.row ?? 0 && indexPath?.section == 0  {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        }else{
                            (itam as! CustorData).iSele = (itam as! CustorData).iSele
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "户型"  , _filType: .houseType ,_iSele:  true , _iSmage: true))
                        }
                        beds.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.layoutBedroomList = beds
                    
                }
                
                var  hals:[CustorData] = []
                
                let halArr:NSMutableArray = NSMutableArray.init()
                
                if (user.filtrateAlerData.layoutHallList?.count ?? 0) > 0  {
            
                    user.filtrateAlerData.layoutHallList?.forEach({ total in
                        halArr.add(total)
                    })
                    for (inx,itam) in halArr.enumerated() {
                        if inx == index?.row ?? 0  && indexPath?.section == 1 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        }else{
                            (itam as! CustorData).iSele = (itam as! CustorData).iSele
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "户型"  , _filType: .houseType ,_iSele:  true , _iSmage: true))
                        }
                        hals.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.layoutHallList = hals
                    
                }
                
                var  ltls:[CustorData] = []
                
                let ltlsArr:NSMutableArray = NSMutableArray.init()
                
                if (user.filtrateAlerData.layoutToiletList?.count ?? 0) > 0  {
            
                    user.filtrateAlerData.layoutToiletList?.forEach({ total in
                        ltlsArr.add(total)
                    })
                    for (inx,itam) in ltlsArr.enumerated() {
                        if inx == index?.row ?? 0 && indexPath?.section == 2 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        }else{
                            (itam as! CustorData).iSele = (itam as! CustorData).iSele
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "户型"  , _filType: .houseType ,_iSele:  true , _iSmage: true))
                        }
                        ltls.append(itam as! CustorData)
                    }
                    user.filtrateAlerData.layoutToiletList = ltls
                    
                }
            }
            
            if uSelf.filTypeAler == .more {
                let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()
                
                if (user.fixturesAlerData.areaList?.count ?? 0) > 0  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.fixturesAlerData.areaList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.dicDataCode == (itam as! CustorData).dicDataCode }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.dicDataName == (itam as! CustorData).dicDataName {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "销售状态"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.data?.saleStatusScreenList = prices
                    
                    return
                }

                if (user.filtrateAlerData.buildAreaList?.count ?? 0) > 0  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.buildAreaList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "建筑面积选择"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.buildAreaList = prices
                    
                    return
                }
                
                if (user.filtrateAlerData.orientationList?.count ?? 0) > 0  && model.title == "房源朝向"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.orientationList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "房源朝向"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.orientationList = prices
                    
                    return
                }
                
                if (user.filtrateAlerData.floorList?.count ?? 0) > 0  && model.title == "房源朝向"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.floorList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "房源楼层" , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.floorList = prices
                    
                    return
                }
                
                if (user.filtrateAlerData.finishList?.count ?? 0) > 0  && model.title == "房源装修"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.finishList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "房源装修" , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.finishList = prices
                    
                    return
                }
                
                if (user.filtrateAlerData.houseTypeList?.count ?? 0) > 0  && model.title == "类型"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.houseTypeList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "类型" , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.houseTypeList = prices
                    
                    return
                }

                if (user.filtrateAlerData.saleStatusList?.count ?? 0) > 0  && model.title == "销售状态"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.saleStatusList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "销售状态" , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.saleStatusList = prices
                    
                    return
                }
                
                if (user.filtrateAlerData.finishList?.count ?? 0) > 0  && model.title == "装修状况"  {
                    var  prices:[CustorData] = []
                    let priceArr:NSMutableArray = NSMutableArray.init()
                    user.filtrateAlerData.finishList?.forEach({ total in
                        priceArr.add(total)
                    })
                    for (inx,itam) in priceArr.enumerated() {
                        if inx == index?.row ?? 0 {
                            (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                            if uSelf.fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                                if (itam as! CustorData).iSele == false {
                                    for (ix,it) in uSelf.fchildren.enumerated() {
                                        if it.label == (itam as! CustorData).label {
                                            uSelf.fchildren.remove(at: ix)
                                        }
                                    }
                                }
                            }
                        }
                        if (itam as! CustorData).iSele == true {
                            uSelf.fchildren.append(itam as! CustorData)
                        }
                        prices.append(itam as! CustorData)
                    }
          
                    if uSelf.fchildren.count > 1 {
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: .more ,_iSele: true, _iSmage: true))
                    }else  if uSelf.fchildren.count == 1{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? "装修状况" , _filType: .more ,_iSele: true, _iSmage: true))
                    }else{
                        uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "更多" , _filType: .more ,_iSele: false, _iSmage: true))
                    }
                    user.filtrateAlerData.finishList = prices
                    
                    return
                }
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(lineV)
        lineV.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset((-kRPRealValue(0.5)))
            make.height.equalTo(kRPRealValue(0.5))
        }
    }
    
    @objc func dismissView(){
        
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
        func showInWindow(){
            
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
                make.top.equalToSuperview().offset(kRPRealValue(-1))
            }
           
            botView.snp.remakeConstraints { make in
                make.bottom.left.right.equalToSuperview().offset(0)
                make.top.equalTo(filtrateAlerView.snp_bottom).offset(0)
            }
        
            self.bgView.snp.remakeConstraints { make in
                make.left.bottom.right.equalToSuperview().offset(0)
                make.top.equalTo(kRPRealValue(CGFloat((IS_IPHONE_5_OR_LESS ? 50 : IS_IPHONE_X_SERIES ? 50 : 40) + kStatusBarHeightXSwift) + topHeight) )
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
