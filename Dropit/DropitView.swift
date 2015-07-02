//
//  DropitView.swift
//  Dropit
//
//  Created by liubin on 15/6/30.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class DropitView: UIView {

    private var pathDict = [String:UIBezierPath]()
    
    func setPath(name: String, path: UIBezierPath) {
        pathDict[name] = path
        setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        for (_, path) in pathDict {
            path.stroke()
        }
    }

    
    

}
