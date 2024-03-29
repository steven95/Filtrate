//
//  FiltrateHeaderView.swift
//  JuYao
//
//  Created by 挖坑小能手 on 2023/2/17.
//

import Foundation
import UIKit
import JXSegmentedView

func FRPRealValue(_ value: CGFloat) -> CGFloat {
    return (UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height / CGFloat(375.0)) * value
}

func FSHexColor(Hex:NSInteger,alpha:CGFloat) -> UIColor {
    return UIColor(red:((CGFloat)((Hex & 0xFF0000) >> 16))/255.0,green:((CGFloat)((Hex & 0xFF00) >> 8))/255.0,blue:((CGFloat)(Hex & 0xFF))/255.0,alpha:alpha)
}

public enum RegionType: Int {
    case normal
    case more
}

open class FiltrateHeaderView: UIView {
    
    private var _regionType:RegionType = .more
    public   var  regionType:RegionType {
        get {
            return _regionType
        }
        set {
            _regionType = newValue
        }
    }
    
    open var _groups:NSMutableArray = [FiltrateModel.init(_title: "区域", _filType: .region ),FiltrateModel.init(_title: "价格", _filType: .priceMore ),FiltrateModel.init(_title: "户型", _filType: .houseType ),FiltrateModel.init(_title: "更多", _filType: .more ),FiltrateModel.init(_title: "排序", _filType: .sort )]
    public   var  groups:NSMutableArray { //FiltrateModel
          get {
              return _groups
          }
          set {
              _groups = newValue
          }
    }
    
    open var _type:Int = 0
    public   var  type:Int {
          get {
              return _type
          }
          set {
              _type = newValue
              filtrateTotView.filtrateAlerView.type = newValue
          }
    }
    
    open func returnTagBlock(_ callback: @escaping(_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?) -> Void) {
        returnTagAction = callback
    }
    open var returnTagAction: ( (_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?) -> Void)?
    
    open func returnTagSetBlock(_ callback: @escaping(_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
    open var returnTagSetAction: ( (_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void)?
    
    open func returnPriceBlock(_ callback: @escaping(_ filTypeAler: FilTypeAler?,_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
    
    open var returnPriceAction: ( (_ filTypeAler: FilTypeAler?,_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnReSetAction = callback
    }
    open var returnReSetAction: ( (@convention(block) () -> Void))?
    
    open lazy var filtrateTotView : FiltrateTopView = {
        let filtrateTotView = FiltrateTopView.init(frame: CGRect.zero)
        filtrateTotView.lineV.isHidden = true
        filtrateTotView.regionType = regionType
        filtrateTotView.returnReSetBlock { [weak self] (filtrateGroups) in
            guard let uSelf = self  else { return }
            if uSelf.returnReSetAction != nil {
                uSelf.returnReSetAction!()
            }
            uSelf.groups = filtrateGroups.mutableCopy() as! NSMutableArray
        }
        return filtrateTotView
    }()
    
    open var _lfiltrates:[FiltrateModel] = []
    public   var  lfiltrates:[FiltrateModel] {
          get {
              return _lfiltrates
          }
          set {
              _lfiltrates = newValue
              
          }
    }
   
    open var _rfiltrates:[[[FiltrateModel]]] = []
    public   var  rfiltrates:[[[FiltrateModel]]]{
          get {
              return _rfiltrates
          }
          set {
              _rfiltrates = newValue
              
          }
    }
    
    open var _cfiltrates:[[FiltrateModel]] = []
    public   var  cfiltrates:[[FiltrateModel]]{
          get {
              return _cfiltrates
          }
          set {
              _cfiltrates = newValue
              
          }
    }
    
    open var _groupStrs:[String] = []
    public   var  groupStrs:[String]{
          get {
              return _groupStrs
          }
          set {
              _groupStrs = newValue
              
          }
    }
    
    open var _groupPaths:[JIndexPath] = []
    public   var  groupPaths:[JIndexPath]{
          get {
              return _groupPaths
          }
          set {
              _groupPaths = newValue
             
          }
    }

    var foldModel = FoldModel.init()
    
    open lazy var entryTagView : EntryTagView = {
        let entryTagView = EntryTagView.init()
        entryTagView.lineV.isHidden = true
        entryTagView.tagType = .normal
        entryTagView.type = 0
        entryTagView.font = FRPRealValue(12)
        entryTagView.flowLayout.itemSize = CGSize.init(width: FRPRealValue(75), height: FRPRealValue(30))
        entryTagView.flowLayout.minimumInteritemSpacing = FRPRealValue(10)
        entryTagView.backgroundColor = .clear
        return entryTagView
    }()
    
   public enum HouseType: Int {
        case normal
        case filtrate
        case more
    }
    
    open func setupUI(houseType: HouseType) {
        switch houseType {
        case .normal:
            filtrateTotView.isHidden = true
            entryTagView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(70))
                make.bottom.equalToSuperview().offset(FRPRealValue(10))
            }
        case .filtrate:
            entryTagView.isHidden = true
            filtrateTotView.isHidden = false
            filtrateTotView.snp.remakeConstraints { make in
                make.bottom.top.left.right.equalToSuperview().offset(0)
            }
        case .more:
            filtrateTotView.isHidden = false
            entryTagView.isHidden = false
            filtrateTotView.snp.remakeConstraints { make in
                make.top.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(40))
            }
            entryTagView.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview().offset(0)
                make.top.equalTo(filtrateTotView.snp_bottom).offset(0)
            }
        }
        filtrateTotView.groups = groups
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        self.addSubview(entryTagView)
        self.addSubview(filtrateTotView)
        entryTagView.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.height.equalTo(FRPRealValue(70))
        }
        filtrateTotView.snp.remakeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(FRPRealValue(40))
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class FiltrateTopView: UIView {
    
    private var _regionType:RegionType = .more
    public   var  regionType:RegionType {
        get {
            return _regionType
        }
        set {
            _regionType = newValue
        }
    }
    
    open var findex: IndexPath =  IndexPath.init(row: 0, section: 0)
    open var filtrateGroups:NSMutableArray = []
    public  var _groups:NSMutableArray = []
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
    
    public var _topHeight:CGFloat = 0
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
    
    open func returnCellPriceBlock(_ callback: @escaping(_ indexPath: IndexPath?,_ type: Int?,_ text: String?) -> Void) {
        returnCellPriceAction = callback
    }
    private  var returnCellPriceAction: ( (_ indexPath: IndexPath?,_ type: Int?,_ text: String?) -> Void)?
    
    open func returnRegionBlock(_ callback: @escaping (_ indexPath:IndexPath,_ filtrates: Array<FiltrateModel>?) -> Void) {
        returnRegionAction = callback
    }
    public  var returnRegionAction: ((_ indexPath:IndexPath,_ filtrates: Array<FiltrateModel>?) -> Void)?
    
    open func returnTagBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void) {
        returnTagAction = callback
    }
    public var returnTagAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void))?

    open func returnTagSetBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
    public  var returnTagSetAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void))?
    
    open func returnPriceBlock(_ callback: @escaping(_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
    public  var returnPriceAction: ( (_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) (NSMutableArray) -> Void) {
        returnReSetAction = callback
    }
    public var returnReSetAction: ( (@convention(block) (NSMutableArray) -> Void))?
    
    public var filtrates:Array<FiltrateModel> = []
    
    public var filtrateIndexPath : IndexPath = IndexPath.init()
    
    public var dismissIndexPath : IndexPath = IndexPath.init()
    
    
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
                
                if filtrates?.count == 1 {
                    
                    uSelf.filtrateIndexPath = indexPath
                    var  regions:[CustorData] = []

                    let regionsArr:NSMutableArray = NSMutableArray.init()

                    filcenter.validRegionData.data?.forEach({ region in
                        regionsArr.add(region)
                    })
                    uSelf.firChildren.removeAll()
                    filcenter.validRegionData.data?.forEach({ regionList in
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

                                var fchildren:Array<CustorData> = []

                                uSelf.firChildren.forEach { children in
                                    if !fchildren.contains(where: { $0.code == children.code }) {
                                        fchildren.append(children)
                                    }
                                }
                                uSelf.firChildren = fchildren

                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: "多选(\(uSelf.firChildren.count ))" , _filType: .region ,_iSele: ((region as! CustorData).iSele ), _iSmage: true))
                            }else if  uSelf.firChildren.count == 1{
                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: uSelf.firChildren.count > 0 ? uSelf.firChildren.first?.name ?? "区域" : (filtrates?.first ?? FiltrateModel.init()).title ?? "区域" , _filType: .region ,_iSele: uSelf.firChildren.count > 0 ? uSelf.firChildren.first?.iSele ?? false : (filtrates?.first ?? FiltrateModel.init()).iSele , _iSmage: true))
                            }else {
                                
                                uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title: ((region as! CustorData).iSele ) ? (region as! CustorData).name ?? "" : "区域" , _filType: .region ,_iSele: ((region as! CustorData).iSele ), _iSmage: true))
                            }
                        }else{
                            (region as! CustorData).iSele = false
                        }
                        regions.append((region as! CustorData))
                    }
                    filcenter.validRegionData.data =  regions
                }
    
         if filtrates?.count == 3 {
                let model =  filtrates?.last ?? FiltrateModel.init()
                if model.type == .right{
                    var  regions:[CustorData] = []
                    var  regionSele:[CustorData] = []
                    let regionsArr:NSMutableArray = NSMutableArray.init()
                    filcenter.validRegionData.data?[ uSelf.filtrateIndexPath.row - 1].children?.forEach({ region in
                        regionsArr.add(region)
                    })
                    for (inx,region) in regionsArr.enumerated() {
                        
                        if (region as! CustorData).iSele {
                            regionSele.append(region as! CustorData)
                        }
                        if inx == indexPath.row  {
                            (region as! CustorData).iSele = model.iSele
                            if regionSele.contains(where: {$0.code != (region as! CustorData).code}) && model.iSele {
                                regionSele.append((region as! CustorData))
                            }else{
                                if uSelf.regionType == .normal {
                                    (region as! CustorData).iSele = false
                                }
                            }
                         }
                        regions.append((region as! CustorData))
                     }
                   
                    uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title:regionSele.count > 1 ?  "多选" : regionSele.count == 1 ? regionSele.first?.name ?? "区域" : "区域" , _filType: .region ,_iSele: regionSele.first?.iSele ?? false, _iSmage: true))
                    
                    filcenter.validRegionData.data?[ uSelf.filtrateIndexPath.row - 1].children =  regions
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
       
        filtrateAlerView.returnPriceBlock { [weak self] (type, text) in
            guard let uSelf = self  else { return }
            if uSelf.returnPriceAction != nil {
                uSelf.returnPriceAction!(type, text)
            }
        }
        
        filtrateAlerView.returnCellPriceBlock { [weak self] (indexPath, type, text) in
            guard let uSelf = self  else { return }
            
            if uSelf.filTypeAler == .more {
                
                /*
                 1. 新建一个 （indexPath, type, text model）类型的集合 单独记录 和 fchildren 一起计数
                 
                 2. 改造 fchildren集合 使得也记录 indexPath  model 等
                 
                 3. 对比两个集合 添加 还是删除 分别在自己哪里操作自己 --》-〉--》 判断计数
                 
                 let model:EntryModel =  uSelf.filtrateAlerView.array[indexPath?.section ?? 0] as? EntryModel ?? EntryModel.init()

                 var title:String = ""
                 if  uSelf.filtrateAlerView.priceView.tf1.text?.length ?? 0 > 0 &&  uSelf.filtrateAlerView.priceView.tf2.text?.length ?? 0 > 0 {
                     title =   (uSelf.filtrateAlerView.priceView.tf1.text ?? "0") + "-" + (uSelf.filtrateAlerView.priceView.tf2.text ?? "0")
                 }else if type == 1 {
                     title = (uSelf.filtrateAlerView.priceView.tf1.text ?? "0") + "以上"
                 }else if type == 2 {
                     title = (uSelf.filtrateAlerView.priceView.tf2.text ?? "0") + "以下"
                 }

                 if uSelf.fchildren.count > 1 {
                     uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: uSelf.filTypeAler ,_iSele: true, _iSmage: true))
                 }else if uSelf.fchildren.count == 1{
                     uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: (uSelf.fchildren.first!).label ?? ""  , _filType: uSelf.filTypeAler ,_iSele: true, _iSmage: true))
                 }else{
                     uSelf.groups.replaceObject(at: uSelf.filIndex, with: FiltrateModel.init(_title: title , _filType: uSelf.filTypeAler ,_iSele: false, _iSmage: true))
                 }
                 
                 */
                
            }

            if uSelf.returnCellPriceAction != nil {
                uSelf.returnCellPriceAction!(indexPath, type, text)
            }
        }

        return filtrateAlerView
    }()
    
    public var filTypeAler: FilTypeAler = FilTypeAler.region
    
    public var filIndex = 0
    
    @objc public  func click_region(btn:UIButton)  {
        
         fchildren.removeAll()
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
            bgView.isHidden = false
            bgView.alpha = 1
        }
        
        let filtrateModel:FiltrateModel = groups[btn.tag] as! FiltrateModel
        filTypeAler = filtrateModel.filType ?? .region
        if returnAction != nil && !bgView.isHidden {
            returnAction!(filtrateModel,filtrateModel.filType,btn.isSelected)
        }
        if filtrateModel.iSmage && !bgView.isHidden {
            showInWindow()
        }
        if bgView.isHidden  {
            bgView.isHidden = false
            bgView.alpha = 1
            if filtrateAction != nil {
                filtrateAction!()
            }
        }
    }
    
    public  func sortSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?) ->  [CustorData]  {
        
        let model:FiltrateModel =  filtrateAlerView.array[indexPath?.section ?? 0] as? FiltrateModel ?? FiltrateModel.init()
        
        var  prices:[CustorData] = []
        
        let priceArr:NSMutableArray = NSMutableArray.init()
        
        if (Custors?.count ?? 0 ) > 0  {
            groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: model.title ?? "排序", _filType: filType, _iSele: true, _iSmage: true))
            
            Custors?.forEach({ total in
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
            return  prices
        }
        return Custors ?? []
    }
    
    public  func singleSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?) ->  [CustorData] {
        let model:EntryModel = (filType == .houseType || filType == .more || filType == .none) ? filtrateAlerView.array[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init() : filtrateAlerView.groups[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init()

        let priceArr:NSMutableArray = NSMutableArray.init()
        
        if (Custors?.count ?? 0) > 0  {
            groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? title : (model.groups?[index?.row ?? 0] as! EntryTag).title! , _filType: filType ,_iSele: true, _iSmage: true))
            
            var  prices:[CustorData] = []
            
            Custors?.forEach({ total in
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
            return  prices
        }
        return Custors ?? []
    }
    
    // filType == more
    public  func moreSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?,isMore:Bool) ->  [CustorData] {
        
        var  lists:[CustorData] = []

        let arrs:NSMutableArray = NSMutableArray.init()

        if (Custors?.count ?? 0) > 0  {

            Custors?.forEach({ total in
                arrs.add(total)
            })
            
            if !isMore{
                for (inx,itam) in arrs.enumerated() {
                    if inx == index?.row ?? 0 {
                        (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        if (itam as! CustorData).iSele {
                            fchildren.append(itam as! CustorData)
                        }
                    }else{
                        (itam as! CustorData).iSele = false
                    }
                    lists.append(itam as! CustorData)
                    if fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                        if (itam as! CustorData).iSele == false {
                            for (ix,it) in fchildren.enumerated() {
                            if it.name == (itam as! CustorData).name {
                                fchildren.remove(at: ix)
                                break
                            }
                        }
                      }
                    }
                }
            }else{
                for (inx,itam) in arrs.enumerated() {
                    if inx == index?.row ?? 0 {
                        (itam as! CustorData).iSele = !(itam as! CustorData).iSele
                        if fchildren.contains(where: { $0.code == (itam as! CustorData).code }) {
                            if (itam as! CustorData).iSele == false {
                                for (ix,it) in fchildren.enumerated() {
                                    if it.name == (itam as! CustorData).name {
                                        fchildren.remove(at: ix)
                                        break
                                    }
                                }
                            }
                        }
                    }
                    if (itam as! CustorData).iSele == true {
                       fchildren.append(itam as! CustorData)
                    }
                    lists.append(itam as! CustorData)
                }
            }
            
            var  childrens:[CustorData] = []
            fchildren.forEach { cd in
                if childrens.count == 0 {
                    childrens.append(cd)
                }else{
                    if childrens.contains(where: { $0.name != cd.name }) {
                        childrens.append(cd)
                    }
                }
            }
            fchildren = childrens
            
            if fchildren.count > 1 {
                groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: "多选"  , _filType: filType ,_iSele: true, _iSmage: true))
            }else  if fchildren.count == 1{
                groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: (fchildren.first!).label ?? ""  , _filType: filType ,_iSele: true, _iSmage: true))
            }else{
                groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: title , _filType: filType ,_iSele: false, _iSmage: true))
            }
           return  lists
        }else{
            return Custors ?? []
        }

    }
    
    open func filtrateBlock(_ callback: @escaping @convention(block) () -> Void) {
        filtrateAction = callback
    }
    public  var filtrateAction: ( (@convention(block) () -> Void))?
    
    
    open func dismissBlock(_ callback: @escaping @convention(block) () -> Void) {
        dismissAction = callback
    }
    open  var dismissAction: ( (@convention(block) () -> Void))?
    
    open func returnBlock(_ callback: @escaping(_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void) {
        returnAction = callback
    }
    
    public  var returnAction: ( (_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void)?
    
    override init(frame: CGRect) {
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
    
    public func showInWindow(){
        
        if filtrateAction != nil {
            filtrateAction!()
        }
        
        UIApplication.shared.keyWindow?.addSubview(bgView)
        bgView.addSubview(filtrateAlerView)
        bgView.addSubview(botView)
        bgView.isHidden = false
       
    
        self.bgView.snp.remakeConstraints { make in
            make.left.bottom.right.equalToSuperview().offset(0)
            make.top.equalTo(FRPRealValue(CGFloat((( UIScreen.main.bounds.size.height <= 667.0) ? 50 : (UIScreen.main.bounds.size.height >= 812.0) ? 50 : 40) +  ((UIScreen.main.bounds.size.height >= 812.0) ? 44 : 20)) + topHeight) )
        }
        
        filtrateAlerView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview().offset(0)
            if self.bgView.jheight == 0 {
                make.height.equalTo(filtrateAlerView.filTypeAler == .time ?  filtrateAlerView.filtrateAlerViewHeight() : filtrateAlerView.filtrateAlerViewHeight())
                filtrateAlerView.tableView.isScrollEnabled = false
            }else if filtrateAlerView.filtrateAlerViewHeight() < self.bgView.jheight {
                make.height.equalTo( filtrateAlerView.filTypeAler == .time ?  filtrateAlerView.filtrateAlerViewHeight() : filtrateAlerView.filtrateAlerViewHeight())
                filtrateAlerView.tableView.isScrollEnabled = false
            }else{
                make.bottom.equalToSuperview().offset(0)
                filtrateAlerView.tableView.isScrollEnabled = true
            }
            make.top.equalToSuperview().offset(FRPRealValue(-1))
        }
       
        botView.snp.remakeConstraints { make in
            make.bottom.left.right.equalToSuperview().offset(0)
            make.top.equalTo(filtrateAlerView.snp_bottom).offset(0)
        }
        
        UIView.animate(withDuration: 0.25, animations: { [self] in
            DispatchQueue.main.async {
                if self.filtrateAlerView.subviews.count > 0 {
                      self.filtrateAlerView.subviews.forEach({$0.layoutIfNeeded()})
                }
                self.filtrateAlerView.layoutIfNeeded()
                self.filtrateAlerView.isReSet = false
                self.botView.layoutIfNeeded()
                self.bgView.layoutIfNeeded()
                self.bgView.alpha = 1
            }
        }, completion: nil)
    }
         
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
