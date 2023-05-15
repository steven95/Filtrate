//
//  FiltrateModel.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/3/1.
//

import Foundation
import HandyJSON

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

enum iSeleType: Int {
    case none
    case cen
    case all
}

enum FilType: Int {
    case left
    case cen
    case right
    case sort
}

@objc enum FilTypeAler: Int {
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

class FiltrateModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
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

class CustorModel: HandyJSON {
    required init() {}
    var code:String?
    var data:[CustorData]?
    var message:String?
}

class FiltrateAlerModel: HandyJSON {
    required init() {}
    ////  Zfb
    var buildAreaList:[CustorData]? //建筑面积
    var featureList:[CustorData]? //房源特色
    var labelList:[CustorData]?
    var finishList :[CustorData]? //装修
    var floorList:[CustorData]? //楼层
    var layoutBedroomList :[CustorData]? //户型-室
    var layoutHallList:[CustorData]? //户型-厅
    var layoutToiletList:[CustorData]? //户型-卫
    var orientationList:[CustorData]? //房源朝向
    var regionList:[CustorData]?
    var layoutList:[CustorData]? //户型
    var sort:[CustorData]? //排序
    var sortList:[CustorData]?  //排序
    var totalPriceList:[CustorData]? //总价
    var houseAgeList:[CustorData]? //房龄
    var unitPriceList:[CustorData]?
    var dealCountSort:CustorData?
    var evaluateScoreSort:CustorData?
    var workYearSort:CustorData? //年限
    var houseTypeList:[CustorData]? //房屋类型（用途）
    var openDateList:[CustorData]? //开盘时间
    
    var saleStatusList:[CustorData]? //销售状态
    var drillOption:[CustorData]?
   /// Zfb
    var code:String?
    var data:filtrateData?
    var message:String?
}

struct filtrateData:HandyJSON {
    var saleStatusScreenList:[CustorData]? //销售状态
    var purposeScreenVOList:[CustorData]? //更多 用途对应类型的集合
    var priceScreenList:[CustorData]?  //单价
    var totalPriceScreenList:[CustorData]? //总价
    var layoutScreenList:[CustorData]?  //户型
    var areaScreenList:[CustorData]? //建筑面积
    var renovationScreenList:[CustorData]? //装修情况
    var openDateScreenList:[CustorData]? //开盘时间
    var featureScreenList:[CustorData]? //楼盘特色
    var ordList:[CustorData]? //排序
    var labelScreenList:[CustorData]? 
}


