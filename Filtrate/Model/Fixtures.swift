//
//  Fixtures.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/7/25.
//

import Foundation
import HandyJSON

struct FixturesModel : Hashable {
    var display:NSInteger? // 0 图片 1 视频
    var url:String?
    var index:Int?
    var iSeek:Bool?
    
}

struct FixturesCardModel : Hashable {
    var title:String?
    var desc:String?
    var url:String?
}

struct FixturesShopModel : HandyJSON, Hashable {
    var id:String?
    var shopName:String? //店铺名称（不允许修改
    var shopItem:String? //特色标签
    var videoUrl:String? //视频路径
    var urls:[String]? //轮播图
    var shopPromotion:String? //促销活动图片
    var shopTel:String?
    
}

struct FixturesCompanysModel : HandyJSON, Hashable {
    var id:String?
    var companyTime:String? //成立时间
    var companyScale:String? //公司规模
    var companyExpertise:String? //专长
    var companyService:String? //服务区域
    var companyHours:String? //营业时间
    var companyInfo:String? //公司介绍
    var companyAddress:String? //公司地址
}

struct FixturesCompanyItemsModel : HandyJSON, Hashable {
 
    var id:String?
    var itemActivity:String? //活动营销
    var itemCommitment:String? //商家承诺
    var itemService:String? //商家服务
}

struct FixturesCompanyInformationsModel : HandyJSON, Hashable {
 
    var businessLicenseUrls:[String]? //经营信息
    var honoraryQualificationUrls:[String]? //荣誉资质
}


struct FixturesCompanyFacilitiesModel : HandyJSON, Hashable {
    var id:String?
    var facilitiesSpace:String? //停车位
    var facilitiesEquipment:String? //电子设备
    var facilitiesGeneral:String?//通用设施
}

struct FixturesMealsModel : HandyJSON, Hashable {
    var records:[MealsModel]?
    var total:Int?
}

struct FixturesProductsModel : HandyJSON, Hashable {
    var productTitle:String?//产品头部图片
    var productBackground:String?//产品背景图
}

struct MealsModel : HandyJSON, Hashable {
    var mealName:String? //套餐名称
    var mealPrice:String? //套餐起价
    var mealStatus:Int? //套餐状态
    var updateTime:String? //添加时间
    var mealArea:String?//套餐面积
    var mealItem:String? //套餐特色
    var mealContent:String? //套餐内容
    var id:String?
    var urls:[MealsUrl]?//套餐图片
    var headerUrls:[MealsUrl]?//轮播套餐图片
    var url:String? //套餐封面图
    var flagCoverUrl:String? //套餐封面图
    
}

struct MealsData : HandyJSON, Hashable {
    var code:Int?
    var data:[MealsUrl]?
    var message:String?
}


struct MealsUrl : HandyJSON, Hashable {
    var imageType:String?//图片类型
    var imageDescribe:String?//图片描述
    var flagCover:String?//是否封面 0否；1:是
    var flagRotation:String? //0否；1:是
    var imageUrl:String? //图片全路径
}


struct FixturesCaseModel : HandyJSON, Hashable {
    var records:[CaseModel]?
    var total:Int?
}

struct CaseModel : HandyJSON, Hashable {
    var caseTitle:String? //案例标题
    var caseSpend:String? //案例花费
    var caseType:String? //案例户型
    var caseStatus:Int? //案例状态(是否禁用) 0否；1:是
    var updateTime:String? //添加时间
    var caseArea:String?//案例面积
    var caseStyle:String? //案例风格
    var caseAddress:String? //案例地址
    var id:String?
    var urls:[MealsUrl]?//套餐图片
    var headerUrls:[MealsUrl]?//轮播套餐图片
    var caseItem:String?//特色标签
    var caseItemString:String?//特色标签
    var url:String? //套餐封面图
    var flagCoverUrl:String? //套餐封面图
    
}

class FixturesAlerModel: HandyJSON {
    required init() {}
    var priceList:[CustorData]?
    var areaList:[CustorData]?
    var typeList:[CustorData]?
    var styleList:[CustorData]?
    var sortList:[CustorData]?
    
}

//class PriceList:HandyJSON {
//    required init() {}
//    var dicDataCode:String?//字典Code
//    var dicDataName:String?//字典名称
//    var minValue:String?
//    var maxValue:String?
//    var iSele:Bool = false
//}

//class FixAreaList:HandyJSON {
//    required init() {}
//    var dicDataCode:String?//字典Code
//    var dicDataName:String?//字典名称
//
//    var iSele:Bool = false
//}

//class TypeList:HandyJSON {
//    required init() {}
//    var dicDataCode:String?//字典Code
//    var dicDataName:String?//字典名称
//    var iSele:Bool = false
//}
//
//class StyleList:HandyJSON {
//    required init() {}
//    var dicDataCode:String?//字典Code
//    var dicDataName:String?//字典名称
//    var iSele:Bool = false
//}
//
//class SortList:HandyJSON {
//    required init() {}
//    var dicDataCode:String?//字典Code
//    var dicDataName:String?//字典名称
//    var iSele:Bool = false
//}

struct FixturesDesignersModel : HandyJSON, Hashable {
    var records:[DesignersModel]?
    var total:Int?
}

struct DesignersModel:HandyJSON,Hashable {
    
    var id:String?//系统id
    var designerName:String?//设计师名称
    var designerLevel:String? //设计师级别
    var designerYears:String? //从业年限
    var designerStatus:String? //状态（是否禁用；0：否；1:是）
    var updateTime:String? //添加时间
    var designerType:String? //擅长类型
    var designerStyle:String? //设计风格
    var designerPhoto:String? //头像
    var designerBackground:String? //背景图
    var designerCases:[DesignerCases]? //装修案例
    var caseCount:String? //案例作品数量
    var dictVOList:[DictVOList]?
    
}

struct DesignerCases:HandyJSON ,Hashable{
    var caseId:String? //案例唯一标识
    var url:String? //案例封面图地址
}

struct DictVOList:HandyJSON ,Hashable{
    var dicLabel:String?
    var dicValue:String?
}


struct FixturesTeamsModel : HandyJSON, Hashable {
    var records:[TeamsModel]?
    var total:Int?
}

struct TeamsModel:HandyJSON,Hashable {
    var id:String?//系统id
    var teamName:String?//施工队长
    var teamJob:String? //职务 （字典值）
    var teamYears:String? //从业年限
    var mealStatus:String? //状态（是否禁用；0：否；1:是）
    var updateTime:String? //添加时间
    var teamPhoto:String? //头像
    var teamBackground:String? //背景图
    var teamResume:String?//个人简介
    
}

struct Facilities:HandyJSON {
    var id:String?//系统id
    var facilitiesSpace:String? //停车位
    var facilitiesEquipment:String? //电子设备
    var facilitiesGeneral:String? //通用设施
}

struct Informations:HandyJSON {
    var id:String?//系统id
    var businessLicenseUrls:String? //停车位
    var honoraryQualificationUrls:String? //电子设备
}

struct ItemsModel:HandyJSON {
    var id:String?//系统id
    var itemActivity:String? //活动营销
    var itemCommitment:String? //商家承诺
    var itemService:String? //商家服务
}

struct ShopsModel:HandyJSON {
    var id:String?//系统id
    var shopName:String? //店铺名称（不允许修改）
    var shopItem:String? //特色标签
    var videoUrl:String? //视频路径
    var urls:[String]? //轮播图
    var shopPromotion:String? //促销活动图片
    
}



