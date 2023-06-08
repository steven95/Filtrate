//
//  JuAddThreeFiltrate.swift
//  JuYao
//
//  Created by 挖坑小能手 on 2022/11/23.
//

import Foundation

public struct JIndexPath: Hashable {
    var left :Int?
    var cen  :Int?
    var right:Int?
    
    init(_left:Int,_cen:Int,_right:Int){
        left = _left
        cen = _cen
        right = _right
    }
}

class AddthreeFiltrateTabview: UIView {

    var lArray:[FiltrateModel] = []
    private var _leftArray:[FiltrateModel] = []
    public   var  leftArray:[FiltrateModel] {
          get {
              return _leftArray
          }
          set {
              _leftArray = newValue
              lArray = newValue
              leftTableView.delegate = self
              leftTableView.dataSource = self
              leftTableView.reloadData()
          }
    }
    var cArray:[FiltrateModel] = []
    private var _centerArray:[FiltrateModel] = []
    public   var  centerArray:[FiltrateModel] {
          get {
              return _centerArray
          }
          set {
              _centerArray = newValue
              cArray = newValue
              centerTableView.delegate = self
              centerTableView.dataSource = self
              centerTableView.reloadData()
          }
    }
    
    var rArray:[FiltrateModel] = []
    private var _rightArray:[FiltrateModel] = []
    public   var  rightArray:[FiltrateModel] {
          get {
              return _rightArray
          }
          set {
              _rightArray = newValue
              rArray = newValue
              rightTableView.delegate = self
              rightTableView.dataSource = self
              rightTableView.reloadData()
          }
    }
    
    private  var  leftModel:FiltrateModel = FiltrateModel.init()
    private  var  cenModel:FiltrateModel = FiltrateModel.init()
    private  var  rightModel:FiltrateModel = FiltrateModel.init()
    
    open lazy var leftTableView: UITableView = {
        let leftTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        leftTableView.register(FiltrateTabCell.self, forCellReuseIdentifier: "FiltrateTabCell")
        leftTableView.separatorStyle = .none
        leftTableView.showsHorizontalScrollIndicator = false
        leftTableView.showsVerticalScrollIndicator = false
        return leftTableView
    }()
    
    private   lazy var centerTableView: UITableView = {
        let centerTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        centerTableView.separatorStyle = .none
        centerTableView.register(FiltrateTabCell.self, forCellReuseIdentifier: "FiltrateTabCell")
        centerTableView.showsHorizontalScrollIndicator = false
        centerTableView.showsVerticalScrollIndicator = false
        centerTableView.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
        return centerTableView
    }()
    
    private lazy var rightTableView: UITableView = {
        let rightTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        rightTableView.separatorStyle = .none
        rightTableView.register(FiltrateTabCell.self, forCellReuseIdentifier: "FiltrateTabCell")
        rightTableView.showsHorizontalScrollIndicator = false
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
        return rightTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        // 默认选中左侧第一个, 不触发代理方法
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        addSubview(leftTableView)
        addSubview(centerTableView)
        addSubview(rightTableView)
        
        leftTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)

        }
        
        centerTableView.snp.makeConstraints { (make) in
            make.left.equalTo(leftTableView.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(centerTableView.snp.right)
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)
        }
    }
    
    open func returnBlock(_ callback: @escaping( _ iPaths:[IndexPath],_ filtrates: [[FiltrateModel]]?) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( ( _ iPaths:[IndexPath], _ filtrates: [[FiltrateModel]]?) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  seleType( _ array:[FiltrateModel] ) -> iSeleType {
        var ma :[FiltrateModel] = []
        var mc :[FiltrateModel] = []
        var mn :[FiltrateModel] = []
        for (_,ml) in array.enumerated() {
            if ml.iSeleType == .all {
                ma.append(ml)
            }else if ml.iSeleType == .cen {
                mc.append(ml)
            }else{
                mn.append(ml)
            }
        }
        if ma.count == array.count {
            return .all
        }else if mn.count == array.count {
            return .none
        }else {
            return  .cen
        }
    }
    
    var leftPath = IndexPath.init(row: 0, section: 0)
    var centerPath = IndexPath.init(row: 0, section: 0)
    var rightPath = IndexPath.init(row: 0, section: 0)
    
}

extension AddthreeFiltrateTabview: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return lArray.count
        }
      else  if tableView == centerTableView {
            return cArray.count
        }
       else {
            return rArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltrateTabCell", for: indexPath) as! FiltrateTabCell
        cell.selectionStyle = .none
        cell.returnBlock { [weak self] in
            guard let uSelf = self  else { return }
            if tableView == uSelf.leftTableView {
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath],[uSelf.lArray])
                }
                uSelf.leftPath = IndexPath(row: indexPath.row, section: indexPath.section)
                uSelf.leftModel = uSelf.lArray[uSelf.leftPath.row]
                uSelf.leftModel.iSeleType = uSelf.seleType(uSelf.rArray) == .all &&  uSelf.seleType(uSelf.cArray) == .all  ? .all :  uSelf.seleType(uSelf.rArray) == .cen ||  uSelf.seleType(uSelf.cArray) == .cen ? .cen : iSeleType.none
                if uSelf.leftModel.iSeleType == .all {
                    uSelf.leftModel.iSele = true
                    uSelf.leftModel.iSeleType = iSeleType.none
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = iSeleType.none
                    }
                    uSelf.cArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = iSeleType.none
                    }
                }else if uSelf.leftModel.iSeleType == .cen{
                    uSelf.leftModel.iSele = true
                    uSelf.leftModel.iSeleType = .all
                    uSelf.rightArray = []
                    uSelf.rArray = uSelf.rightArray
                    uSelf.cArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = iSeleType.all
                    }
                }else{
                    uSelf.leftModel.iSele = true
                    uSelf.leftModel.iSeleType = .all
                    uSelf.rightArray = []
                    uSelf.rArray = uSelf.rightArray
                    uSelf.cArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = iSeleType.all
                    }
                }
                uSelf.leftModel.iSeleType =  uSelf.seleType(uSelf.cArray) == .all  ? .all :  uSelf.seleType(uSelf.cArray) == .cen ? .cen : iSeleType.none
                uSelf.lArray[uSelf.leftPath.row] = uSelf.leftModel
                if uSelf.leftModel.iSeleType == .all {
                    uSelf.cArray.forEach { model in
                        model.iSeleType = .all
                    }
                }
                uSelf.rightTableView.reloadData()
                tableView.reloadData()
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath],[uSelf.lArray])
                }
                uSelf.centerArray = uSelf.cArray
                uSelf.centerTableView.reloadData()
                
            }else  if tableView == uSelf.centerTableView {
                uSelf.centerPath = IndexPath(row: indexPath.row, section: indexPath.section)
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath,uSelf.centerPath],[uSelf.lArray,uSelf.cArray])
                }
                uSelf.cenModel = uSelf.cArray[uSelf.centerPath.row]
                uSelf.cenModel.iSeleType = uSelf.seleType(uSelf.rArray)
                uSelf.cArray.forEach { model in
                    model.iSele = false
                }
                uSelf.cenModel.iSele = true
                if uSelf.cenModel.iSeleType == .all {
                    uSelf.cenModel.iSeleType = iSeleType.none
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = iSeleType.none
                    }
                }else if uSelf.cenModel.iSeleType == .cen{
                    uSelf.cenModel.iSeleType = .all
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = .all
                    }
                }else{
                    uSelf.cenModel.iSeleType = .all
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSeleType = .all
                    }
                }
                uSelf.cenModel.iSeleType = uSelf.seleType(uSelf.rArray)
                uSelf.leftModel = uSelf.lArray[uSelf.leftPath.row]
                uSelf.leftModel.iSeleType =  uSelf.seleType(uSelf.cArray) == .all  ? .all :   uSelf.seleType(uSelf.cArray) == .cen ? .cen : iSeleType.none
                uSelf.lArray[uSelf.leftPath.row] = uSelf.leftModel
                uSelf.leftArray = uSelf.lArray
                uSelf.leftTableView.reloadData()
                tableView.reloadData()
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath,uSelf.centerPath],[uSelf.lArray,uSelf.cArray])
                }
                uSelf.rightTableView.reloadData()
               
            }else{
                uSelf.rightPath = IndexPath(row: indexPath.row, section: uSelf.centerPath.row)
                uSelf.rArray = uSelf.rightArray
                uSelf.rightModel = uSelf.rArray[uSelf.rightPath.row]
                if uSelf.rightModel.iSele {
                    uSelf.rightModel.iSele = false
                    uSelf.rightModel.iSeleType = iSeleType.none
                }else{
                    uSelf.rightModel.iSele = true
                    uSelf.rightModel.iSeleType = .all
                }
                uSelf.rArray[uSelf.rightPath.row] = uSelf.rightModel
                uSelf.rightTableView.reloadData()
                uSelf.cenModel = uSelf.cArray[uSelf.centerPath.row]
                uSelf.cenModel.iSeleType = uSelf.seleType(uSelf.rArray)
                uSelf.cArray[uSelf.centerPath.row] = uSelf.cenModel
                uSelf.centerTableView.reloadData()
                uSelf.leftModel = uSelf.lArray[uSelf.leftPath.row]
                uSelf.leftModel.iSeleType =    uSelf.seleType(uSelf.cArray) == .all  ? .all :  uSelf.seleType(uSelf.cArray) == .cen ? .cen : iSeleType.none
                uSelf.lArray[uSelf.leftPath.row] = uSelf.leftModel
                uSelf.leftTableView.reloadData()
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath,uSelf.centerPath,uSelf.rightPath],[uSelf.lArray,uSelf.cArray,uSelf.rArray])
                }
            }
        }
        if tableView == leftTableView {
            if lArray.count > indexPath.row {
                cell.setupUI(filtrateModel: lArray[indexPath.row])
            }
            return cell
        }
        
        if tableView == centerTableView
        {
            if cArray.count > indexPath.row {
                cell.setupUI(filtrateModel: cArray[indexPath.row])
            }
            return cell
        }
        
        if tableView == rightTableView
        {
            if rArray.count > indexPath.row {
                cell.setupUI(filtrateModel: rArray[indexPath.row])
            }
            return cell
        }

        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            leftPath = IndexPath(row: indexPath.row, section: indexPath.section)
            if returnAction != nil {
                returnAction?([leftPath],[lArray])
            }
            lArray.forEach { model in
                model.iSele = false
            }
            lArray[leftPath.row].iSele = true
            tableView.reloadData()
            cArray =  centerArray
            cArray.forEach { model in
                model.iSele = true
            }
            leftModel = lArray[leftPath.row]
            if leftModel.iSeleType == .all {
                cArray.forEach { model in
                    model.iSeleType = .all
                }
            }
            centerTableView.delegate = self
            centerTableView.dataSource = self
            centerTableView.reloadData()
            rightArray = []
            rArray = rightArray
            rightTableView.delegate = self
            rightTableView.dataSource = self
            rightTableView.reloadData()
        } else  if tableView == centerTableView {
            centerPath = IndexPath(row: indexPath.row, section: leftPath.row)
            cArray = centerArray
            rArray = rightArray
            rightTableView.delegate = self
            rightTableView.dataSource = self
            cenModel = cArray[centerPath.row]
            cArray.forEach { model in
                model.iSele = false
            }
            cenModel.iSele = true
            if cenModel.iSeleType == .all {
                rArray.forEach { model in
                    model.iSeleType = .all
                }
            }
            tableView.reloadData()
            if returnAction != nil {
                returnAction?([leftPath,centerPath],[lArray,cArray])
            }
            rightTableView.reloadData()
        }else{
            rightPath = IndexPath(row: indexPath.row, section: centerPath.row)
            rArray = rightArray
            rightModel = rArray[rightPath.row]
            if rightModel.iSele {
                rightModel.iSele = false
                rightModel.iSeleType = iSeleType.none
            }else{
                rightModel.iSele = true
                rightModel.iSeleType = .all
            }
            rArray[rightPath.row] = rightModel
            tableView.reloadData()
            cenModel = cArray[centerPath.row]
            cenModel.iSeleType = seleType(rArray)
            cArray[centerPath.row] = cenModel
            centerTableView.reloadData()
            leftModel = lArray[leftPath.row]
            leftModel.iSeleType =    seleType(cArray) == .all  ? .all :  seleType(cArray) == .cen ? .cen : iSeleType.none
            lArray[leftPath.row] = leftModel
            leftTableView.reloadData()
            if returnAction != nil {
                returnAction?([leftPath,centerPath,rightPath],[lArray,cArray,rArray])
            }
        }
    }
}

private let JuAddFiltrateInstance = JuAddThreeFiltrate()

class JuAddThreeFiltrate: NSObject {
  
    class var shared : JuAddThreeFiltrate {
        return JuAddFiltrateInstance
    }
    
    open func returnShowBlock(_ callback: @escaping (_ show:String) -> Void) {
        returnShowAction = callback
    }
    private  var returnShowAction: ( (_ show:String) -> Void)?
    
    private func returnRegionBlock(_ callback: @escaping ( _ iPaths:[IndexPath], _ filtrates: [[FiltrateModel]]?) -> Void) {
        returnRegionAction = callback
    }
    private  var returnRegionAction: ( (_ iPaths:[IndexPath], _ filtrates: [[FiltrateModel]]?) -> Void)?
    
    open func returnBlock(_ callback: @escaping (_ isY:Bool) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (_ isY:Bool) -> Void)?
    
    open func returnMissBlock(_ callback: @escaping (_ lefts: [FiltrateModel],_ cens: [[FiltrateModel]],_ rights: [[[FiltrateModel]]]) -> Void) {
        returnMissAction = callback
    }
    
    private  var returnMissAction: ( (_ lefts: [FiltrateModel],_ cens: [[FiltrateModel]],_ rights: [[[FiltrateModel]]]) -> Void)?
    
    open func returnOkBlock(_ callback: @escaping (_ groupStrs:[String] , _ groupPaths:[JIndexPath]) -> Void) {
        returnOkAction = callback
    }
    private  var returnOkAction: ( (_ groupStrs:[String] , _ groupPaths:[JIndexPath]) -> Void)?
    
    open lazy var footV : MineBrokerFootV = {
        let footV = MineBrokerFootV.init(frame: CGRect.zero)
        footV.backgroundColor = .white
        footV.setupUI(brokerType: .exclusive)
        footV.goBtn.setTitle("确 认", for: .normal)
        footV.goBtn2.setTitle("重 置", for: .normal)
        footV.onButtonClick {  [weak self] (type) in
            guard let uSelf = self  else { return }
            if uSelf.returnOkAction != nil {
                uSelf.returnOkAction!(uSelf.groupStrs , uSelf.groupPaths)
            }
            uSelf.dismissView()
        }
        footV.onButton2Click { [weak self] (type) in
            guard let uSelf = self  else { return }
            if uSelf.returnMissAction != nil {
                uSelf.reSet(lefts: uSelf.lefts, cens: uSelf.cens, rights: uSelf.rights)
                uSelf.returnMissAction!(uSelf.lefts,uSelf.cens,uSelf.rights)
            }
            uSelf.dismissView()
        }
        return footV
    }()
    
    func reSet(lefts: [FiltrateModel], cens: [[FiltrateModel]], rights: [[[FiltrateModel]]])  {
        var ls:[FiltrateModel] = []
        lefts.forEach { model in
            let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .left, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType:  .none)
            ls.append(ml)
        }
        self.lefts = ls
        
        var cs:[[FiltrateModel]] = []
        cens.forEach { ms in
            var css:[FiltrateModel] = []
            ms.forEach { model in
                let ml = FiltrateModel.init(_title: model.title  ?? "", _code: model.code  ?? "", _type: model.type ?? .cen, _iSele: model.iSele, _iSmage: model.iSmage,_iSeleType: .none)
                css.append(ml)
            }
             cs.append(css)
        }
        
        self.cens = cs
        
        var rs:[[[FiltrateModel]]] = []
        rights.forEach { ms in
            var rss:[[FiltrateModel]] = []
            ms.forEach { md in
                var rsss:[FiltrateModel] = []
                md.forEach { model in
                    let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .right, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType:  .none)
                    rsss.append(ml)
                }
                rss.append(rsss)
            }
             rs.append(rss)
        }
        
        self.rights = rs
    }
    
    open lazy var filtrateTabview : AddthreeFiltrateTabview = {
        let filtrateTabview = AddthreeFiltrateTabview.init(frame: CGRect.zero)
        unowned let uSelf = self
        filtrateTabview.returnBlock {[weak self](iPaths, filtrates) in
            guard let uSelf = self  else { return }
            if uSelf.returnRegionAction != nil {
                uSelf.returnRegionAction!(iPaths,filtrates)
            }
        }
        return filtrateTabview
    }()
    
    open lazy var topview : topFiltrateTabview = {
        let topview = topFiltrateTabview.init(frame: CGRect.zero)
       
        topview.dismissBlock {[weak self]  in
            guard let uSelf = self  else { return }
            if uSelf.returnMissAction != nil {
                uSelf.reSet(lefts: uSelf.lefts, cens: uSelf.cens, rights: uSelf.rights)
                uSelf.returnMissAction!(uSelf.lefts,uSelf.cens,uSelf.rights)
            }
            uSelf.dismissView()
        }
        return topview
    }()
    
    open lazy var botView : UIView = {
        let botView = UIView.init()
        botView.backgroundColor = .clear
        return botView
    }()

    open lazy var bgView : UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = FSHexColor(Hex: 0x000000, alpha: 0.1).withAlphaComponent(0.1)
        return bgView
    }()
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.3, animations: {
            JuAddThreeFiltrate.shared.bgView.alpha = 0
        }) { (true) in
            JuAddThreeFiltrate.shared.bgView.isHidden = true
        }
    }
    
    private var _cens:[[FiltrateModel]] = []
    public   var  cens:[[FiltrateModel]] {
          get {
              return _cens
          }
          set {
              _cens = newValue
          }
    }
    
    private var _rights:[[[FiltrateModel]]] = []
    public   var  rights:[[[FiltrateModel]]] {
          get {
              return _rights
          }
          set {
              _rights = newValue
          }
    }
    
    private var _lefts:[FiltrateModel] = []
    public   var  lefts:[FiltrateModel] {
          get {
              return _lefts
          }
          set {
              _lefts = newValue
          }
    }
    
    private var _groupStrs:[String] = []
    public   var  groupStrs:[String] {
          get {
              return _groupStrs
          }
          set {
              _groupStrs = newValue
          }
    }
    
    private var _groupPaths:[JIndexPath] = []
    public   var  groupPaths:[JIndexPath] {
          get {
              return _groupPaths
          }
          set {
              _groupPaths = newValue
          }
    }
    
    func deleCell(lefts: [FiltrateModel],cens: [[FiltrateModel]],rights: [[[FiltrateModel]]], groupStrs:[String],
                  groupPaths:[JIndexPath] ,_ indexP:IndexPath?) {
        let iPath = groupPaths[indexP?.row ?? 0]
        if (iPath.right ?? 0) == 10086 {
            for (index,model) in lefts.enumerated() {
                if index == (iPath.left ?? 0) {
                    model.iSeleType = iSeleType.none
                    for (inx,mo) in cens[iPath.left ?? 0].enumerated() {
                        mo.iSeleType = iSeleType.none
                        for (_,ml) in rights[iPath.left ?? 0][inx].enumerated() {
                            ml.iSeleType = iSeleType.none
                        }
                    }
                 }
            }
        }
        if (iPath.right ?? 0) == 10087 {
            for (index,model) in cens[iPath.left ?? 0].enumerated() {
                if index == iPath.cen ?? 0 {
                    model.iSeleType = iSeleType.none
                    for (_,mo) in rights.enumerated() {
                        for (_,ml) in mo[iPath.cen ?? 0].enumerated() {
                            ml.iSeleType = iSeleType.none
                            for (l,lo) in lefts.enumerated() {
                                if l == iPath.left ?? 0 {
                                    lo.iSeleType = filtrateTabview.seleType(cens[iPath.left ?? 0])
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if (iPath.left ?? 0) >= 10088 {
            for (_,m) in rights.enumerated() {
                for (_,ml) in m.enumerated() {
                    for (index,model) in ml.enumerated() {
                        if index == (iPath.right ?? 0) {
                            model.iSeleType = iSeleType.none
                            for (c,co) in cens[(iPath.left ?? 0) - 10088].enumerated(){
                                if c == iPath.cen {
                                    co.iSeleType = filtrateTabview.seleType(rights[(iPath.left ?? 0) - 10088][iPath.cen ?? 0])
                                }
                            }
                            for (l,lo) in lefts.enumerated(){
                                if l == (iPath.left ?? 0) - 10088 {
                                    lo.iSeleType = filtrateTabview.seleType(cens[(iPath.left ?? 0) - 10088])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    class func showThreeFiltrate(lefts: [FiltrateModel],cens: [[FiltrateModel]],rights: [[[FiltrateModel]]], groupStrs:[String],groupPaths:[JIndexPath]){
        var  lefts: [FiltrateModel] = lefts
        var  cens: [[FiltrateModel]] = cens
        var  rights: [[[FiltrateModel]]] = rights
        var groupStrs:[String]  = groupStrs
        var groupPaths:[JIndexPath]  = groupPaths
       
        var slefts:[FiltrateModel] = []
        var sces:[FiltrateModel] = []
        var srights:[FiltrateModel] = []
        
        JuAddThreeFiltrate.shared.returnRegionBlock { iPaths, filtrates in
            slefts.removeAll()
            sces.removeAll()
            srights.removeAll()
 if iPaths.count ==  1 { ///操作第一级**
                if cens.count > iPaths.first?.row ?? 0  {
                    JuAddThreeFiltrate.shared.centerArray = cens[iPaths.first?.row ?? 0 ]
                }
                lefts = filtrates?.first ?? []
                lefts.forEach { model in
                    if model.iSeleType == .all {
                        if !groupStrs.contains(model.title ?? ""){
                            groupStrs.append(model.title ?? "")
                           groupPaths.append(JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                            for (index,model) in cens[iPaths.first?.row ?? 0 ].enumerated() {
                                if groupStrs.contains( lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? ""){
                                    groupStrs.remove(element:lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                   groupPaths.remove(element: JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:index, _right: 10087))
                                }
                                for (i,m) in rights[iPaths.first?.row ?? 0 ].enumerated() {
                                    for (inx,ml) in m.enumerated() {
                                        if groupStrs.contains((lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "") + "-" + ml.title ?? ""){
                                            groupStrs.remove(element:(lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "") + "-" + ml.title ?? "")
                                           groupPaths.remove(element: JIndexPath.init(_left: 10088 + iPaths.first?.row ?? 0, _cen:i, _right: inx))
                                        }
                                    }
                                }
                            }
                        }
                    }else{
                        if groupStrs.contains(model.title ?? ""){
                            groupStrs.remove(element:  model.title ?? "")
                           groupPaths.remove(element: JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                        }
                    }
                }
 }else if  iPaths.count ==  2 {///操作第二级**
              if rights.count > iPaths.first?.row ?? 0 {
                 if rights[iPaths.first?.row ?? 0].count > iPaths.last?.row ?? 0 {
                      JuAddThreeFiltrate.shared.rightArray = rights[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0 ]
                  }
               }
                lefts = filtrates?.first ?? []
                cens[iPaths.first?.row ?? 0] = filtrates?.last ?? []
                if cens[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].iSeleType == .all {
                    if !groupStrs.contains(lefts[iPaths.first?.row ?? 0].title  + "-" + cens[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].title ?? ""){
                        groupStrs.append(lefts[iPaths.first?.row ?? 0].title  + "-" + cens[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].title ?? "")
                       groupPaths.append(JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:iPaths.last?.row ?? 0, _right: 10087))
                    }
                    for (inx,ml)  in rights[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].enumerated() {
                        let st = (lefts[iPaths.first?.row ?? 0].title  + "-" + cens[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].title ?? "")
                        if groupStrs.contains( st + "-" + ml.title ?? ""){
                            let str = (lefts[iPaths.first?.row ?? 0].title  + "-" + cens[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].title ?? "")
                            groupStrs.remove(element: str + "-" + ml.title ?? "")
                           groupPaths.remove(element:JIndexPath.init(_left: 10088 + iPaths.first?.row ?? 0, _cen:iPaths.last?.row ?? 0, _right: inx))
                        }
                    }
                }else{
                    groupStrs.remove(element:  lefts[iPaths.first?.row ?? 0].title ?? "")
                   groupPaths.remove(element: JIndexPath.init(_left:iPaths.first?.row ?? 0,  _cen:-1, _right: 10086))
                    for (index,model) in cens[iPaths.first?.row ?? 0 ].enumerated() {
                        if groupStrs.contains( lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "") && model.iSeleType != .all {
                            groupStrs.remove(element:lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                           groupPaths.remove(element:JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:index, _right: 10087))
                        }
                    }
                }
                 for (index,model) in lefts.enumerated() {
                     if index == iPaths.first?.row {
                         if model.iSeleType == .all {
                             if !groupStrs.contains(model.title ?? ""){
                                 groupStrs.append(model.title ?? "")
                                groupPaths.append(JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                                 for (index,mc) in cens[iPaths.first?.row ?? 0 ].enumerated() {
                                     if groupStrs.contains( lefts[iPaths.first?.row ?? 0].title  + "-" + mc.title ?? ""){
                                         groupStrs.remove(element:lefts[iPaths.first?.row ?? 0].title  + "-" + mc.title ?? "")
                                        groupPaths.remove(element:JIndexPath.init(_left: iPaths.first?.row ?? 0, _cen:index, _right: 10087))
                                     }
                                     for (inx,ml)  in rights[iPaths.first?.row ?? 0][iPaths.last?.row ?? 0].enumerated() {
                                         let st = lefts[iPaths.first?.row ?? 0].title  + "-" + mc.title ?? ""
                                         if groupStrs.contains( st +  "-" + ml.title ?? ""){
                                             let str = (lefts[iPaths.first?.row ?? 0].title  + "-" +  mc.title ?? "")
                                             groupStrs.remove(element:str + "-" + ml.title ?? "")
                                            groupPaths.remove(element:JIndexPath.init(_left: 10088 + iPaths.first?.row ?? 0, _cen:iPaths.last?.row ?? 0, _right: inx))
                                         }
                                     }
                                 }
                             }else{
                                 groupStrs.remove(element:  model.title ?? "")
                                groupPaths.remove(element: JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                             }
                         }
                     }
                 }
 }else{///操作第三级**
                lefts = filtrates?.first ?? []
                cens[iPaths.first?.row ?? 0 ] = filtrates?[1] ?? []
                rights[iPaths.first?.row ?? 0][iPaths[1].row] = filtrates?.last ?? []
                if lefts[iPaths.first?.row ?? 0].iSeleType == .all {
                    if !groupStrs.contains(lefts[iPaths.first?.row ?? 0].title ?? ""){
                        groupStrs.append(lefts[iPaths.first?.row ?? 0].title ?? "")
                       groupPaths.append(JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                        for (index,model) in cens[iPaths.first?.row ?? 0 ].enumerated() {
                        if groupStrs.contains( lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? ""){
                            groupStrs.remove(element:lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                           groupPaths.remove(element:JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:index, _right: 10087))
                        }
                        for (inx,ml)  in rights[iPaths.first?.row ?? 0][iPaths[1].row].enumerated() {
                            let st =  (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                            if groupStrs.contains( st + "-" + ml.title ?? ""){
                                let str = (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                groupStrs.remove(element: str +  "-" + ml.title ?? "")
                               groupPaths.remove(element:JIndexPath.init(_left:10088 + iPaths.first?.row ?? 0, _cen:iPaths[1].row, _right: inx))
                            }
                         }
                     }
                  }
                }else{
                    groupStrs.remove(element:  lefts[iPaths.first?.row ?? 0].title ?? "")
                   groupPaths.remove(element:JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen:-1, _right: 10086))
                    for (index,model) in cens[iPaths.first?.row ?? 0 ].enumerated() {
                        if model.iSeleType == .all {
                            if !groupStrs.contains(lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? ""){
                                groupStrs.append(lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                               groupPaths.append(JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen: index, _right: 10087 ))
                            }
                            for (inx,ml)  in rights[iPaths.first?.row ?? 0][iPaths[1].row].enumerated() {
                                let st = (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                if groupStrs.contains( st +  "-" + ml.title ?? ""){
                                    let str = (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                    groupStrs.remove(element:str + "-" + ml.title ?? "")
                                   groupPaths.remove(element:JIndexPath.init(_left: iPaths.first?.row ?? 0, _cen: inx, _right: 10087))
                                }
                            }
                        }else{
                            if groupStrs.contains( lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? ""){
                                groupStrs.remove(element:lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                               groupPaths.remove(element:JIndexPath.init(_left:iPaths.first?.row ?? 0, _cen: index, _right:10087))
                            }
                            for (inx,ml)  in rights[iPaths.first?.row ?? 0][iPaths[1].row].enumerated() {
                                let st  = (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                if !groupStrs.contains(st +  "-" + ml.title ?? ""){
                                    if ml.iSeleType == .all &&  model.iSeleType == .cen && index == iPaths[1].row {
                                        let str = (lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "")
                                        groupStrs.append( str + "-" + ml.title ?? "")
                                       groupPaths.append(JIndexPath.init(_left:10088 + iPaths.first?.row ?? 0, _cen: iPaths[1].row, _right: inx))
                                    }
                                }else{
                                    if ml.iSeleType != .all {
                                        groupStrs.remove(element:(lefts[iPaths.first?.row ?? 0].title  + "-" + model.title ?? "") + "-" + ml.title ?? "")
                                       groupPaths.remove(element:JIndexPath.init(_left:10088 + iPaths.first?.row ?? 0, _cen: iPaths[1].row, _right: inx))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            JuAddThreeFiltrate.shared.groupStrs  = groupStrs
            JuAddThreeFiltrate.shared.groupPaths  = groupPaths
            
            if JuAddThreeFiltrate.shared.returnAction != nil {
                JuAddThreeFiltrate.shared.returnAction!(groupStrs.count <= 0 )
            }
            
            JuAddThreeFiltrate.shared.leftArray.forEach { le in
                if le.iSeleType == .all || le.iSeleType == .cen  {
                    slefts.append(le)
                }
            }

            if slefts.count > 1 {
                if JuAddThreeFiltrate.shared.returnShowAction != nil {
                    JuAddThreeFiltrate.shared.returnShowAction!("多选")
                }
            }else if slefts.count == 1 &&  slefts.first?.iSeleType == .all {
                if JuAddThreeFiltrate.shared.returnShowAction != nil {
                    JuAddThreeFiltrate.shared.returnShowAction!(slefts.first?.title ?? "")
                }
            }else if slefts.count == 1 &&  slefts.first?.iSeleType == .cen {
                JuAddThreeFiltrate.shared.centerArray.forEach { ce in
                    if ce.iSeleType == .all || ce.iSeleType == .cen  {
                        sces.append(ce)
                    }
                }
                if sces.count > 1 {
                    if JuAddThreeFiltrate.shared.returnShowAction != nil {
                        JuAddThreeFiltrate.shared.returnShowAction!("多选")
                    }
                }else if sces.count == 1 &&  sces.first?.iSeleType == .all {
                    if JuAddThreeFiltrate.shared.returnShowAction != nil {
                        JuAddThreeFiltrate.shared.returnShowAction!(sces.first?.title ?? "")
                    }
                }else if sces.count == 1 &&  sces.first?.iSeleType == .cen {
                    JuAddThreeFiltrate.shared.rightArray.forEach { re in
                        if re.iSeleType == .all || re.iSeleType == .cen  {
                            srights.append(re)
                        }
                        if srights.count > 1 {
                            if JuAddThreeFiltrate.shared.returnShowAction != nil {
                                JuAddThreeFiltrate.shared.returnShowAction!("多选")
                            }
                        }else if srights.count == 1 &&  srights.first?.iSeleType == .all {
                            if JuAddThreeFiltrate.shared.returnShowAction != nil {
                                JuAddThreeFiltrate.shared.returnShowAction!(srights.first?.title ?? "")
                            }
                        }
                    }
                }
            }else{
                if JuAddThreeFiltrate.shared.returnShowAction != nil {
                    JuAddThreeFiltrate.shared.returnShowAction!("")
                }
            }
        }

        var ls:[FiltrateModel] = []
        lefts.forEach { model in
            let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .left, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType: model.iSeleType ?? .none)
            ls.append(ml)
        }
        JuAddThreeFiltrate.shared.lefts = ls
        
        JuAddThreeFiltrate.shared.leftArray = lefts
     
        var cs:[[FiltrateModel]] = []
        cens.forEach { ms in
            var css:[FiltrateModel] = []
            ms.forEach { model in
                let ml = FiltrateModel.init(_title: model.title  ?? "", _code: model.code  ?? "", _type: model.type ?? .cen, _iSele: model.iSele, _iSmage: model.iSmage,_iSeleType: model.iSeleType ?? .none)
                css.append(ml)
            }
             cs.append(css)
        }
        
        JuAddThreeFiltrate.shared.cens = cs
        if cens.count > JuAddThreeFiltrate.shared.filtrateTabview.leftPath.row {
            JuAddThreeFiltrate.shared.centerArray = cens[JuAddThreeFiltrate.shared.filtrateTabview.leftPath.row]
        }

        var rs:[[[FiltrateModel]]] = []
        rights.forEach { ms in
            var rss:[[FiltrateModel]] = []
            ms.forEach { md in
                var rsss:[FiltrateModel] = []
                md.forEach { model in
                    let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .right, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType: model.iSeleType ?? .none)
                    rsss.append(ml)
                }
                rss.append(rsss)
            }
             rs.append(rss)
        }
        
        JuAddThreeFiltrate.shared.rights = rs
        if rights.count > JuAddThreeFiltrate.shared.filtrateTabview.leftPath.row && rights[JuAddThreeFiltrate.shared.filtrateTabview.leftPath.row].count > JuAddThreeFiltrate.shared.filtrateTabview.centerPath.row {
            JuAddThreeFiltrate.shared.rightArray = rights[JuAddThreeFiltrate.shared.filtrateTabview.leftPath.row][JuAddThreeFiltrate.shared.filtrateTabview.centerPath.row]
        }

        UIView.animate(withDuration: 0.25, animations: {
             shared.filtrateTabview.alpha = 1
             shared.filtrateTabview.isHidden = false
             shared.footV.alpha = 1
             shared.footV.isHidden = false
         }, completion: nil)
    }
    
   class func showInWindow(lefts: [FiltrateModel],cens: [[FiltrateModel]],rights: [[[FiltrateModel]]], groupStrs:[String],
     groupPaths:[JIndexPath]){
       showThreeFiltrate(lefts: lefts, cens: cens, rights: rights, groupStrs: groupStrs, groupPaths: groupPaths)
    
       UIApplication.shared.keyWindow?.addSubview(shared.bgView)
       shared.bgView.addSubview(shared.botView)
       shared.bgView.addSubview(shared.topview)
       shared.bgView.addSubview(shared.filtrateTabview)
       shared.bgView.addSubview(shared.footV)
       shared.bgView.snp.remakeConstraints { make in
           make.left.top.equalToSuperview().offset(0)
           make.width.equalTo(UIScreen.main.bounds.size.width)
           make.height.equalTo(UIScreen.main.bounds.size.height)
       }
       shared.bgView.layoutIfNeeded()
       shared.footV.snp.remakeConstraints { make in
           make.left.right.bottom.equalToSuperview().offset(0)
           make.height.equalTo(FRPRealValue(84))
       }
       shared.footV.layoutIfNeeded()
       shared.footV.layer.shadowColor = FSHexColor(Hex: 0x000000, alpha: 0.16).cgColor
       shared.footV.layer.shadowOffset = CGSize(width: 0, height: -FRPRealValue(3))
       shared.footV.layer.shadowRadius = FRPRealValue(3)
       shared.footV.layer.shadowOpacity = 1
       shared.footV.layer.cornerRadius = FRPRealValue(5)

       shared.filtrateTabview.snp.remakeConstraints { make in
           make.left.right.equalToSuperview().offset(0)
           make.bottom.equalTo(shared.footV.snp_top).offset(0)
           make.height.equalTo(FRPRealValue(260))
       }
       shared.filtrateTabview.layoutIfNeeded()
       shared.topview.snp.makeConstraints { make in
           make.left.right.equalToSuperview().offset(0)
           make.height.equalTo(FRPRealValue(57.5))
           make.bottom.equalTo(shared.filtrateTabview.snp_top).offset(0)
       }
       shared.topview.layoutIfNeeded()
       shared.botView.snp.makeConstraints { make in
           make.left.top.right.equalToSuperview().offset(0)
           make.bottom.equalTo(shared.topview.snp_top).offset(0)
       }
       shared.botView.layoutIfNeeded()
       UIView.animate(withDuration: 0.25, animations: {
            shared.bgView.alpha = 1
           shared.bgView.isHidden = false
        }, completion: nil)
    }

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
              filtrateTabview.rightArray = newValue
          }
    }
}

extension Array where Element : Hashable {
    
    public mutating func remove(element: Element) {
        if let i = index(of: element) {
            remove(at: i)
        }
    }
    
}
