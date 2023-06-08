//
//  JuConsTool.swift
//  住房宝
//
//  Created by 挖坑小能手 on 2022/2/15.
//  Copyright © 2022 HeZhong. All rights reserved.
//
import UIKit

extension UIColor {
    
    /***********公用色值*************/

//    // Hex String -> UIColor
        convenience init(hexString: String) {
            let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)

            if hexString.hasPrefix("#") {
                scanner.scanLocation = 1
            }

            var color: UInt32 = 0
            scanner.scanHexInt32(&color)

            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0

            self.init(red: red, green: green, blue: blue, alpha: 1)
        }
//
    convenience init(hexString: String,alpha:CGFloat) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension String {

    func boundingRect(with size: CGSize, font: UIFont?, lineSpacing: CGFloat, attributeString string: String?) -> CGSize {
        let attributeString = NSMutableAttributedString(string: string ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: string?.count ?? 0))
        attributeString.addAttribute(.font, value: font as Any, range: NSRange(location: 0, length: string?.length ?? 0))
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        var rect = attributeString.boundingRect(with: size, options: options, context: nil)
        if (rect.size.height - font!.lineHeight) <= paragraphStyle.lineSpacing {
            if isChinese(str:string ?? "") {
                //如果包含中文
                rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height - paragraphStyle.lineSpacing)
            }
        }
        return rect.size
    }
//
    //判断是否包含中文
    func isChinese(str: String) -> Bool{
            let match: String = "(^[\\u4e00-\\u9fa5]+$)"
            let predicate = NSPredicate(format: "SELF matches %@", match)
            return predicate.evaluate(with: str)
    }

    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
          var ranges: [Range<Index>] = []
          while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
              ranges.append(range)
          }
          // [range]转换为[NSRange]返回
          return ranges.compactMap({NSRange($0, in: self)})
      }
}


fileprivate var rectNameKey:(Character?,Character?,Character?,Character?)
extension UIButton {

    func set(image anImage: UIImage?, title: String,
             titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State, textColor:UIColor){
        self .set(image: anImage, title: title, timage: nil, ttitle: "", titlePosition: titlePosition, additionalSpacing: additionalSpacing, state: state, tstate: .selected, textColor:textColor)
    }

    func set(image anImage: UIImage?, title: String,
             titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self .set(image: anImage, title: title, timage: nil, ttitle: "", titlePosition: titlePosition, additionalSpacing: additionalSpacing, state: state, tstate: .selected)
    }

    func set(image anImage: UIImage?, title: String,timage tanImage: UIImage?, ttitle: String,
             titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State,tstate: UIControl.State, textColor:UIColor){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)

        self.titleLabel?.contentMode = .center
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: state)
        if !ttitle.isEmpty {
             self.setTitle(ttitle, for: tstate)
        }
        if tanImage != nil {
            self.setImage(tanImage, for: tstate)
        }
    }

    func set(image anImage: UIImage?, title: String,timage tanImage: UIImage?, ttitle: String,
             titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State,tstate: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)

        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        if !ttitle.isEmpty {
             self.setTitle(ttitle, for: tstate)
        }
        if tanImage != nil {
            self.setImage(tanImage, for: tstate)
        }
    }

    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
