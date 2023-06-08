//
//  JuAddFiltrate.swift
//  JuYao
//
//  Created by 挖坑小能手 on 2022/11/10.
//

import Foundation
import UIKit

class topFiltrateTabview: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        addSubview(titleL)
        addSubview(iconV)
    }
    
    override func layoutSubviews() {
        titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(FRPRealValue(20))
            make.centerY.equalToSuperview().offset(0)
        }
        iconV.snp.makeConstraints { make in
            make.centerY.equalTo(titleL.snp_centerY).offset(0)
            make.right.equalToSuperview().offset(-FRPRealValue(28))
            make.height.width.equalTo(FRPRealValue(22))
        }
    }
    
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .left
        titleL.font = UIFont.systemFont(ofSize: FRPRealValue(16))
        titleL.textColor = FSHexColor(Hex: 0x191D26, alpha: 1)
        titleL.numberOfLines = 1
        titleL.text = "选择意向区域"
        return titleL
    }()
    
    open lazy var iconV : UIImageView = {
        let iconV = UIImageView.init(image: UIImage.init(named: "del_right"))
        iconV.isUserInteractionEnabled = true
        iconV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click_iconV)))
        return iconV
    }()
    
    open func dismissBlock(_ callback: @escaping @convention(block) () -> Void) {
        dismissAction = callback
    }
    open  var dismissAction: ( (@convention(block) () -> Void))?
    
    @objc func click_iconV(){
        if dismissAction != nil {
            dismissAction!()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class AddFiltrateTabview: UIView {

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
    
    var rArray:[FiltrateModel] = []
    private var _rightArray:[FiltrateModel] = []
    public   var  rightArray:[FiltrateModel] {
          get {
              return _rightArray
          }
        set {
            _rightArray = newValue
            rArray = newValue
            rightTableView.snp.remakeConstraints { (make) in
                make.right.top.bottom.equalToSuperview()
                make.left.equalTo(leftTableView.snp.right)
            }
            rightTableView.layoutIfNeeded()
            rightTableView.isHidden = false
        }
    }
    
    private  var  leftModel:FiltrateModel = FiltrateModel.init()

    private  var  rightModel:FiltrateModel = FiltrateModel.init()
    
    open lazy var leftTableView: UITableView = {
        let leftTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        leftTableView.register(FiltrateTabCell.self, forCellReuseIdentifier: "FiltrateTabCell")
        leftTableView.separatorStyle = .none
        leftTableView.showsHorizontalScrollIndicator = false
        leftTableView.showsVerticalScrollIndicator = false
        return leftTableView
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
        addSubview(rightTableView)
        
        leftTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width / 3)

        }
        
        rightTableView.snp.remakeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(leftTableView.snp.right)
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
        if array.allSatisfy({ $0.iSele == true }) {
            return .all
        }else if array.allSatisfy({ $0.iSele == false }) {
            return .none
        }else{
            return .cen
        }
    }
    
    var leftPath = IndexPath.init(row: 0, section: 0)
    var centerPath = IndexPath.init(row: 0, section: 0)
    var rightPath = IndexPath.init(row: 0, section: 0)
    
}

extension AddFiltrateTabview: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return lArray.count
        }
       else {
            return rArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltrateTabCell", for: indexPath) as! FiltrateTabCell
       
        cell.selectionStyle = .none
        if tableView == leftTableView {
            if lArray.count > indexPath.row {
                cell.setupUI(filtrateModel: lArray[indexPath.row])
            }
            cell.returnBlock { [weak self] in
                guard let uSelf = self  else { return }
                uSelf.leftPath = IndexPath(row: indexPath.row, section: indexPath.section)
                uSelf.leftModel = uSelf.lArray[uSelf.leftPath.row]
                uSelf.leftModel.iSeleType = uSelf.seleType(uSelf.rArray)
                if uSelf.leftModel.iSeleType == .all {
                    uSelf.leftModel.iSeleType = iSeleType.none
                    uSelf.leftModel.iSele = false
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSele = false
                        filtrateModel.iSeleType = iSeleType.none
                    }
                }else{
                    uSelf.leftModel.iSele = true
                    uSelf.leftModel.iSeleType = .all
                    uSelf.rArray.forEach { filtrateModel in
                        filtrateModel.iSele = true
                        filtrateModel.iSeleType = .all
                    }
                }
                uSelf.leftModel.iSeleType = uSelf.seleType(uSelf.rArray)
                uSelf.lArray[uSelf.leftPath.row] = uSelf.leftModel
                uSelf.rightArray = uSelf.rArray
                uSelf.rightTableView.reloadData()
                tableView.reloadData()
                if uSelf.returnAction != nil {
                    uSelf.returnAction?([uSelf.leftPath],[uSelf.lArray,uSelf.rArray])
                }
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
            rArray = rightArray
            rightTableView.delegate = self
            rightTableView.dataSource = self
            lArray.forEach { model in
                model.iSele = false
            }
            lArray[leftPath.row].iSeleType = seleType(rArray)
            if lArray[leftPath.row].iSeleType == .all {
                lArray[leftPath.row].iSele = true
                rArray.forEach { filtrateModel in
                    filtrateModel.iSele = true
                    filtrateModel.iSeleType = .all
                }
            }else if leftModel.iSeleType == .cen{
                leftModel.iSele = true
            }
            else{
                lArray[leftPath.row].iSele = true
                lArray[leftPath.row].iSeleType = iSeleType.none
                rArray.forEach { filtrateModel in
                    filtrateModel.iSele = false
                    filtrateModel.iSeleType = iSeleType.none
                }
            }
            tableView.reloadData()
            rightTableView.reloadData()
     
        }else{
          
            rightPath = IndexPath(row: indexPath.row, section: leftPath.row)
           
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
            
            leftModel = lArray[leftPath.row]
            leftModel.iSeleType = seleType(rArray)
            if leftModel.iSeleType == iSeleType.none {
                leftModel.iSele = false
            }else{
                leftModel.iSele = true
            }
            lArray[leftPath.row] = leftModel
            leftTableView.reloadData()
            if returnAction != nil {
                returnAction?([leftPath,rightPath],[lArray,rArray])
            }
        }
    }
}

private let JuAddFiltrateInstance = JuAddFiltrate()

class JuAddFiltrate: NSObject {
  
    class var shared : JuAddFiltrate {
        return JuAddFiltrateInstance
    }
    
    open func returnRegionBlock(_ callback: @escaping ( _ iPaths:[IndexPath], _ filtrates: [[FiltrateModel]]?) -> Void) {
        returnRegionAction = callback
    }
    private  var returnRegionAction: ( (_ iPaths:[IndexPath], _ filtrates: [[FiltrateModel]]?) -> Void)?
    
    
    open func returnMissBlock(_ callback: @escaping (_ lefts: [FiltrateModel],_ rights: [[FiltrateModel]]) -> Void) {
        returnMissAction = callback
    }
    private  var returnMissAction: ( (_ lefts: [FiltrateModel],_ rights: [[FiltrateModel]]) -> Void)?
    
    open func returnOkBlock(_ callback: @escaping () -> Void) {
        returnOkAction = callback
    }
    private  var returnOkAction: ( () -> Void)?
    
    
    open lazy var footV : MineBrokerFootV = {
        let footV = MineBrokerFootV.init(frame: CGRect.zero)
        footV.backgroundColor = .white
        footV.setupUI(brokerType: .exclusive)
        footV.goBtn.setTitle("确 认", for: .normal)
        footV.goBtn2.setTitle("取 消", for: .normal)
        footV.onButtonClick {  [weak self] (type) in
            guard let uSelf = self  else { return }
            if uSelf.returnOkAction != nil {
                uSelf.returnOkAction!()
            }
            uSelf.dismissView()
        }
        footV.onButton2Click { [weak self] (type) in
            guard let uSelf = self  else { return }
            if uSelf.returnMissAction != nil {
                JuAddFiltrate.shared.rightArray = []
                uSelf.returnMissAction!(uSelf.lefts,uSelf.rights)
            }
            uSelf.dismissView()
        }
        return footV
    }()
    
    open lazy var filtrateTabview : AddFiltrateTabview = {
        let filtrateTabview = AddFiltrateTabview.init(frame: CGRect.zero)
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
                JuAddFiltrate.shared.rightArray = []
                uSelf.returnMissAction!(uSelf.lefts,uSelf.rights)
            }
            uSelf.dismissView()
        }
        return topview
    }()
    
    open lazy var botView : UIView = {
        let botView = UIView.init()
        botView.backgroundColor = .clear
        botView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        return botView
    }()

    open lazy var bgView : UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = FSHexColor(Hex: 0x000000, alpha: 0.1).withAlphaComponent(0.1)
        return bgView
    }()
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.3, animations: {
            JuAddFiltrate.shared.bgView.alpha = 0
        }) { (true) in
            JuAddFiltrate.shared.bgView.isHidden = true
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
    
    private var _rights:[[FiltrateModel]] = []
    public   var  rights:[[FiltrateModel]] {
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
              
              var ls:[FiltrateModel] = []
              _lefts.forEach { model in
                  let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .left, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType: model.iSeleType ?? .none)
                  ls.append(ml)
              }
              JuAddFiltrate.shared.leftArray = ls
          }
    }
    
   class func showInWindow(lefts: [FiltrateModel],rights: [[FiltrateModel]]){
        
       JuAddFiltrate.shared.lefts = lefts
       
       var rs:[[FiltrateModel]] = []
       rights.forEach { ms in
           var rss:[FiltrateModel] = []
           ms.forEach { model in
               let ml = FiltrateModel.init(_title: model.title ?? "", _code: model.code ?? "", _type: model.type ?? .right, _iSele: model.iSele , _iSmage: model.iSmage,_iSeleType: model.iSeleType ?? .none)
               rss.append(ml)
           }
            rs.append(rss)
       }
       
       JuAddFiltrate.shared.rights = rs
       
       UIApplication.shared.keyWindow?.addSubview(shared.bgView)
       shared.bgView.addSubview(shared.botView)
       shared.bgView.addSubview(shared.topview)
       shared.bgView.addSubview(shared.filtrateTabview)
       shared.bgView.addSubview(shared.footV)
       shared.bgView.snp.remakeConstraints { make in
           make.left.bottom.top.right.equalToSuperview().offset(0)
       }
       
       shared.footV.snp.remakeConstraints { make in
           make.left.right.bottom.equalToSuperview().offset(0)
           make.height.equalTo(FRPRealValue(84))
       }
       
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
       
       shared.topview.snp.makeConstraints { make in
           make.left.right.equalToSuperview().offset(0)
           make.height.equalTo(FRPRealValue(57.5))
           make.bottom.equalTo(shared.filtrateTabview.snp_top).offset(0)
       }
       
       shared.botView.snp.makeConstraints { make in
           make.left.top.right.equalToSuperview().offset(0)
           make.bottom.equalTo(shared.topview.snp_top).offset(0)
       }
       
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


