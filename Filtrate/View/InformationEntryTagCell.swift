//
//  InformationEntryTagCell.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/24.
//

import Foundation
import UIKit

class EntryTagView: UIView {
    
    private var _type:Int = 1
    public   var  type:Int {
          get {
              return _type
          }
          set {
              _type = newValue
              layoutSubviews()
          }
    }
    
    private var _cRius:CGFloat = FRPRealValue(2)
    public   var  cRius:CGFloat {
          get {
              return _cRius
          }
          set {
              _cRius = newValue
          }
    }
    
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .left
        titleL.font = UIFont.systemFont(ofSize: FRPRealValue(16),weight: UIFont.Weight(rawValue: FRPRealValue(0.5)))
        titleL.textColor = FSHexColor(Hex: 0x261919, alpha: 1)
        return titleL
    }()
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        return lineV
    }()
    
    private var _tagType:TagType = TagType.normal
    public   var  tagType:TagType {
        get {
            return _tagType
        }
        set {
            _tagType = newValue
        }
    }
    
    private var _font:CGFloat = FRPRealValue(16)
    public   var  font:CGFloat { //特殊情况下的微调高度
          get {
              return _font
          }
          set {
              _font = newValue
          }
    }
    
    open var groupsele:NSMutableSet = []
    
    private var _entryModel:EntryModel = EntryModel.init()
    public   var  entryModel:EntryModel {
          get {
              return _entryModel
          }
          set {
              _entryModel = newValue
              tagType = _entryModel.type == .more ?  .more : .normal
              collectionView.reloadData()
          }
    }
    var currentModel : EntryModel = EntryModel.init()
    open var cells:[HomeTagCell] = []
    var entryCode : String = ""
    open lazy var flowLayout : UICollectionViewLeftAlignedLayout = {
        let flowLayout = UICollectionViewLeftAlignedLayout.init()
        flowLayout.minimumLineSpacing = FRPRealValue(5)
        flowLayout.minimumInteritemSpacing = FRPRealValue(5)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    open lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        unowned let uSelf = self
        collectionView.delegate = uSelf
        collectionView.dataSource = uSelf
        collectionView.register(HomeTagCell.self, forCellWithReuseIdentifier: "HomeTagCell")
        collectionView.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        return collectionView
    }()
    
    override func layoutSubviews() {
        unowned let uSelf = self
        
        if entryModel.groups?.count ?? 0 > 0  {
            titleL.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
                if uSelf.type == 0 ||  titleL.text?.length ?? 0 == 0 {
                    make.height.equalTo(0)
                    make.top.equalToSuperview().offset(0)
                }else if titleL.text?.length ?? 0 > 0{
                    make.top.equalToSuperview().offset(FRPRealValue(15))
                    make.height.equalTo(FRPRealValue(30))
                }
            }
            
            collectionView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
                if uSelf.type == 0 ||  titleL.text?.length ?? 0 == 0 {
                    make.top.equalTo(titleL.snp_bottom).offset(FRPRealValue(5))
                }else{
                    make.top.equalTo(titleL.snp_bottom).offset(FRPRealValue(10))
                }
                make.right.equalToSuperview().offset(0)
                if (entryModel.itemSize?.height ?? 0 > 0){
                    make.height.equalTo(FRPRealValue(entryModel.itemSize?.height ?? 0))
                }
            }
            
            lineV.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.right.equalToSuperview().offset(-FRPRealValue(15))
                make.height.equalTo(FRPRealValue(0.5))
                make.bottom.equalToSuperview().offset(-FRPRealValue(0.5))
                make.top.equalTo(collectionView.snp_bottom).offset(0)
            }
            collectionView.isHidden = false
        }else{
            collectionView.isHidden = true
            titleL.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(FRPRealValue(15))
                make.top.bottom.right.equalToSuperview().offset(0)
            }
        }
        groupsele.removeAllObjects()
    }
    
    func reSet()  {
        let group :NSMutableArray = []
        if entryModel.groups?.count ?? 0 > 0 {
            entryModel.groups!.enumerateObjects { (object, index, stop) in
                let obj = (object as! EntryTag)
                obj.iSele = false
                group.add(obj)
            }
        }
        entryModel.groups = group
        if tagType == .more {
            groupsele.removeAllObjects()
            collectionView.reloadData()
        }else{
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleL)
        self.addSubview(collectionView)
        self.addSubview(lineV)
        self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func returnBlock(_ callback: @escaping(_ indexPath: IndexPath?,_ entryModel:EntryModel) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (_ indexPath: IndexPath?,_ entryModel:EntryModel) -> Void)?
    
    open func returnSetBlock(_ callback: @escaping(_ indexPath: IndexPath?,_ groupsele: NSMutableArray?,_ entryModel:EntryModel) -> Void) {
        returnSetAction = callback
    }
    private  var returnSetAction: ( (_ indexPath: IndexPath?,_ groupsele: NSMutableArray?,_ entryModel:EntryModel) -> Void)?
}

class InformationEntryTagCell: UITableViewCell {
    
    open lazy var entryTagView : EntryTagView = {
        let entryTagView = EntryTagView.init()
        entryTagView.collectionView.isScrollEnabled = false
        return entryTagView
    }()
    
    private var _tagType:TagType = TagType.normal
    public   var  tagType:TagType {
          get {
              return _tagType
          }
          set {
              _tagType = newValue
              entryTagView.tagType = newValue
          }
    }
    
    private var _itemSize:CGSize = CGSize.zero
    public   var  itemSize:CGSize {
          get {
              return _itemSize
          }
          set {
              _itemSize = newValue
              entryTagView.flowLayout.itemSize = newValue
              entryTagView.collectionView.setCollectionViewLayout(entryTagView.flowLayout, animated: true)
          }
    }
    
    open lazy var calendarV : JuCalendarV = {
        let calendarV = JuCalendarV.init(frame: CGRect.zero)
        calendarV.isHidden  = true
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
    
    open lazy var lineV : UIView = {
        let lineV = UIView.init()
        lineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        return lineV
    }()
    
    open func returnBeginCalendarBlock(_ callback: @escaping @convention(block) (_ date:String) -> Void) {
        returnBeginCalendarAction = callback
    }
    private  var returnBeginCalendarAction: ( (@convention(block) (_ date:String) -> Void))?
    
    
    open func returnEndCalendarBlock(_ callback: @escaping @convention(block) (_ date:String) -> Void) {
        returnEndCalendarAction = callback
    }
    private  var returnEndCalendarAction: ( (@convention(block) (_ date:String) -> Void))?
    
    
    open func returnPriceBlock(_ callback: @escaping(_ type: Int?,_ text: String?) -> Void) {
        returnPriceAction = callback
    }
    private  var returnPriceAction: ( (_ type: Int?,_ text: String?) -> Void)?
    
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
    
    private var groupsele:NSMutableSet = []
        
    private var _entryModel:EntryModel = EntryModel.init()
    public   var  entryModel:EntryModel {
          get {
              return _entryModel
          }
          set {
              _entryModel = newValue
              entryTagView.entryModel = newValue
              groupsele.removeAllObjects()
              entryModel.groups?.enumerateObjects { (object, index, stop) in
                  let obj = (object as! EntryTag)
                  if obj.iSele == true {
                      groupsele.add(index)
                  }
              }
              if _entryModel.type ==  .images{
                  entryTagView.snp.remakeConstraints { make in
                      make.top.right.left.equalToSuperview().offset(0)
                  }
                  entryTagView.lineV.isHidden = true
                  calendarV.isHidden = false
                  priceView.isHidden = true
                  lineV.isHidden = false
                  lineV.snp.remakeConstraints { make in
                      make.left.equalToSuperview().offset(FRPRealValue(15))
                      make.right.equalToSuperview().offset(-FRPRealValue(15))
                      make.height.equalTo(FRPRealValue(0.5))
                      make.bottom.equalToSuperview().offset(-FRPRealValue(0.5))
                  }
                  
                  calendarV.snp.remakeConstraints { make in
                      make.left.right.equalToSuperview().offset(0)
                      make.height.equalTo(FRPRealValue(40))
                      make.top.equalTo(entryTagView.snp_bottom).offset(FRPRealValue(5))
                      make.bottom.equalTo(lineV.snp_top).offset(FRPRealValue(-5))
                  }
                  if entryModel.places?.count ?? 0 >= 2 {
                      calendarV.beginLabel.text = entryModel.places?.first
                      calendarV.endLabel.text = entryModel.places?.last
                  }
                  if entryModel.image?.length ?? 0 > 0 {
                      calendarV.beginimgV.image = UIImage.init(named: entryModel.image ?? "")
                      calendarV.endimgV.image = UIImage.init(named: entryModel.image ?? "")
                  }
              }else if _entryModel.type ==  .image{
                  entryTagView.snp.remakeConstraints { make in
                      make.top.right.left.equalToSuperview().offset(0)
                  }
                  calendarV.isHidden = true
                  priceView.isHidden = false
                  lineV.isHidden = false
                  lineV.snp.remakeConstraints { make in
                      make.left.equalToSuperview().offset(FRPRealValue(15))
                      make.right.equalToSuperview().offset(-FRPRealValue(15))
                      make.height.equalTo(FRPRealValue(0.5))
                      make.bottom.equalToSuperview().offset(-FRPRealValue(0.5))
                  }
                  
                  priceView.snp.remakeConstraints { make in
                      make.left.right.equalToSuperview().offset(0)
                      make.height.equalTo(FRPRealValue(40))
                      make.top.equalTo(entryTagView.snp_bottom).offset(FRPRealValue(5))
                      make.bottom.equalTo(lineV.snp_top).offset(FRPRealValue(-5))
                  }
                  entryTagView.lineV.isHidden = true
                  if entryModel.places?.count ?? 0 >= 2 {
                      priceView.tf1.placeholder = entryModel.places?.first
                      priceView.tf2.placeholder = entryModel.places?.last
                  }
                  if entryModel.image?.length ?? 0 > 0 {
                      priceView.setupUI(priceTypeAler: .priceMore)
                      priceView.titleL.text = entryModel.desc
                  }else{
                      priceView.setupUI(priceTypeAler: .price)
                  }
                  if entryModel.desc?.length ?? 0 > 0 {
                      priceView.descL.text = entryModel.desc
                  }
              }else if _entryModel.type ==  .three{
                  entryTagView.snp.remakeConstraints { make in
                      make.top.right.left.equalToSuperview().offset(0)
                  }
                  calendarV.isHidden = true
                  priceView.isHidden = false
                  lineV.isHidden = false
                  lineV.snp.remakeConstraints { make in
                      make.left.equalToSuperview().offset(FRPRealValue(15))
                      make.right.equalToSuperview().offset(-FRPRealValue(15))
                      make.height.equalTo(FRPRealValue(0.5))
                      make.bottom.equalToSuperview().offset(-FRPRealValue(0.5))
                  }
                  
                  priceView.snp.remakeConstraints { make in
                      make.left.right.equalToSuperview().offset(0)
                      make.height.equalTo(FRPRealValue(40))
                      make.top.equalTo(entryTagView.snp_bottom).offset(FRPRealValue(5))
                      make.bottom.equalTo(lineV.snp_top).offset(FRPRealValue(-5))
                  }
                  entryTagView.lineV.isHidden = true
                  
                  if entryModel.places?.count ?? 0 > 2 {
                      priceView.setupUI(priceTypeAler: .priceThreeMore)
                      priceView.tf1.placeholder = entryModel.places?.first
                      priceView.tf2.placeholder = entryModel.places?[1]
                      priceView.tf3.placeholder = entryModel.places?.last
                      
                      priceView.descL.text =  entryModel.descs?.first
                      priceView.descL1.text = entryModel.descs?[1]
                      priceView.descL2.text =  entryModel.descs?.last
                  }
              }
              else{
                  entryTagView.snp.remakeConstraints { make in
                      make.top.right.bottom.left.equalToSuperview().offset(0)
                  }
                  entryTagView.lineV.isHidden = false
                  calendarV.isHidden = true
                  priceView.isHidden = true
                  lineV.isHidden = true
              }
              
          }
    }
    
    private var _titleStr:String = ""
    public   var  titleStr:String {
          get {
              return _titleStr
          }
          set {
              _titleStr = newValue
              
              let attributedString = NSMutableAttributedString.init(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: FSHexColor(Hex: 0x161C26, alpha: 1) , NSAttributedString.Key.font: UIFont.systemFont(ofSize: FRPRealValue(16))])
              let range = _titleStr.ranges(of: "*")
              if !range.isEmpty{
                  attributedString.addAttributes([NSAttributedString.Key.foregroundColor: FSHexColor(Hex: 0xF52938, alpha: 1) , NSAttributedString.Key.font: UIFont.systemFont(ofSize: FRPRealValue(16))], range: range.first ?? NSRange.init(location: (_titleStr.length ) - 1, length: 1))
                  entryTagView.titleL.attributedText = attributedString
              }else{
                  entryTagView.titleL.text = newValue
              }
          }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        contentView.addSubview(entryTagView)
        contentView.addSubview(priceView)
        contentView.addSubview(calendarV)
        contentView.addSubview(lineV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension EntryTagView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if entryModel.itemSize?.width ?? 0 <= entryModel.itemSize?.height ?? 0  &&  entryModel.itemSize?.height ?? 0 > 0{
            let text = (entryModel.groups?[indexPath.row] as? EntryTag)?.title ?? ""
            let  cell_width = settingCollectionViewItemWidthBoundingWithText(text: text)
            return CGSize.init(width: cell_width, height: entryModel.itemSize?.height ?? 0)
        }else{
            return CGSize.init(width: flowLayout.itemSize.width, height: flowLayout.itemSize.height)
        }
    }
    
    func settingCollectionViewItemWidthBoundingWithText(text:String) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: entryModel.itemSize?.height ?? 0)
        let frame = String.init().boundingRect(with: size, font: UIFont.systemFont(ofSize: font) , lineSpacing: 0, attributeString: text)
        var width = (frame.width ) + FRPRealValue(25)
        if width > collectionView.bounds.size.width - FRPRealValue(15) {
                width = collectionView.bounds.size.width - FRPRealValue(15)
            }
            //4.添加左右间距
        return width
    }
}

extension EntryTagView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entryModel.groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTagCell", for: indexPath) as! HomeTagCell
        let entryTag = entryModel.groups?[indexPath.row] as? EntryTag
        cell.titleL.text = entryTag?.title
        cell.titleL.font = UIFont.systemFont(ofSize: font)
        cell.layer.cornerRadius = cRius
        cell.layer.masksToBounds = true
        if entryTag?.color?.length ?? 0 > 0 {
            cell.titleL.textColor = UIColor.init(hexString: "#" + (entryTag?.color ?? "F9F9F9"))
            cell.backgroundColor = UIColor.init(hexString: "#" + (entryTag?.color ?? "F9F9F9"),alpha:0.3)
        }else{
            cell.titleL.textColor = FSHexColor(Hex: 0xB6BABF, alpha: 1)
            cell.backgroundColor = FSHexColor(Hex: 0xF9F9F9, alpha: 1)
        }
        cell.setupUI(entryTag: entryTag  ?? EntryTag.init() )
        if !cells.contains(where: { $0 == cell }) {
            cells.append(cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tagType == .normal {
            let group :NSMutableArray = []
            entryModel.groups!.enumerateObjects { (object, index, stop) in
                let obj = (object as! EntryTag)
                if index == indexPath.row {
                    obj.iSele = !obj.iSele
                }else{
                    obj.iSele = false
                }
                group.add(obj)
            }
            entryModel.groups = group
            collectionView.reloadData() //渲染视图
            
            let entryTag = entryModel.groups?[indexPath.row] as? EntryTag // 取code 
            entryCode = entryTag?.code ?? ""
            
        }else{
            if !groupsele.contains(indexPath.row) {
                groupsele.add(indexPath.row)
            }
            let group :NSMutableArray = []
            entryModel.groups!.enumerateObjects { (object, index, stop) in
                let obj = (object as! EntryTag)
                if index ==  indexPath.row{
                    if groupsele.contains(index) {
                        obj.iSele = !obj.iSele
                        if obj.iSele == false {
                            groupsele.remove(indexPath.row)
                        }
                    }
                }
                group.add(obj)
            }
            entryModel.groups = group
            collectionView.reloadData()
        }
         self.currentModel = entryModel
         if returnSetAction != nil && tagType == .more{
            let group :NSMutableArray = []
            groupsele.enumerateObjects { object, index in
                group.add(entryModel.groups![object as! Int])
            }
            if returnSetAction != nil {
                returnSetAction!(indexPath,group,entryModel)
            }
         }else if returnAction != nil {
             self.currentModel.code = entryCode
             returnAction!(indexPath, self.currentModel)
        }
    }
    
}
