//
//  FiltrateModel.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/1.
//

import Foundation
import HandyJSON

public var filcenter = Center()
public struct Center {
    public var validRegionData:CustorModel = CustorModel.init()
}

struct FoldModel: HandyJSON {
    init() {}
    var title : String?
    var tag : String?
    var desc  : String?
    var groups : NSMutableArray?
    var iSele:Bool = false
    init(_title:String,_tag:String,_desc:String,_groups:NSMutableArray,_iSele:Bool) {
        title = _title
        tag = _tag
        desc = _desc
        groups = _groups
        iSele = _iSele
    }
}

public enum iSeleType: Int {
    case none
    case cen
    case all
}

public enum FilType: Int {
    case left
    case cen
    case right
    case sort
}

@objc public enum FilTypeAler: Int {
    case none
    case region
    case price
    case priceMore
    case houseType
    case more
    case sort
    case time
    case threeRegion
    
}

public class FiltrateModel: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let model = FiltrateModel()
        model.title = title
        model.code = code
        model.iSeleType = iSeleType
        model.iSmage = iSmage
        model.iSele = iSele
        model.filType = filType
        return model
    }
    
    required public init() {}
    public var title :String?
    public var code :String?
    public var iSele:Bool = false
    public var iSeleType:iSeleType?
    public var type :FilType?
    public var filType :FilTypeAler?
    public var iSmage:Bool = true
    
    public  init(_title:String,_filType:FilTypeAler){
        title = _title
        filType = _filType
    }

    public  init(_title:String,_code:String,_type:FilType,_iSele:Bool) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
    }
    
    public  init(_title:String,_code:String,_type:FilType,_iSele:Bool,_iSmage:Bool) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
        iSmage = _iSmage
    }
    
    public init(_title:String,_code:String,_type:FilType,_iSele:Bool,_iSmage:Bool,_iSeleType:iSeleType) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
        iSmage = _iSmage
        iSeleType = _iSeleType
    }
    
    public init(_title:String,_filType:FilTypeAler,_iSmage:Bool) {
        title = _title
        filType = _filType
        iSmage = _iSmage
    }
    
    public init(_title:String,_filType:FilTypeAler,_iSele:Bool,_iSmage:Bool) {
        title = _title
        filType = _filType
        iSmage = _iSmage
        iSele = _iSele
    }
}

public class CustorModel: HandyJSON {
    required public init() {}
    public var code:String?
    public var data:[CustorData]?
    public var message:String?
}

public class CustorData:HandyJSON,Equatable{
    public static func == (lhs: CustorData, rhs: CustorData) -> Bool {
        return false
    }
    
    public var minValue:String?
    public var maxValue:String?
    
    public var max:String?
    public var min:String?
    
    public var dicDataCode:String?//字典Code
    public var dicDataName:String?//字典名称
    
    public var name:String?
    public var label:String?
    
    public var optionCode:String?
    public var optionName:String?
    public var code:String?
    
    public var children:[CustorData]?
    public var optionVOList:[CustorData]?
    
    public var iSele:Bool = false
    public var isSelect : Bool = false//自定义属性，个别涉及选择的位置使用
    
    public  var address:String?
    public var text:String?
    public var textWithoutHighlight:String?
    public  var value:String?
    
    required public init() {
    }
    
    public func didFinishMapping() {
        if minValue?.length ?? 0 > 0 {
            min = minValue
        }
        if min?.length ?? 0 > 0 {
            minValue = min
        }
        if maxValue?.length ?? 0 > 0 {
            max = maxValue
        }
        if max?.length ?? 0 > 0 {
            maxValue = max
        }
        if dicDataCode?.length ?? 0 > 0 {
            code = dicDataCode
            optionCode = dicDataCode
        }
        
        if optionCode?.length ?? 0 > 0 {
            code = optionCode
            dicDataCode = optionCode
        }
        if code?.length ?? 0 > 0 {
            optionCode = code
            dicDataCode = code
        }
        if name?.length ?? 0 > 0 {
            label = name
            optionName = name
            dicDataName = name
        }
        
        if label?.length ?? 0 > 0 {
            name = label
            optionName = label
            dicDataName = label
        }
        
        if optionName?.length ?? 0 > 0 {
            label = optionName
            name = optionName
            dicDataName = optionName
        }
        if dicDataName?.length ?? 0 > 0 {
            name = dicDataName
            optionName = dicDataName
            label = dicDataName
        }
    }
    
}


public enum entryType: Int {
    case normal
    case image
    case images
    case more
    case sele
    case coll
    case three
}

public enum entryKeyType: Int {
    case `default`
    case decimalPad
    case numandPun
    case numPad
}

public enum State: Int {
    case `default`
    case decimalPad
    case numandPun
    case numPad
}

public class EntryTag: HandyJSON {
    required public init() {}
    public var title : String?
    public var iSele:Bool = false
    public var iBorder:Bool = false
    public var code:String?
    public var max:String?
    public var min:String?
    public var color:String?
    
    public init(_title:String,_iSele:Bool,_iBorder:Bool) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
    }
    
    public init(_title:String,_code:String,_iSele:Bool,_iBorder:Bool) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
        code = _code
    }
    
    public init(_title:String,_code:String,_iSele:Bool,_iBorder:Bool,_color:String) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
        code = _code
        color = _color
    }
    
    public init(_title:String,_code:String,_min:String,_max:String,_iSele:Bool,_iBorder:Bool) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
        code = _code
        max = _max
        min = _min
    }
}

public enum TagType: Int {
    case normal
    case more
}

public class EntryModel: HandyJSON {
    required public init() {}
    public   var title : String?
    public var groups : NSMutableArray?
    public var itemSize: CGSize?
    
    public var placeholder : String?
    public var desc : String?
    public var descs : [String]?
    public var place : String?
    public var places : [String]?
    public var image : String?
    public var code:String?
    public var type : entryType?
    public var tagType : TagType?
    public var keyType : entryKeyType?
    
    public init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize) {
        title = _title
        groups = _groups
        type = _type
        itemSize = _itemSize
    }
    
    public init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize,_places:[String],_image:String) {
        title = _title
        groups = _groups
        places = _places
        image = _image
        type = _type
        itemSize = _itemSize
    }
    
    public init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize,_places:[String],_image:String,_desc:String,_keyType:entryKeyType) {
        title = _title
        groups = _groups
        places = _places
        image = _image
        type = _type
        itemSize = _itemSize
        desc = _desc
        keyType = _keyType
    }
    
    public init(_title:String,_code:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize) {
        title = _title
        groups = _groups
        type = _type
        itemSize = _itemSize
        code = _code
    }
    
    public init(_title:String,_placeholder:String,_desc:String,_descs:[String],_place:String,_places:[String],_image:String,_type:entryType,_keyType:entryKeyType) {
        title = _title
        placeholder = _placeholder
        desc = _desc
        descs = _descs
        place = _place
        places = _places
        image = _image
        type = _type
        keyType = _keyType
    }
    
    public init(_title:String,_code:String,_placeholder:String,_desc:String,_descs:[String],_place:String,_places:[String],_image:String,_type:entryType,_keyType:entryKeyType) {
        title = _title
        placeholder = _placeholder
        desc = _desc
        descs = _descs
        place = _place
        places = _places
        image = _image
        type = _type
        keyType = _keyType
        code = _code
    }
    
}


extension String {
    // MARK: - 长度
    public var length:Int {
        return distance(from: startIndex, to: endIndex)
    }
}
