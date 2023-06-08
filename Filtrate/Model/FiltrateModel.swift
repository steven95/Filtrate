//
//  FiltrateModel.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/1.
//

import Foundation
import HandyJSON

var user = UserCenter()
struct UserCenter {
    var validRegionData:CustorModel = CustorModel.init()
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
    
    required init() {}
    var title :String?
    var code :String?
    var iSele:Bool = false
    var iSeleType:iSeleType?
    var type :FilType?
    var filType :FilTypeAler?
    var iSmage:Bool = true
    
    init(_title:String,_filType:FilTypeAler){
        title = _title
        filType = _filType
    }

    init(_title:String,_code:String,_type:FilType,_iSele:Bool) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
    }
    
    init(_title:String,_code:String,_type:FilType,_iSele:Bool,_iSmage:Bool) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
        iSmage = _iSmage
    }
    
    init(_title:String,_code:String,_type:FilType,_iSele:Bool,_iSmage:Bool,_iSeleType:iSeleType) {
        title = _title
        iSele = _iSele
        type = _type
        code = _code
        iSmage = _iSmage
        iSeleType = _iSeleType
    }
    
    init(_title:String,_filType:FilTypeAler,_iSmage:Bool) {
        title = _title
        filType = _filType
        iSmage = _iSmage
    }
    
    init(_title:String,_filType:FilTypeAler,_iSele:Bool,_iSmage:Bool) {
        title = _title
        filType = _filType
        iSmage = _iSmage
        iSele = _iSele
    }
}

public class CustorModel: HandyJSON {
    required public init() {}
    var code:String?
    var data:[CustorData]?
    var message:String?
}

public class CustorData:HandyJSON,Equatable{
    public static func == (lhs: CustorData, rhs: CustorData) -> Bool {
        return false
    }
    
    var minValue:String?
    var maxValue:String?
    
    var max:String?
    var min:String?
    
    var dicDataCode:String?//字典Code
    var dicDataName:String?//字典名称
    
    var name:String?
    var label:String?
    
    var optionCode:String?
    var optionName:String?
    var code:String?
    
    var children:[CustorData]?
    var optionVOList:[CustorData]?
    
    var iSele:Bool = false
    var isSelect : Bool = false//自定义属性，个别涉及选择的位置使用
    
    var address:String?
    var text:String?
    var textWithoutHighlight:String?
    var value:String?
    
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
    var title : String?
    var iSele:Bool = false
    var iBorder:Bool = false
    var code:String?
    var max:String?
    var min:String?
    var color:String?
    
    init(_title:String,_iSele:Bool,_iBorder:Bool) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
    }
    
    init(_title:String,_code:String,_iSele:Bool,_iBorder:Bool) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
        code = _code
    }
    
    init(_title:String,_code:String,_iSele:Bool,_iBorder:Bool,_color:String) {
        title = _title
        iSele = _iSele
        iBorder = _iBorder
        code = _code
        color = _color
    }
    
    init(_title:String,_code:String,_min:String,_max:String,_iSele:Bool,_iBorder:Bool) {
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
    var title : String?
    var groups : NSMutableArray?
    var itemSize: CGSize?
    
    var placeholder : String?
    var desc : String?
    var descs : [String]?
    var place : String?
    var places : [String]?
    var image : String?
    var code:String?
    var type : entryType?
    var tagType : TagType?
    var keyType : entryKeyType?
    
    init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize) {
        title = _title
        groups = _groups
        type = _type
        itemSize = _itemSize
    }
    
    init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize,_places:[String],_image:String) {
        title = _title
        groups = _groups
        places = _places
        image = _image
        type = _type
        itemSize = _itemSize
    }
    
    init(_title:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize,_places:[String],_image:String,_desc:String,_keyType:entryKeyType) {
        title = _title
        groups = _groups
        places = _places
        image = _image
        type = _type
        itemSize = _itemSize
        desc = _desc
        keyType = _keyType
    }
    
    init(_title:String,_code:String,_groups:NSMutableArray,_type:entryType,_itemSize:CGSize) {
        title = _title
        groups = _groups
        type = _type
        itemSize = _itemSize
        code = _code
    }
    
    init(_title:String,_placeholder:String,_desc:String,_descs:[String],_place:String,_places:[String],_image:String,_type:entryType,_keyType:entryKeyType) {
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
    
    init(_title:String,_code:String,_placeholder:String,_desc:String,_descs:[String],_place:String,_places:[String],_image:String,_type:entryType,_keyType:entryKeyType) {
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
