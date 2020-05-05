//
//  ViewController.swift
//  CutterCorner-Swift
//
//  Created by taozhang on 2020/5/5.
//  Copyright © 2020 Easyhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentVire: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CutterCorner.cuttingView(view: contentVire, direction: .allCorners, cornerRadii: 40, borderWidth: 0, borderColor: .clear, backgroundColor: .blue)
        CutterCorner.cuttingView(view: button, direction: .topLeft, cornerRadii: 20, borderWidth: 0, borderColor: .clear, backgroundColor: .orange)
        CutterCorner.cuttingView(view: label, direction: .topLeft, cornerRadii: 10, borderWidth: 0, borderColor: .clear, backgroundColor: .black)
    }


}

