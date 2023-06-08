//
//  FiltrateAlerView.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/1.
//

import Foundation
import UIKit
import JXSegmentedView
import SnapKit

class FiltrateAlerView: UIView {
    
    var filTypeAler:FilTypeAler = FilTypeAler.region
    
    open lazy var filtrateTabview : FiltrateTabview = {
        let filtrateTabview = FiltrateTabview.init(frame: CGRect.zero)
        unowned let uSelf = self
        filtrateTabview.returnBlock { indexPath, filtrates in
            if uSelf.returnRegionAction != nil {
                uSelf.returnRegionAction!(indexPath,filtrates)
            }
        }
        return filtrateTabview
    }()
    
    private var _isReSet:Bool = false
    public   var isReSet:Bool {
        get {
            return _isReSet
        }
        set {
            _isReSet = newValue
        }
    }

    open func returnRegionBlock(_ callback: @escaping ( _ indexPath:IndexPath, _ filtrates: Array<FiltrateModel>?) -> Void) {
        returnRegionAction = callback
    }
    private  var returnRegionAction: ( (_ indexPath:IndexPath, _ filtrates: Array<FiltrateModel>?) -> Void)?
    
    open func returnBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (@convention(block) () -> Void))?
    
    open func returnSegBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnSegAction = callback
    }
    private  var returnSegAction: ( (@convention(block) () -> Void))?
        
    open func returnPriceBlock(_ callback: @escaping(_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
    private  var returnPriceAction: ( (_ type: Int?,_ text: String?) -> Void)?
    
    open func returnCellPriceBlock(_ callback: @escaping(_ indexPath: IndexPath?,_ type: Int?,_ text: String?) -> Void) {
        returnCellPriceAction = callback
    }
    private  var returnCellPriceAction: ( (_ indexPath: IndexPath?,_ type: Int?,_ text: String?) -> Void)?
    
    open func returnReSetBlock(_ callback: @escaping @convention(block) () -> Void) {
        returnReSetAction = callback
    }
    private  var returnReSetAction: ( (@convention(block) () -> Void))?
    
    open func returnBeginCalendarBlock(_ callback: @escaping @convention(block) (_ date:String) -> Void) {
        returnBeginCalendarAction = callback
    }
    private  var returnBeginCalendarAction: ( (@convention(block) (_ date:String) -> Void))?
    
    
    open func returnEndCalendarBlock(_ callback: @escaping @convention(block) (_ date:String) -> Void) {
        returnEndCalendarAction = callback
    }
    private  var returnEndCalendarAction: ( (@convention(block) (_ date:String) -> Void))?
    

    open lazy var filtrateBotView : FiltrateBotView = {
        let filtrateBotView = FiltrateBotView.init(frame: CGRect.zero)
        
        unowned let uSelf = self
        filtrateBotView.returnBlock {
            switch uSelf.filTypeAler {
            case .time:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .region:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .price:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .priceMore:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .houseType:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .more:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .sort:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .none:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
            case .threeRegion:
                if uSelf.returnAction != nil {
                    uSelf.returnAction!()
                }
                break
            }
        }
        
        filtrateBotView.returnReSetBlock {
            
            unowned let uSelf = self
            if uSelf.returnReSetAction != nil {
                uSelf.returnReSetAction!()
            }
        
            switch uSelf.filTypeAler {
                case .time:
                uSelf.entryTagView.reSet()
                uSelf.calendarV.beginLabel.text = "开始时间"
                uSelf.calendarV.endLabel.text = "结束时间"

                case .region:
                uSelf.filtrateTabview.cArray = uSelf.centerArray
                uSelf.filtrateTabview.rArray = uSelf.rightArray
                uSelf.filtrateTabview.lArray = uSelf.leftArray
                uSelf.filtrateTabview.reSet()
                case .price:
                    uSelf.entryTagView.reSet()
                    uSelf.priceView.tf1.text = ""
                    uSelf.priceView.tf2.text = ""
                    uSelf.priceView.tf2.resignFirstResponder()
                    uSelf.priceView.tf1.resignFirstResponder()
                case .priceMore:
                    uSelf.entryTagView.reSet()
                    uSelf.priceView.tf1.text = ""
                    uSelf.priceView.tf2.text = ""
                    uSelf.priceView.tf2.resignFirstResponder()
                    uSelf.priceView.tf1.resignFirstResponder()
                    uSelf.segmentBar.selectItemAt(index: 0)
                case .houseType:
                    uSelf.entryTagView.reSet()
                    uSelf.isReSet = true
                    uSelf.tableView.reloadData()

                case .more:
                    uSelf.entryTagView.reSet()
                    uSelf.isReSet = true
                    uSelf.tableView.reloadData()
                case .sort:
                    uSelf.isReSet = true
                let group :NSMutableArray = []
                    uSelf.array.enumerateObjects { object, index, stop in
                    let obj = (object as! FiltrateModel)
                    if index == 0 {
                       obj.iSele = true
                    }else{
                       obj.iSele = false
                    }
                      group.add(obj)
                    }
                     uSelf.array = group
                     uSelf.tableView.reloadData()
                case .none:
                    uSelf.isReSet = true
                    uSelf.tableView.reloadData()
                case .threeRegion:
                   uSelf.isReSet = true
                   JuAddThreeFiltrate.showThreeFiltrate(lefts: uSelf.lfiltrates, cens: uSelf.cfiltrates, rights: uSelf.rfiltrates, groupStrs: uSelf.groupStrs, groupPaths: uSelf.groupPaths)
                break
            }
        }
        return filtrateBotView
    }()
    
    open lazy var segmentBar:JXSegmentedView = {
        let segmentBar = JXSegmentedView.init(frame: CGRect.zero)
        return segmentBar
    }()
    
    open lazy var segmentedDataSource:JXSegmentedTitleDataSource = {
        let segmentedDataSource = JXSegmentedTitleDataSource()
        return segmentedDataSource
    }()
   
    open lazy var indicator:JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView.init(frame: CGRect.init(x: 0, y: 0, width: FRPRealValue(25), height: FRPRealValue(5)))
//        indicator.indicatorColor = UIColor.COLORF52938
        indicator.lineStyle = .lengthen
        indicator.indicatorWidthIncrement = FRPRealValue(-5)
        indicator.indicatorHeight = FRPRealValue(5)
        return indicator
    }()
    
    private var _type:Int = 0
    public   var  type:Int {
        get {
            return _type
        }
        set {
            _type = newValue
            entryTagView.type = newValue
        }
    }
    
    private var _typeHeight:CGFloat = FRPRealValue(69)
    public   var  typeHeight:CGFloat {
        get {
            return _typeHeight
        }
        set {
            _typeHeight = newValue
        }
    }
    
    open lazy var entryTagView : EntryTagView = {
        let entryTagView = EntryTagView.init()
        entryTagView.lineV.isHidden = true
        entryTagView.tagType = .more
        entryTagView.font = FRPRealValue(14)
        entryTagView.flowLayout.itemSize = CGSize.init(width: FRPRealValue(105), height: FRPRealValue(30))
        entryTagView.backgroundColor = .clear
    
        unowned let uSelf = self
        entryTagView.returnBlock({ indexPath,model  in
            if uSelf.returnTagAction != nil {
                uSelf.returnTagAction!(IndexPath.init(item: 0, section: 0),indexPath)
            }
        })
        
        entryTagView.returnSetBlock { indexPath, groupsele,model  in
            if uSelf.returnTagSetAction != nil {
                uSelf.returnTagSetAction!(IndexPath.init(item: 0, section: 0),indexPath,groupsele)
            }
        }
        
        return entryTagView
    }()
    
    open lazy var priceView : FilTypePriceView = {
        let priceView = FilTypePriceView.init(frame: frame)
        unowned let uSelf = self
        priceView.returnBlock { tf in
            if tf.tag == 1 {
                if uSelf.returnPriceAction != nil {
                    uSelf.returnPriceAction!(tf.tag, tf.text)
                }
            }else{
                if uSelf.returnPriceAction != nil {
                    uSelf.returnPriceAction!(tf.tag, tf.text)
                }
            }
        }
        return priceView
    }()
    
    open lazy var calendarV : JuCalendarV = {
        let calendarV = JuCalendarV.init(frame: CGRect.zero)
        calendarV.beginBlock = { [weak self] (date ) in
            guard let uSelf = self  else { return }
            if uSelf.returnBeginCalendarAction != nil {
                uSelf.returnBeginCalendarAction!(date)
            }
        }
        
        calendarV.endBlock = {  [weak self] (date) in
            guard let uSelf = self  else { return }
            if uSelf.returnEndCalendarAction != nil {
                uSelf.returnEndCalendarAction!(date)
            }
        }
        return calendarV
    }()
    
    open lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero,style: .plain)
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag;  //滑动收回～
        return tableView
    }()
    
    private var _leftArray:[FiltrateModel] = [] // region
    public   var  leftArray:[FiltrateModel] {
        get {
            return _leftArray
        }
        set {
            _leftArray = newValue
            filtrateTabview.leftArray = newValue
        }
    }
    
    private var _centerArray:[FiltrateModel] = [] // region
    public   var  centerArray:[FiltrateModel] {
        get {
            return _centerArray
        }
        set {
            _centerArray = newValue
            filtrateTabview.centerArray = newValue
        }
    }
    
    private var _rightArray:[FiltrateModel] = [] // region
    public   var  rightArray:[FiltrateModel] {
        get {
            return _rightArray
        }
        set {
            _rightArray = newValue
            filtrateTabview.rightArray = newValue//regionLists
        }
    }
    
    private var _groups:NSMutableArray = [] // price & priceMore
    public   var  groups:NSMutableArray {//EntryModel
        get {
            return _groups
        }
        set {
            _groups = newValue
            entryTagView.entryModel = newValue.firstObject as? EntryModel  ?? EntryModel.init()
        }
    }
    
    private var _allgroups:NSMutableArray = [] // priceMore
    public   var  allgroups:NSMutableArray {//EntryModel
        get {
            return _allgroups
        }
        set {
            _allgroups = newValue
        }
    }
    
    private var _array:NSMutableArray = [] // houseType & more & sort
    public   var  array:NSMutableArray {//EntryModel
        get {
            return _array
        }
        set {
            _array = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI(filTypeAler: .price)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowNotification(_ notification:Notification) {
        
        guard let info = notification.userInfo else { return }

        let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect

        tableView.contentInset =  UIEdgeInsets.init(top: 0, left: 0, bottom: frame.height, right: 0)
    }
    
    @objc func keyboardWillHideNotification(_ notification:Notification) {
        
        tableView.contentInset =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    func removeAllSubViews(){
        if subviews.count>0{
            subviews.forEach({$0.isHidden = true})
        }
    }
    var index = -1 //有bug 先这么着 第一次显示 第二次不显示 第。。。次显示 // 不写index 第一次显示 以后不显示了
    open func setupUI(filTypeAler: FilTypeAler) {
        self.filTypeAler = filTypeAler
        removeAllSubViews()
        switch filTypeAler {
        case .time:
            removeAllSubViews()
            self.addSubview(entryTagView)
            entryTagView.isHidden = false
            self.addSubview(calendarV)
            calendarV.isHidden = false
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            break
        case .region:
            removeAllSubViews()
            self.addSubview(filtrateTabview)
            filtrateTabview.isHidden = false
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
        case .price:
            removeAllSubViews()
            self.addSubview(entryTagView)
            entryTagView.titleL.snp.remakeConstraints { make in
                make.height.equalTo(FRPRealValue(30))
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.top.equalToSuperview().offset(0)
            }
            entryTagView.isHidden = false
            self.addSubview(priceView)
            priceView.isHidden = false
            priceView.setupUI(priceTypeAler: .price)
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            break
        case .priceMore:
            removeAllSubViews()
            self.addSubview(segmentBar)
            segmentBar.isHidden = false
            segmentBar.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview().offset(FRPRealValue(0))
                make.width.equalTo(FRPRealValue(250))
                make.top.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(45)).priority(100)
            }
            segmentedDataSource.titles =  ["单价","总价"]
            segmentedDataSource.reloadData(selectedIndex: 0)
            segmentedDataSource.titleNormalColor = FSHexColor(Hex: 0x252525, alpha: 1)
            segmentedDataSource.titleSelectedColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            segmentedDataSource.isTitleColorGradientEnabled = true
            segmentedDataSource .titleNormalFont = .systemFont(ofSize: FRPRealValue(14))
            segmentedDataSource.titleSelectedFont = .boldSystemFont(ofSize: FRPRealValue(17))
            segmentedDataSource.itemSpacing = FRPRealValue(60)
            unowned let uSelf = self
            segmentBar.delegate = uSelf
            segmentBar.dataSource = segmentedDataSource
            segmentBar.reloadData()
            segmentBar.indicators = [indicator]
            self.addSubview(entryTagView)
            entryTagView.isHidden = false
            entryTagView.titleL.text = ""
            self.addSubview(priceView)
            priceView.isHidden = false
            priceView.setupUI(priceTypeAler: .priceMore)
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            break
        case .houseType:
            removeAllSubViews()
            self.addSubview(tableView)
            tableView.isHidden = false
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(InformationEntryTagCell.self, forCellReuseIdentifier: "InformationEntryTagCell")
            tableView.separatorStyle = .none
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            tableView.reloadData()
            break
        case .more:
            removeAllSubViews()
            self.addSubview(tableView)
            tableView.isHidden = false
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(InformationEntryTagCell.self, forCellReuseIdentifier: "InformationEntryTagCell")
            tableView.separatorStyle = .none
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            tableView.reloadData()
            break
        case .sort:
            removeAllSubViews()
            self.addSubview(tableView)
            tableView.isHidden = false
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(FilTabCell.self, forCellReuseIdentifier: "FilTabCell")
            tableView.separatorStyle = .none
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            tableView.reloadData()
            break
        case .none:
            removeAllSubViews()
            self.addSubview(tableView)
            tableView.isHidden = false
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0.0
            }
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(InformationEntryTagCell.self, forCellReuseIdentifier: "InformationEntryTagCell")
            tableView.separatorStyle = .none
            self.addSubview(filtrateBotView)
            filtrateBotView.isHidden = false
            tableView.reloadData()
        case .threeRegion:
            
            JuAddThreeFiltrate.showThreeFiltrate(lefts: lfiltrates, cens: cfiltrates, rights: rfiltrates, groupStrs: groupStrs, groupPaths: groupPaths)
            self.addSubview(JuAddThreeFiltrate.shared.filtrateTabview)
            JuAddThreeFiltrate.shared.filtrateTabview.snp.remakeConstraints { make in
                make.top.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(193))
            }
            self.addSubview(JuAddThreeFiltrate.shared.footV)
            JuAddThreeFiltrate.shared.footV.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            break
            
        }
        
        layoutFilTypeAler()
    }
   
    func layoutFilTypeAler(){
        switch self.filTypeAler {
        case .time:
            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            calendarV.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(40))
                make.bottom.equalTo(filtrateBotView.snp_top).offset(-FRPRealValue(5))
            }
            
            entryTagView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(FRPRealValue(5))
                make.left.right.equalToSuperview().offset(0)
                make.bottom.equalTo(priceView.snp_top).offset(-FRPRealValue(5))
            }
            
            if  entryTagView.titleL.text?.length ?? 0 > 0 {
                entryTagView.titleL.snp.updateConstraints { make in
                    make.height.equalTo(FRPRealValue(30))
                }
            }
        case .region:
            filtrateTabview.snp.remakeConstraints { make in
                make.top.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(193))
            }
            filtrateBotView.snp.remakeConstraints { make in
                make.top.equalTo(filtrateTabview.snp_bottom).offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            break
        case .price:

            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            priceView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(40))
                make.bottom.equalTo(filtrateBotView.snp_top).offset(-FRPRealValue(5))
            }
            
            entryTagView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(FRPRealValue(5))
                make.left.right.equalToSuperview().offset(0)
                make.bottom.equalTo(priceView.snp_top).offset(-FRPRealValue(5))
            }
            
            entryTagView.titleL.snp.remakeConstraints{ make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
               if entryTagView.titleL.text?.length ?? 0 > 0{
                   make.top.equalToSuperview().offset(FRPRealValue(15))
                    make.height.equalTo(FRPRealValue(30))
               }else{
                   make.height.equalTo(FRPRealValue(0))
                   make.top.equalToSuperview().offset(FRPRealValue(0))
               }
            }
            
            break
        case .priceMore:
            
            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            priceView.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(40))
                make.bottom.equalTo(filtrateBotView.snp_top).offset(-FRPRealValue(5))
            }
            
            entryTagView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(FRPRealValue(45))
                make.left.right.equalToSuperview().offset(0)
                make.bottom.equalTo(priceView.snp_top).offset(-FRPRealValue(5))
            }
            entryTagView.titleL.snp.remakeConstraints{ make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
               if entryTagView.titleL.text?.length ?? 0 > 0{
                   make.top.equalToSuperview().offset(FRPRealValue(15))
                    make.height.equalTo(FRPRealValue(30))
               }else{
                   make.height.equalTo(FRPRealValue(0))
                   make.top.equalToSuperview().offset(FRPRealValue(0))
               }
            }
    
        case .houseType:
            
            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            tableView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(0)
                make.bottom.equalTo(filtrateBotView.snp_top).offset(0)
            }
            
            break
        case .more:

            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            tableView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(0)
                make.bottom.equalTo(filtrateBotView.snp_top).offset(0)
            }
            break
        case .sort:
            
            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            tableView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(0)
                make.bottom.equalTo(filtrateBotView.snp_top).offset(0)
            }
            
            break
        case .none:
            filtrateBotView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(0)
                make.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            
            tableView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(0)
                make.bottom.equalTo(filtrateBotView.snp_top).offset(0)
            }
            break
        case .threeRegion:
            JuAddThreeFiltrate.showThreeFiltrate(lefts: lfiltrates, cens: cfiltrates, rights: rfiltrates, groupStrs: groupStrs, groupPaths: groupPaths)
            self.addSubview(JuAddThreeFiltrate.shared.filtrateTabview)
            JuAddThreeFiltrate.shared.filtrateTabview.snp.remakeConstraints { make in
                make.top.left.right.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(193))
            }
            self.addSubview(JuAddThreeFiltrate.shared.footV)
            JuAddThreeFiltrate.shared.footV.snp.remakeConstraints { make in
                make.left.right.bottom.equalToSuperview().offset(0)
                make.height.equalTo(FRPRealValue(69))
            }
            break
        }
    }
    
    private var _lfiltrates:[FiltrateModel] = []
    public   var  lfiltrates:[FiltrateModel] {
        get {
            return _lfiltrates
        }
        set {
            _lfiltrates = newValue
            
        }
    }
   
    private var _rfiltrates:[[[FiltrateModel]]] = []
    public   var  rfiltrates:[[[FiltrateModel]]]{
        get {
            return _rfiltrates
        }
        set {
            _rfiltrates = newValue
           
        }
    }
    
    private var _cfiltrates:[[FiltrateModel]] = []
    public   var  cfiltrates:[[FiltrateModel]]{
        get {
            return _cfiltrates
        }
        set {
            _cfiltrates = newValue
           
        }
    }
    
    private var _groupStrs:[String] = []
    public   var  groupStrs:[String]{
        get {
            return _groupStrs
        }
        set {
            _groupStrs = newValue
           
        }
    }
    
    private var _groupPaths:[JIndexPath] = []
    public   var  groupPaths:[JIndexPath]{
        get {
            return _groupPaths
        }
        set {
            _groupPaths = newValue
        }
    }
    
   open func filtrateAlerViewHeight() -> CGFloat {
        switch self.filTypeAler {
            
        case .time:
            return itemSizeGroupHeight()
        case .region:
            return FRPRealValue(262)
        case .price:
            let entryModel = groups.firstObject as? EntryModel  ?? EntryModel.init()
            entryTagView.titleL.text = entryModel.title
            let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (entryModel.itemSize?.width + FRPRealValue(10) ?? 0)
            var n:Int = (entryModel.groups?.count ?? 0) / s
            if (entryModel.groups?.count ?? 0) % s > 0{
                n  += 1
            }
            return (entryModel.itemSize?.height ?? 0 + FRPRealValue(5)) * CGFloat(n) + FRPRealValue(40) + FRPRealValue(40) + typeHeight
            
        case .priceMore:
            if segmentBar.selectedIndex == 0 {
                let entryModel = groups.firstObject as? EntryModel  ?? EntryModel.init()
                let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (entryModel.itemSize?.width + FRPRealValue(10) ?? 0)
                var n:Int = (entryModel.groups?.count ?? 0) / s
                if (entryModel.groups?.count ?? 0) % s > 0{
                    n  += 1
                }
                return (entryModel.itemSize?.height ?? 0 + FRPRealValue(5)) * CGFloat(n) + FRPRealValue(40) + FRPRealValue(40) + typeHeight + FRPRealValue(45)
            }else{
                let entryModel = allgroups.firstObject as? EntryModel  ?? EntryModel.init()
                let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (entryModel.itemSize?.width + FRPRealValue(10) ?? 0)
                var n:Int = (entryModel.groups?.count ?? 0) / s
                if (entryModel.groups?.count ?? 0) % s > 0{
                    n  += 1
                }
                return (entryModel.itemSize?.height ?? 0  + FRPRealValue(5)) * CGFloat(n) + FRPRealValue(40) + FRPRealValue(40) + typeHeight + FRPRealValue(45)
            }
        case .houseType:
             return itemSizeArrayHeight()
        case .more:
            return itemSizeArrayHeight()
        case .sort:
            return CGFloat(array.count ) * FRPRealValue(35) + typeHeight
        case .none:
            return itemSizeArrayHeight()
        case .threeRegion:
            return FRPRealValue(262)
        }
    }
    
    func itemSizeArrayHeight() -> CGFloat {
        var height:CGFloat  = 0
        array.enumerateObjects { object, index, stop in
            let obj = (object as? EntryModel  ?? EntryModel.init())
            let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (obj.itemSize?.width + FRPRealValue(5) ?? 0)
            let itemHeight = (obj.itemSize?.width ?? 0 > FRPRealValue(105) ?  ((obj.itemSize?.height ?? 0)) - FRPRealValue(12) : ( (obj.itemSize?.height ?? 0) + FRPRealValue(5)))
            if obj.title?.length ?? 0 > 0 {
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1)
            }else{
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) > 1 ? ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1) : 1)
            }
            if obj.type == .image  {
                height += FRPRealValue(40)
            }
            if obj.type == .images {
                height += FRPRealValue(40)
            }
            if obj.type == .three {
                height += FRPRealValue(50)
            }
        }
        height +=  FRPRealValue(70)
        return height
    }
    
    func itemSizeGroupHeight() -> CGFloat {
        var height:CGFloat  = 0
        groups.enumerateObjects { object, index, stop in
            let obj = (object as? EntryModel  ?? EntryModel.init())
            let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (obj.itemSize?.width + FRPRealValue(5) ?? 0)
            let itemHeight = (obj.itemSize?.width ?? 0 > FRPRealValue(105) ?  ((obj.itemSize?.height ?? 0)) - FRPRealValue(12) : ( (obj.itemSize?.height ?? 0) + FRPRealValue(5)))
            if obj.title?.length ?? 0 > 0 {
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1)
            }else{
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) > 1 ? ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1) : 1)
            }
            if obj.type == .image  {
                height += FRPRealValue(40)
            }
            if obj.type == .images {
                height += FRPRealValue(40)
            }
            if obj.type == .three {
                height += FRPRealValue(50)
            }
        }
        height +=  FRPRealValue(100)
        return height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func returnTagBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void) {
        returnTagAction = callback
    }
    private  var returnTagAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?) -> Void))?
    
    open func returnTagSetBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void) {
        returnTagSetAction = callback
    }
    private  var returnTagSetAction: ( (@convention(block) (_ indexPath: IndexPath?,_ index: IndexPath?,_ groupsele: NSMutableArray?) -> Void))?
    
}

extension FiltrateAlerView:JXSegmentedViewDelegate{

   func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
       if index == 0 {
           entryTagView.entryModel = groups.firstObject as? EntryModel ?? EntryModel.init()
       }else{
           entryTagView.entryModel = allgroups.firstObject as? EntryModel  ?? EntryModel.init()
       }
       if returnSegAction != nil {
           returnSegAction!()
       }
   }
}

extension FiltrateAlerView :UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.filTypeAler  == .more || self.filTypeAler  == .houseType || self.filTypeAler  == .none {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InformationEntryTagCell") as? InformationEntryTagCell
            cell?.selectionStyle = .none
            let entryModel = array[indexPath.section] as? EntryModel  ?? EntryModel.init()
            cell?.tagType  = entryModel.tagType == .more ? .more : .normal
            cell?.itemSize = entryModel.itemSize ?? CGSize.zero
            cell?.titleStr = entryModel.title ?? ""
            cell?.entryModel = entryModel
            if  isReSet {
                cell?.entryTagView.reSet()
            }
            cell?.entryTagView.returnBlock({  [weak self] (index,model) in
                guard let uSelf = self  else { return }
                uSelf.array[indexPath.section] = model
                if uSelf.returnTagAction != nil {
                    uSelf.returnTagAction!(indexPath,index)
                }
            })
            
            cell?.entryTagView.returnSetBlock({  [weak self] (index, groupsele,model ) in
                guard let uSelf = self  else { return }
                uSelf.array[indexPath.section] = model
                if uSelf.returnTagSetAction != nil {
                    uSelf.returnTagSetAction!(indexPath,index,groupsele)
                }
            })
            cell?.priceView.returnBlock({  [weak self] (tf) in
                guard let uSelf = self  else { return }
                if tf.tag == 1 {
                    if uSelf.returnCellPriceAction != nil {
                        uSelf.returnCellPriceAction!(indexPath,tf.tag, tf.text)
                    }
                }else{
                    if uSelf.returnCellPriceAction != nil {
                        uSelf.returnCellPriceAction!(indexPath,tf.tag, tf.text)
                    }
                }
            })
            
            cell?.returnBeginCalendarBlock({ [weak self] (date ) in
                guard let uSelf = self  else { return }
                if uSelf.returnCellPriceAction != nil {
                    uSelf.returnCellPriceAction!(indexPath,1, date)
                }
            })
            
            cell?.returnEndCalendarBlock({ [weak self] (date ) in
                guard let uSelf = self  else { return }
                if uSelf.returnCellPriceAction != nil {
                    uSelf.returnCellPriceAction!(indexPath,2, date)
                }
            })
            
            cell?.returnPriceBlock({   [weak self] (type, text) in
                guard let uSelf = self  else { return }
                if type == 1 {
                    if uSelf.returnCellPriceAction != nil {
                        uSelf.returnCellPriceAction!(indexPath,type, text)
                    }
                }else{
                    if uSelf.returnCellPriceAction != nil {
                        uSelf.returnCellPriceAction!(indexPath,type, text)
                    }
                }
            })
            
            return cell ?? UITableViewCell.init()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilTabCell") as! FilTabCell
            cell.selectionStyle = .none
            cell.setupUI(filtrateModel: array[indexPath.section] as! FiltrateModel)
            
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.filTypeAler == .sort {
            let group :NSMutableArray = []
            array.enumerateObjects { object, index, stop in
                let obj = (object as! FiltrateModel)
                if index == indexPath.section {
                    obj.iSele = true
                }else{
                    obj.iSele = false
                }
                group.add(obj)
            }
            array = group
            tableView.reloadData()
            if returnTagAction != nil {
                returnTagAction!(IndexPath.init(item:indexPath.row, section: indexPath.section),indexPath)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return array.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.filTypeAler == .sort {
           return FRPRealValue(35)
        }else{
            let obj = array[indexPath.section] as? EntryModel  ?? EntryModel.init()
            let  s =  Int (UIScreen.main.bounds.size.width - FRPRealValue(30)) / Int (obj.itemSize?.width + FRPRealValue(5) ?? 0)
            var height:CGFloat  = 0
            let itemHeight = (obj.itemSize?.width ?? 0 > FRPRealValue(105) ?  ((obj.itemSize?.height ?? 0) - FRPRealValue(12)) : ( (obj.itemSize?.height ?? 0) + FRPRealValue(5)))
            if obj.title?.length ?? 0 > 0 {
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1)
            }else{
                height +=  itemHeight *  ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) > 1 ? ((CGFloat((obj.groups?.count ?? 1)) / CGFloat(s)) + 1) : 1)
            }
            if obj.type == .image  {
                height += FRPRealValue(40)
            }
            if obj.type == .images {
                height += FRPRealValue(40)
            }
            if obj.type == .three {
                height += FRPRealValue(50)
            }
            if obj.title?.length ?? 0 > 0  {
                height += FRPRealValue(45)
            }
            return height
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 0.01
   }
}

extension Optional where Wrapped == String {
    
    public static func +(lhs:Wrapped?, rhs:Wrapped?) -> Wrapped? {
        if lhs == nil {
            return rhs
        } else if rhs == nil {
            return lhs
        } else if let vl = lhs, let vr = rhs {
            return vl + vr
        } else {
            return nil
        }
    }
    
}

extension Optional where Wrapped : FixedWidthInteger {
    
    public static func +(lhs:Wrapped?, rhs:Wrapped?) -> Wrapped? {
        if lhs == nil {
            return rhs
        } else if rhs == nil {
            return lhs
        } else if let vl = lhs, let vr = rhs {
            return vl + vr
        } else {
            return nil
        }
    }
}


extension Optional where Wrapped : BinaryFloatingPoint {
    
    public static func +(lhs:Wrapped?, rhs:Wrapped?) -> Wrapped? {
        if lhs == nil {
            return rhs
        } else if rhs == nil {
            return lhs
        } else if let vl = lhs, let vr = rhs {
            return vl + vr
        } else {
            return nil
        }
    }
}

