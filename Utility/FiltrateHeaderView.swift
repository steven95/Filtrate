//
//  FiltrateHeaderView.swift
//  JuYao
//
//  Created by 挖坑小能手 on 2023/2/17.
//

import Foundation
import UIKit
import JXSegmentedView

class FiltrateHeaderView: UIView {
     var _groups:NSMutableArray = [FiltrateModel.init(_title: "区域", _filType: .region ),FiltrateModel.init(_title: "价格", _filType: .priceMore ),FiltrateModel.init(_title: "户型", _filType: .houseType ),FiltrateModel.init(_title: "更多", _filType: .more ),FiltrateModel.init(_title: "排序", _filType: .sort )]
    public   var  groups:NSMutableArray { //FiltrateModel
          get {
              return _groups
          }
          set {
              _groups = newValue
          }
    }
    
     var _type:Int = 0
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
      var returnTagAction: ( (_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?) -> Void)?
    
    open func returnTagSetBlock(_ callback: @escaping(_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
      var returnTagSetAction: ( (_ filTypeAler: FilTypeAler?,_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void)?
    
    open func returnPriceBlock(_ callback: @escaping(_ filTypeAler: FilTypeAler?,_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
      var returnPriceAction: ( (_ filTypeAler: FilTypeAler?,_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnReSetAction = callback
    }
    var returnReSetAction: ( (@convention(block) () -> Void))?
    
    open lazy var filtrateTotView : FiltrateTopView = {
        let filtrateTotView = FiltrateTopView.init(frame: CGRect.zero)
        filtrateTotView.lineV.isHidden = true
        
        filtrateTotView.returnReSetBlock { [weak self] (filtrateGroups) in
            guard let uSelf = self  else { return }
            if uSelf.returnReSetAction != nil {
                uSelf.returnReSetAction!()
            }
            uSelf.groups = filtrateGroups.mutableCopy() as! NSMutableArray
        }
        return filtrateTotView
    }()
    
     var _lfiltrates:[FiltrateModel] = []
    public   var  lfiltrates:[FiltrateModel] {
          get {
              return _lfiltrates
          }
          set {
              _lfiltrates = newValue
              
          }
    }
   
     var _rfiltrates:[[[FiltrateModel]]] = []
    public   var  rfiltrates:[[[FiltrateModel]]]{
          get {
              return _rfiltrates
          }
          set {
              _rfiltrates = newValue
              
          }
    }
    
     var _cfiltrates:[[FiltrateModel]] = []
    public   var  cfiltrates:[[FiltrateModel]]{
          get {
              return _cfiltrates
          }
          set {
              _cfiltrates = newValue
              
          }
    }
    
     var _groupStrs:[String] = []
    public   var  groupStrs:[String]{
          get {
              return _groupStrs
          }
          set {
              _groupStrs = newValue
              
          }
    }
    
     var _groupPaths:[JIndexPath] = []
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
        entryTagView.font = kRPRealValue(12)
        entryTagView.flowLayout.itemSize = CGSize.init(width: kRPRealValue(75), height: kRPRealValue(30))
        entryTagView.flowLayout.minimumInteritemSpacing = kRPRealValue(10)
        entryTagView.backgroundColor = .clear
        return entryTagView
    }()
    
    enum HouseType: Int {
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
                make.height.equalTo(kRPRealValue(70))
                make.bottom.equalToSuperview().offset(kRPRealValue(10))
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
                make.height.equalTo(kRPRealValue(40))
            }
            entryTagView.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview().offset(0)
                make.top.equalTo(filtrateTotView.snp_bottom).offset(0)
            }
        }
        filtrateTotView.groups = groups
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .COLORFFFFFF
        self.addSubview(entryTagView)
        self.addSubview(filtrateTotView)
        entryTagView.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.height.equalTo(kRPRealValue(70))
        }
        filtrateTotView.snp.remakeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(kRPRealValue(40))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FiltrateTopView: UIView {
    var findex: IndexPath =  IndexPath.init(row: 0, section: 0)
    open var filtrateGroups:NSMutableArray = []
     var _groups:NSMutableArray = []
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
    
     var _topHeight:CGFloat = 0
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
      var returnRegionAction: ((_ indexPath:IndexPath,_ filtrates: Array<FiltrateModel>?) -> Void)?
    
    open func returnTagBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void) {
        returnTagAction = callback
    }
      var returnTagAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void))?
    
    
    open func returnTagSetBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
      var returnTagSetAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void))?
    
    open func returnPriceBlock(_ callback: @escaping(_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
      var returnPriceAction: ( (_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) (NSMutableArray) -> Void) {
        returnReSetAction = callback
    }
    var returnReSetAction: ( (@convention(block) (NSMutableArray) -> Void))?
    
    var filtrates:Array<FiltrateModel> = []
    
    var filtrateIndexPath : IndexPath = IndexPath.init()
    
    var dismissIndexPath : IndexPath = IndexPath.init()
    
    
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

                    user.validRegionData.data?.forEach({ region in
                        regionsArr.add(region)
                    })
                    uSelf.firChildren.removeAll()
                    user.validRegionData.data?.forEach({ regionList in
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
                    user.validRegionData.data =  regions
                }
    
         if filtrates?.count == 3 {
                let model =  filtrates?.last ?? FiltrateModel.init()
                if model.type == .right{
                    var  regions:[CustorData] = []
                    var  regionSele:[CustorData] = []
                    let regionsArr:NSMutableArray = NSMutableArray.init()
                    user.validRegionData.data?[ uSelf.filtrateIndexPath.row - 1].children?.forEach({ region in
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
                            }
                         }
                        regions.append((region as! CustorData))
                     }
                   
                    uSelf.groups.replaceObject(at: 0, with: FiltrateModel.init(_title:regionSele.count > 1 ?  "多选" : regionSele.count == 1 ? regionSele.first?.name ?? "区域" : "区域" , _filType: .region ,_iSele: regionSele.first?.iSele ?? false, _iSmage: true))
                    
                    user.validRegionData.data?[ uSelf.filtrateIndexPath.row - 1].children =  regions
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
    
    
    func sortSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?) ->  [CustorData]  {
        let model:FiltrateModel =  filtrateAlerView.array[indexPath?.section ?? 0] as! FiltrateModel
        
        if model.code == "10086" {
            groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: indexPath?.section == 0 ? title : model.title ?? "" , _filType:.sort  ,_iSele: false, _iSmage: true))
        }else{
            groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: indexPath?.section == 0 ? title : model.title ?? "" , _filType:.sort  ,_iSele: true, _iSmage: true))
        }
        var  prices:[CustorData] = []
        
        let priceArr:NSMutableArray = NSMutableArray.init()
        
        if (Custors?.count ?? 0 ) > 0  {
    
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
    
//    filType != more
    func singleSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?) ->  [CustorData] {
        let model:EntryModel = (filType == .houseType || filType == .more || filType == .sort) ? filtrateAlerView.array[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init() : filtrateAlerView.groups[indexPath?.row ?? 0] as? EntryModel ?? EntryModel.init()

        let priceArr:NSMutableArray = NSMutableArray.init()
        
        if (Custors?.count ?? 0) > 0  {
            groups.replaceObject(at: filIndex, with: FiltrateModel.init(_title: !(model.groups?[index?.row ?? 0] as! EntryTag).iSele ? (model.groups?[index?.row ?? 0] as! EntryTag).title! : title  , _filType: filType ,_iSele: true, _iSmage: true))
            
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
    func moreSele(_ indexPath: IndexPath?,_ index: IndexPath?,title:String,filType:FilTypeAler,Custors:[CustorData]?,isMore:Bool) ->  [CustorData] {
        
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
            
            var result:[CustorData] = []
            for value in fchildren {
                if !result.contains(where: { $0.code == (value).code }){
                    result.append(value)
                }
            }
            fchildren = result
            
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
      var filtrateAction: ( (@convention(block) () -> Void))?
    
    
    open func dismissBlock(_ callback: @escaping @convention(block) () -> Void) {
        dismissAction = callback
    }
    open  var dismissAction: ( (@convention(block) () -> Void))?
    
    open func returnBlock(_ callback: @escaping(_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void) {
        returnAction = callback
    }
      var returnAction: ( (_ filtrateModel:FiltrateModel, _ filTypeAler: FilTypeAler?,_ isSele: Bool?) -> Void)?
    
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
           
        
            self.bgView.snp.remakeConstraints { make in
                make.left.bottom.right.equalToSuperview().offset(0)
                make.top.equalTo(kRPRealValue(CGFloat((IS_IPHONE_5_OR_LESS ? 50 : IS_IPHONE_X_SERIES ? 50 : 40) + kStatusBarHeightXSwift) + topHeight) )
            }
            
            filtrateAlerView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                if self.bgView.jheight == 0 {
                    make.height.equalTo(filtrateAlerView.filtrateAlerViewHeight())
                }else if filtrateAlerView.filtrateAlerViewHeight() < self.bgView.jheight {
                    make.height.equalTo(filtrateAlerView.filtrateAlerViewHeight())
                }else{
                    make.bottom.equalToSuperview().offset(0)
                }
                make.top.equalToSuperview().offset(kRPRealValue(-1))
            }
           
            botView.snp.remakeConstraints { make in
                make.bottom.left.right.equalToSuperview().offset(0)
                make.top.equalTo(filtrateAlerView.snp_bottom).offset(0)
            }
            
            UIView.animate(withDuration: 0.25, animations: { [self] in
                self.filtrateAlerView.layoutIfNeeded()
                self.filtrateAlerView.isReSet = false
                self.botView.layoutIfNeeded()
                self.bgView.layoutIfNeeded()
                self.bgView.alpha = 1
            }, completion: nil)
        }
         
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
