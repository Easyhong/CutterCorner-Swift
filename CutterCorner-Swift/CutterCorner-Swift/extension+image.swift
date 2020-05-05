//
//  extension+image.swift
//  CutterCorner-Swift
//
//  Created by taozhang on 2020/5/5.
//  Copyright © 2020 Easyhong. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    /**
      只有当 imageView 不为nil 时，调用此方法才有效果
       :param: radius 圆角半径
       */
//       func kay_addCorner(radius radius: CGFloat) {
//          self.image = self.image?.kay_drawRectWithRoundedCorner(radius: radius, self.bounds.size)
//      }
    
}

//extension UIImage {
//
//    // 贝塞尔曲线实现圆角
//    func kay_drawRectWithRoundedCorner(radius: CGFloat, _ sizetoFit: CGSize) -> UIImage {
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: sizetoFit)
//
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
//
//
//        CGContextAddPath(CGContext(),
//                         UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners,
//                            cornerRadii: CGSize(width: radius, height: radius)).cgPath)
//
//        CGContextClip(UIGraphicsGetCurrentContext())
//
//        self.drawInRect(rect)
//        CGContextDrawPath(UIGraphicsGetCurrentContext(), .fillStroke)
//        let output = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext();
//
//        return output
//    }
//}
