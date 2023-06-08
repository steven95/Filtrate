//
//  FiltrateTabview.swift
//  JuBao
//
//  Created by 挖坑小能手 on 2022/2/28.
//

import Foundation
import UIKit

open class FiltrateTabview: UIView {

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
              if cArray.count > 0 {
                  centerTableView.isHidden = false
              }
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
              if centerArray.count == 0 && rArray.count > 0 {
                  centerTableView.isHidden = true
                  rightTableView.snp.remakeConstraints { (make) in
                      make.right.top.bottom.equalToSuperview()
                      make.left.equalTo(leftTableView.snp.right)
                  }
                  rightTableView.layoutIfNeeded()
                  rightTableView.isHidden = false
              }else{
                  centerTableView.isHidden = false
                  rightTableView.isHidden = true
                  rightTableView.snp.remakeConstraints { (make) in
                      make.right.top.bottom.equalToSuperview()
                      make.left.equalTo(centerTableView.snp.right)
                  }
                  rightTableView.layoutIfNeeded()
              }
              rightTableView.delegate = self
              rightTableView.dataSource = self
              rightTableView.reloadData()
          }
    }
    
    private  var  leftModel:FiltrateModel = FiltrateModel.init()
    private  var  cenModel:FiltrateModel = FiltrateModel.init()
    private  var  rightModel:FiltrateModel = FiltrateModel.init()
    
    private lazy var leftTableView: UITableView = {
        let leftTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        leftTableView.register(FilTabCell.self, forCellReuseIdentifier: "FilTabCell")
        leftTableView.separatorStyle = .none
        leftTableView.showsHorizontalScrollIndicator = false
        leftTableView.showsVerticalScrollIndicator = false
        return leftTableView
    }()
    
    private   lazy var centerTableView: UITableView = {
        let centerTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        centerTableView.separatorStyle = .none
        centerTableView.register(FilTabCell.self, forCellReuseIdentifier: "FilTabCell")
        centerTableView.showsHorizontalScrollIndicator = false
        centerTableView.showsVerticalScrollIndicator = false
        centerTableView.backgroundColor = FSHexColor(Hex: 0xF8F9FA, alpha: 1)
        return centerTableView
    }()
    
    private lazy var rightTableView: UITableView = {
        let rightTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        rightTableView.separatorStyle = .none
        rightTableView.register(FilTabCell.self, forCellReuseIdentifier: "FilTabCell")
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
    
    func reSet()  {
        
        lArray.forEach { filtrateModel in
            filtrateModel.iSele = false
        }
        if lArray.count > 0 {
            leftModel = lArray[0]
            leftModel.iSele = true
            lArray[0] = leftModel
        }
        leftTableView.reloadData()
        cArray.removeAll()
        centerTableView.reloadData()
        
        rArray.removeAll()
        rightTableView.reloadData()
    }
    
    open func returnBlock(_ callback: @escaping( _ indexPath:IndexPath,_ filtrates: [FiltrateModel]?) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( ( _ indexPath:IndexPath, _ filtrates: [FiltrateModel]?) -> Void)?
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FiltrateTabview: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilTabCell", for: indexPath) as! FilTabCell
       
        cell.selectionStyle = .none
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            let indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
            if indexPath.row == 0 {
                cArray.removeAll()
            }else{
                cArray =  centerArray
            }
            if centerArray.count == 0 && rightArray.count > 0 {
                rArray = rightArray
                rightTableView.delegate = self
                rightTableView.dataSource = self
                rightTableView.reloadData()
                lArray.forEach { filtrateModel in
                    filtrateModel.iSele = false
                }
                leftModel = lArray[indexPath.row]
                leftModel.iSele = true
                lArray[indexPath.row] = leftModel
                tableView.reloadData()
                if returnAction != nil {
                    returnAction?(indexPath,[leftModel])
                }
            }else{
                centerTableView.delegate = self
                centerTableView.dataSource = self
                centerTableView.reloadData()
                lArray.forEach { filtrateModel in
                    filtrateModel.iSele = false
                }
                leftModel = lArray[indexPath.row]
                leftModel.iSele = true
                lArray[indexPath.row] = leftModel
                tableView.reloadData()
                rArray.removeAll()
                rightTableView.reloadData()
                if returnAction != nil {
                    returnAction?(indexPath,[leftModel])
                }
            }
            
        } else  if tableView == centerTableView {
            cArray =  centerArray
            cArray.forEach { filtrateModel in
                filtrateModel.iSele = false
            }
            cenModel = cArray[indexPath.row]
            cenModel.iSele = true
            cArray[indexPath.row] = cenModel
            tableView.reloadData()
        
            rArray = rightArray
            rightTableView.delegate = self
            rightTableView.dataSource = self
            rightTableView.reloadData()
            if returnAction != nil {
                returnAction?(indexPath,[leftModel,cenModel])
            }
            
        }else{
            rArray = rightArray
            rightModel = rArray[indexPath.row]
            if rightModel.iSele {
                rightModel.iSele = false
            }else{
                rightModel.iSele = true
            }
            rArray[indexPath.row] = rightModel
            tableView.reloadData()
            if returnAction != nil {
                returnAction?(indexPath,[leftModel,cenModel,rightModel])
            }
        }
    }
}
