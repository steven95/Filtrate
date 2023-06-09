//
//  HomeTagView.swift
//  Jubao
//
//  Created by 挖坑小能手 on 2022/2/22.
//  Copyright © 2022 HeZhong. All rights reserved.
//

import Foundation
import UIKit

open class HomeTagCell: UICollectionViewCell {
    
    open func setupUI(entryTag: EntryTag) {
        if entryTag.iSele {
            self.titleL.textColor = FSHexColor(Hex: 0xF52938, alpha: 1)
            self.backgroundColor = FSHexColor(Hex: 0xFFF2F3, alpha: 1)
            if entryTag.iBorder {
                self.layer.borderColor = FSHexColor(Hex: 0xF52938, alpha: 1).cgColor
                self.layer.borderWidth = FRPRealValue(0.5)
            }
           
        }else{
            self.titleL.textColor = FSHexColor(Hex: 0x85888C , alpha: 1)
            self.backgroundColor = FSHexColor(Hex: 0xF8F9FA , alpha: 1)
            if entryTag.iBorder {
            self.layer.borderColor = FSHexColor(Hex: 0xF8F9FA , alpha: 1).cgColor
                self.layer.borderWidth = 0
            }
        }
    }
    
    private var _cFont:UIFont = UIFont.systemFont(ofSize: FRPRealValue(13))
    public   var  cFont:UIFont {
          get {
              return _cFont
          }
          set {
              _cFont = newValue
              titleL.font = newValue
          }
    }
    
    open lazy var titleL : UILabel = {
        let titleL = UILabel.init()
        titleL.textAlignment = .center
        titleL.font = UIFont.systemFont(ofSize: FRPRealValue(14))
        titleL.textColor = FSHexColor(Hex: 0x261919, alpha: 1)
        titleL.numberOfLines = 0
        return titleL
    }()

    open lazy var rlineV : UIView = {
        let rlineV = UIView.init()
        rlineV.backgroundColor = FSHexColor(Hex: 0xE4E7EC, alpha: 1)
        rlineV.isHidden = true
        return rlineV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.bottom.top.left.right.equalToSuperview().offset(0)
        }
        self.addSubview(rlineV)
        rlineV.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(0)
            make.width.equalTo(FRPRealValue(0.5))
            make.right.equalToSuperview().offset(0)
        }
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class HomeTagView: UIView {
    
    private var _groups:[String] = []
    public   var  groups:[String] {
          get {
              return _groups
          }
          set {
              _groups = newValue
              collectionView.reloadData()
          }
    }
    
    private var _itemSize:CGSize = CGSize.zero
    public   var  itemSize:CGSize {
          get {
              return _itemSize
          }
          set {
              _itemSize = newValue
              flowLayout.itemSize = newValue
              collectionView.setCollectionViewLayout(flowLayout, animated: true)
          }
    }
    
    private var _clolor:UIColor = UIColor.clear
    public   var  clolor:UIColor {
          get {
              return _clolor
          }
          set {
              _clolor = newValue
              collectionView.reloadData()
          }
    }
    
    private var _cFont:UIFont = UIFont.systemFont(ofSize: FRPRealValue(13))
    public   var  cFont:UIFont {
          get {
              return _cFont
          }
          set {
              _cFont = newValue
              collectionView.reloadData()
          }
    }
    
    private var _cFloat:CGFloat = FRPRealValue(5)
    public   var  cFloat:CGFloat {
          get {
              return _cFloat
          }
          set {
              _cFloat = newValue
              collectionView.reloadData()
          }
    }
    
    open lazy var flowLayout : UICollectionViewLeftAlignedLayout = {
        let flowLayout = UICollectionViewLeftAlignedLayout.init()
        flowLayout.minimumLineSpacing = FRPRealValue(12)
        flowLayout.minimumInteritemSpacing = FRPRealValue(15)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    open lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = FSHexColor(Hex: 0xFFFFFF, alpha: 1)
        unowned let uSelf = self
        collectionView.delegate = uSelf
        collectionView.dataSource = uSelf
        collectionView.register(HomeTagCell.self, forCellWithReuseIdentifier: "HomeTagCell")
        return collectionView
    }()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview().offset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func returnBlock(_ callback: @escaping @convention(block) (_ indexPath: IndexPath) -> Void) {
        returnAction = callback
    }
    private  var returnAction: ( (@convention(block) (_ indexPath: IndexPath) -> Void))?
    
}

extension HomeTagView:UICollectionViewDelegateFlowLayout{
    public  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if itemSize.width <= itemSize.height {
            let text = "\(groups[indexPath.row] )"
            let  cell_width = settingCollectionViewItemWidthBoundingWithText(text: text)
            return CGSize.init(width: cell_width, height: itemSize.height)
        }else{
            return CGSize.init(width: itemSize.width, height: itemSize.height)
        }
    }
    
    public func settingCollectionViewItemWidthBoundingWithText(text:String) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: itemSize.height)
           let attributeDic = [
               NSAttributedString.Key.font: cFont
           ]
           let frame = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributeDic, context: nil)
              var width = (frame.size.width ) + cFloat
        if width > collectionView.bounds.size.width - FRPRealValue(15) {
                width = collectionView.bounds.size.width - FRPRealValue(15)
            }
            //4.添加左右间距
            return width
    }
}

extension HomeTagView:UICollectionViewDelegate,UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    public  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTagCell", for: indexPath) as! HomeTagCell
        cell.titleL.text =  groups[indexPath.row]
        cell.backgroundColor = clolor
        cell.cFont = cFont
        cell.layer.cornerRadius = FRPRealValue(5)
        cell.layer.masksToBounds = true
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if returnAction != nil {
            returnAction!(indexPath)
        }
    }
    
//    -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//    {
//        if (self.rmodel.type == 0) {
//            [ self.rmodel.groups enumerateObjectsUsingBlock:^(TagModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (idx == indexPath.row) {
//                    obj.iSele = YES;
//                }else{
//                    obj.iSele = NO;
//                }
//            }];
//            [collectionView reloadData];
//        }else{
//            TagModel * model =  self.rmodel.groups[indexPath.item];
//            if ([self.groupsele containsObject:model]) {
//                [self.groupsele removeObject:model];
//            }else{
//                [self.groupsele addObject:model];
//            }
//            WEAKSELF
//            [ self.rmodel.groups enumerateObjectsUsingBlock:^(TagModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([weakSelf.groupsele containsObject:obj]) {
//                    obj.iSele = YES;
//                }else{
//                    obj.iSele = NO;
//                }
//            }];
//            [collectionView reloadData];
//        }
//        if (self.returnBlock && self.rmodel.type == 0) {
//            self.returnBlock(self.rmodel,indexPath,self);
//        }else{
//            if (self.returnSetBlock) {
//                self.returnSetBlock(self.groupsele);
//            }
//        }
//    }
}

