//
//  KC.swift
//  CutterCorner-Swift
//
//  Created by taozhang on 2020/5/5.
//  Copyright © 2020 Easyhong. All rights reserved.
//

import Foundation
import UIKit

public class ArchCutterSwift: NSObject {
    
    /** 切割UIView、UIButton和UILabel圆角
     * @param view 需要进行切割的对象
     * @param direction 切割的方向
     * @param cornerRadii 圆角半径
     * @param borderWidth 边框宽度
     * @param borderColor 边框颜色
     * @param backgroundColor 背景色
     */
    public class func cuttingView(view: UIView,
                                  direction: UIRectCorner,
                                  cornerRadii: CGFloat,
                                  borderWidth: CGFloat,
                                  borderColor: UIColor,
                                  backgroundColor: UIColor) {
        
        var cornerRadii = cornerRadii
        if view.bounds.size.height != 0 && view.bounds.size.width != 0 {
            let width = view.bounds.size.width
            let height = view.bounds.size.height
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
            let currentContext = UIGraphicsGetCurrentContext()
            
            if (currentContext != nil) {
                currentContext?.setFillColor(backgroundColor.cgColor)
                currentContext?.setStrokeColor(borderColor.cgColor)
                
                if cornerRadii == 0 {
                    cornerRadii = view.bounds.size.height / 2
                }
                if direction == UIRectCorner.allCorners {
                    currentContext?.move(to: CGPoint.init(x: width - borderWidth, y: cornerRadii + borderWidth))// 从右下开始
                    currentContext?.addArc(tangent1End: CGPoint.init(x: width - borderWidth, y: height - borderWidth), tangent2End: CGPoint.init(x: width - cornerRadii - borderWidth, y: height - borderWidth), radius: cornerRadii)
                    currentContext?.addArc(tangent1End: CGPoint.init(x: borderWidth, y: height - borderWidth), tangent2End: CGPoint.init(x: borderWidth, y: height - cornerRadii - borderWidth), radius: cornerRadii)
                    currentContext?.addArc(tangent1End: CGPoint.init(x: borderWidth, y: borderWidth), tangent2End: CGPoint.init(x: width - borderWidth, y: borderWidth), radius: cornerRadii)
                    currentContext?.addArc(tangent1End: CGPoint.init(x: width - borderWidth, y: borderWidth), tangent2End: CGPoint.init(x: width - borderWidth, y:  cornerRadii + borderWidth), radius: cornerRadii)
                    
                } else {
                    currentContext?.move(to: CGPoint.init(x: cornerRadii + borderWidth, y: borderWidth))// 从左上开始
                    if direction.contains(UIRectCorner.topLeft) {
                        currentContext?.addArc(tangent1End: CGPoint.init(x: borderWidth, y: borderWidth), tangent2End: CGPoint.init(x: borderWidth, y: cornerRadii + borderWidth), radius: cornerRadii)
                    } else {
                        currentContext?.addLine(to: CGPoint.init(x: borderWidth, y: borderWidth))
                    }
                    if direction.contains(UIRectCorner.bottomLeft) {
                        currentContext?.addArc(tangent1End: CGPoint.init(x: borderWidth, y: height - borderWidth), tangent2End: CGPoint.init(x: borderWidth + cornerRadii, y: height - borderWidth), radius: cornerRadii)
                    } else {
                        currentContext?.addLine(to: CGPoint.init(x: borderWidth, y: height - borderWidth))
                    }
                    if direction.contains(UIRectCorner.bottomRight) {
                        currentContext?.addArc(tangent1End: CGPoint.init(x: width - borderWidth, y: height - borderWidth), tangent2End: CGPoint.init(x: width - borderWidth, y: height - borderWidth - cornerRadii), radius: cornerRadii)
                    } else {
                        currentContext?.addLine(to: CGPoint.init(x: width - borderWidth, y: height - borderWidth))
                    }
                    if direction.contains(UIRectCorner.topRight) {
                        currentContext?.addArc(tangent1End: CGPoint.init(x: width - borderWidth, y: borderWidth), tangent2End: CGPoint.init(x: width - borderWidth - cornerRadii, y: borderWidth), radius: cornerRadii)
                    } else {
                        currentContext?.addLine(to: CGPoint.init(x: width - borderWidth, y: borderWidth))
                    }
                    currentContext?.addLine(to: CGPoint.init(x: borderWidth + cornerRadii, y: borderWidth))
                    
                }
                currentContext?.drawPath(using: .fillStroke)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                // 绘制完成后，将UIImageView插入到view视图层级的底部
                if (image?.isKind(of: UIImage.self))! {
                    let baseImageView = UIImageView.init(image: image)
                    view.insertSubview(baseImageView, at: 0)
                }
            }
        } else {// 如果没有获取到view的bounds时
            DispatchQueue.main.async {
                self.cuttingView(view: view,
                                 direction: direction,
                                 cornerRadii: cornerRadii,
                                 borderWidth: borderWidth,
                                 borderColor: borderColor,
                                 backgroundColor: backgroundColor)
            }
        }
    }
    
    /** 切割UIImageView圆角
     * @param imageView 需要进行切割的对象
     * @param direction 切割的方向
     * @param cornerRadii 圆角半径
     * @param borderWidth 边框宽度
     * @param borderColor 边框颜色
     * @param backgroundColor 背景色
     */
    public class func cuttingImageView(imageView: UIImageView,
                                       direction: UIRectCorner,
                                       cornerRadii: CGFloat,
                                       borderWidth: CGFloat,
                                       borderColor: UIColor,
                                       backgroundColor: UIColor) {
        var cornerRadii = cornerRadii
        if imageView.bounds.size.height != 0 && imageView.bounds.size.width != 0 {
            // 先截取UIImageView视图Layer生成的Image，然后再做渲染
            var image : UIImage? = nil
            if (imageView.image != nil) {
                image = imageView.image
            } else {
                DispatchQueue.main.async {
                    self.cuttingImageView(imageView: imageView,
                                          direction: direction,
                                          cornerRadii: cornerRadii,
                                          borderWidth: borderWidth,
                                          borderColor: borderColor,
                                          backgroundColor: backgroundColor)
                    
                }
            }

            if cornerRadii == 0 {
                cornerRadii = imageView.bounds.size.height / 2
            }
            let rect = CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: imageView.bounds.size.width,
                                                                                  height: imageView.bounds.size.height))
            UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
            let currentContext = UIGraphicsGetCurrentContext()
            if (currentContext != nil) {
                let path = UIBezierPath(roundedRect: rect,
                                        byRoundingCorners: direction,
                                        cornerRadii: CGSize(width: cornerRadii - borderWidth,
                                                            height: cornerRadii - borderWidth))
                currentContext?.addPath(path.cgPath)
                currentContext?.clip()
                
                image?.draw(in: rect)
                borderColor.setStroke()// 画笔颜色
                backgroundColor.setFill()// 填充颜色
                path.stroke()
                path.fill()
                image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            if (image?.isKind(of: UIImage.self))! {
                imageView.image = image
            } else {// UITableViewCell的UIImageView，第一次创建赋图时，可能无法获取UIImageView视图layer的图片
                DispatchQueue.main.async {
                    self.cuttingImageView(imageView: imageView, direction: direction, cornerRadii: cornerRadii, borderWidth: borderWidth, borderColor: borderColor, backgroundColor: backgroundColor)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.cuttingImageView(imageView: imageView, direction: direction, cornerRadii: cornerRadii, borderWidth: borderWidth, borderColor: borderColor, backgroundColor: backgroundColor)
            }

        }
        
    }

}
