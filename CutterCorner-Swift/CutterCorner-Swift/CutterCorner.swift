//
//  CutterCorner.swift
//  CutterCorner-Swift
//
//  Created by taozhang on 2020/5/5.
//  Copyright © 2020 Easyhong. All rights reserved.
//

import Foundation
import UIKit


// CutterCorner
public class CutterCorner {
    
    public class func cuttingLayer(layer: UIView,
                                   direction: UIRectCorner,
                                   cornerRadii: CGFloat,
                                   borderWidth: CGFloat,
                                   borderColor: UIColor,
                                   backgroundColor: UIColor) {
         var cornerRadii = cornerRadii
        
        guard var width: CGFloat = layer.bounds.width, var height: CGFloat = layer.bounds.height else {
            return
        }
        
        // 先利用CoreGraphics绘制一个圆角矩形
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size,
                                               false,
                                               UIScreen.main.scale)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.setFillColor(backgroundColor.cgColor)
        currentContext?.setStrokeColor(borderColor.cgColor)
        if cornerRadii == 0 { cornerRadii = layer.bounds.width / 2 }
        
        switch direction {
        case .allCorners:
            currentContext?.move(to: CGPoint(x: width - borderWidth,
                                             y: cornerRadii + borderWidth))
            
            currentContext?.addArc(tangent1End: CGPoint.init(x: width - borderWidth,
                                                            y: height - borderWidth),
                                  tangent2End: CGPoint.init(x: width - cornerRadii - borderWidth,
                                                            y: height - borderWidth),
                                  radius: cornerRadii)
            currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                        y: height - borderWidth),
                                  tangent2End: CGPoint(x: borderWidth,
                                                       y: height - cornerRadii - borderWidth),
                                  radius: cornerRadii)
                              
            currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                       y: borderWidth),
                                  tangent2End: CGPoint(x: width - borderWidth,
                                                                          y: borderWidth),
                                  radius: cornerRadii)
                              
            currentContext?.addArc(tangent1End: CGPoint(x: width - borderWidth,
                                                       y: borderWidth),
                                  tangent2End: CGPoint(x: width - borderWidth,
                                                       y:  cornerRadii + borderWidth),
                                  radius: cornerRadii)
            
        case .topLeft:
            currentContext?.move(to: CGPoint(x: cornerRadii + borderWidth,
                                            y: borderWidth))
            currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                       y: borderWidth),
                                  tangent2End: CGPoint(x: borderWidth,
                                                       y: cornerRadii + borderWidth),
                                  radius: cornerRadii)
        case .bottomLeft:
            currentContext?.move(to: CGPoint(x: cornerRadii + borderWidth,
                                            y: borderWidth))
            currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                       y: height - borderWidth),
                                  tangent2End: CGPoint(x: borderWidth + cornerRadii,
                                                       y: height - borderWidth),
                                  radius: cornerRadii)
        case .topRight:
            currentContext?.move(to: CGPoint(x: cornerRadii + borderWidth,
                                            y: borderWidth))
            currentContext?.addArc(tangent1End: CGPoint(x: width - borderWidth,
                                                       y: borderWidth),
                                                          tangent2End: CGPoint(x: width - borderWidth - cornerRadii,
                                                                               y: borderWidth),
                                                          radius: cornerRadii)
           
        case .bottomRight:
            currentContext?.move(to: CGPoint(x: cornerRadii + borderWidth,
                                            y: borderWidth))
            currentContext?.addArc(tangent1End: CGPoint(x: width - borderWidth,
                                                       y: height - borderWidth),
                                                        tangent2End: CGPoint(x: width - borderWidth,
                                                                             y: height - borderWidth - cornerRadii),
                                                        radius: cornerRadii)
            
        default:
            DispatchQueue.main.async {
//              self.cuttingLayer(layer: layer,
//                                direction: direction,
//                                cornerRadii: cornerRadii,
//                                borderWidth: borderWidth,
//                                borderColor: borderColor,
//                                backgroundColor: backgroundColor)
            }
        
        }
        
        currentContext?.drawPath(using: .fillStroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // 绘制完成后，将UIImageView插入到view视图层级的底部
      //  if (image?.isKind(of: UIImage.self))! {
           let baseImageView = UIImageView(image: image)
          // layer.insertSublayer(baseImageView.layer, at: 0)
              layer.insertSubview(baseImageView, at: 0)
       // }
    }
    
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
        if view.bounds.size.height != 0 && view.bounds.size.width != 0 {
            
            var cornerRadii = cornerRadii
            let widthX   = view.bounds.size.width
            let heightY  = view.bounds.size.height
            // (0,0)
            let leftTop = CGPoint(x: borderWidth, y: borderWidth)
            // (50, 0)
            let centerTop = CGPoint(x: cornerRadii + borderWidth, y: borderWidth)
            // (100, 0)
            let rightTop = CGPoint.init(x: widthX - borderWidth, y: borderWidth)
            // 左中(0, 50)
            let leadingCenter = CGPoint(x: borderWidth, y: cornerRadii + borderWidth)
            // 右中(100, 50)
            let trailingCenter = CGPoint(x: widthX - borderWidth, y: widthX / 2 + borderWidth)
            // (0, 100)
            let leftBottom = CGPoint(x: borderWidth, y: widthX - borderWidth)
            // (50, 100)
            let centerBottom = CGPoint(x: widthX - cornerRadii - borderWidth, y: heightY - borderWidth)
            // (100, 100)
            let rightBottom = CGPoint(x: widthX - borderWidth, y: heightY - borderWidth)
            
            // 先利用CoreGraphics绘制一个矩形
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
            // 获取一个上下文
            let currentContext = UIGraphicsGetCurrentContext()
            
            if (currentContext != nil) {
                currentContext?.setFillColor(backgroundColor.cgColor)
                currentContext?.setStrokeColor(borderColor.cgColor)
                
                if cornerRadii == 0 {
                    cornerRadii = view.bounds.size.height / 2
                }
                
                switch direction {

                case .allCorners:
                     // 右中开始
                     currentContext?.move(to: CGPoint(x: widthX - borderWidth, y: borderWidth + cornerRadii))
                     // 右下角
                     currentContext?.addArc(tangent1End: CGPoint(x: widthX - borderWidth,
                                                                 y: heightY - borderWidth),
                                            tangent2End: CGPoint(x: widthX - cornerRadii - borderWidth,
                                                                 y: heightY - borderWidth),
                                            radius: cornerRadii)
                     // 左下角
                     currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                                 y: heightY - borderWidth),
                                            tangent2End: CGPoint(x: borderWidth,
                                                                 y: heightY - cornerRadii - borderWidth),
                                             radius: cornerRadii)
                     // 左上角
                     currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                                 y: borderWidth),
                                            tangent2End: CGPoint(x: widthX - borderWidth,
                                                                 y: borderWidth),
                                            radius: cornerRadii)
                     // 右上角
                     currentContext?.addArc(tangent1End: CGPoint(x: widthX - borderWidth,
                                                                 y: borderWidth),
                                            tangent2End: CGPoint(x: widthX - borderWidth,
                                                                y:  cornerRadii + borderWidth),
                                            radius: cornerRadii)

                case .topLeft:
            
                    currentContext?.move(to: CGPoint(x: cornerRadii + borderWidth,
                                                     y: borderWidth))
                     currentContext?.addArc(tangent1End: CGPoint(x: borderWidth,
                                                                 y: borderWidth),
                                            tangent2End: CGPoint(x: borderWidth,
                                                                 y: cornerRadii + borderWidth),
                                                                  radius: cornerRadii)
            
                    currentContext?.addLine(to: CGPoint(x: borderWidth,
                                                        y: heightY - borderWidth))
                   
                    currentContext?.addLine(to: CGPoint(x: widthX - borderWidth,
                                                        y: heightY - borderWidth))
             
                    currentContext?.addLine(to: CGPoint(x: widthX - borderWidth,
                                                        y: borderWidth))
                 
                    currentContext?.addLine(to: CGPoint(x: borderWidth + cornerRadii,
                                                        y: borderWidth))
                    
                case .topRight:
                    currentContext?.move(to: trailingCenter)
                    currentContext?.addArc(tangent1End: rightTop, tangent2End: centerTop, radius: cornerRadii)
                    currentContext?.addLine(to: leftTop)
                    currentContext?.addLine(to: leftBottom)
                    currentContext?.addLine(to: rightBottom)
                    currentContext?.addLine(to: trailingCenter)
                       
                case .bottomLeft:
                    currentContext?.move(to: CGPoint.init(x: 0, y: heightY - cornerRadii))
                    currentContext?.addArc(tangent1End: CGPoint.init(x: 0, y: heightY),
                                           tangent2End: CGPoint(x: cornerRadii,
                                                                y: heightY),
                                           radius: cornerRadii)
                    
                   currentContext?.addLine(to: rightBottom)
                   currentContext?.addLine(to: rightTop)
                   currentContext?.addLine(to: leftTop)
                   currentContext?.addLine(to: leadingCenter)
                    
                case .bottomRight:
                    currentContext?.move(to: centerBottom)
                    currentContext?.addArc(tangent1End: CGPoint(x: widthX, y: heightY),
                                           tangent2End: CGPoint(x: widthX, y: heightY - cornerRadii),
                                           radius: cornerRadii)
                    
                    currentContext?.addLine(to: rightTop)
                    currentContext?.addLine(to: leftTop)
                    currentContext?.addLine(to: leftBottom)
                    currentContext?.addLine(to: centerBottom)
                default:
                    break
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
            
        } else {
            // 如果没有获取到view的bounds
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
            
            let rect = CGRect.init(origin: CGPoint(x: 0,
                                                   y: 0),
                                   size: CGSize(width: imageView.bounds.size.width,
                                                height: imageView.bounds.size.height))
            
            UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
            let currentContext = UIGraphicsGetCurrentContext()
            
            if (currentContext != nil) {
                let path = UIBezierPath.init(roundedRect: rect,
                                             byRoundingCorners: direction,
                                             cornerRadii: CGSize(width: cornerRadii - borderWidth,
                                                                 height: cornerRadii - borderWidth))
                currentContext?.addPath(path.cgPath)
                currentContext?.clip()
                
                image?.draw(in: rect)
                // 画笔颜色
                borderColor.setStroke()
                // 填充颜色
                backgroundColor.setFill()
                path.stroke()
                path.fill()
                image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            
            if (image?.isKind(of: UIImage.self))! {
                imageView.image = image
                
            } else {
                // UITableViewCell的UIImageView，第一次创建赋图时，可能无法获取UIImageView视图layer的图片
                DispatchQueue.main.async {
                    self.cuttingImageView(imageView: imageView,
                                          direction: direction,
                                          cornerRadii: cornerRadii,
                                          borderWidth: borderWidth,
                                          borderColor: borderColor,
                                          backgroundColor: backgroundColor)
                }
            }
            
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
        
    }

}
