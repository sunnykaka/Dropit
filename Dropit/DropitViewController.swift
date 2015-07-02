//
//  DropitViewController.swift
//  Dropit
//
//  Created by liubin on 15/6/30.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: DropitView!
    
    private let dropitBehavior = DropitBehavior()
    
    lazy var dynamicAnimator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self.gameView)
        animator.delegate = self
        return animator
    }()
    
    private let dropsPerRow = 10
    
    var dropSize: CGSize {
        let size = gameView.bounds.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        let frame = CGRect(x: CGFloat.random(dropsPerRow) * dropSize.width, y: CGFloat(0), width: dropSize.width, height: dropSize.height)
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.random
                
        dropitBehavior.addDrop(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dynamicAnimator.addBehavior(dropitBehavior)
    }
    
    struct PathName {
        static let BarrierPathName = "CenterBarrier"
    }
    
    override func viewDidLayoutSubviews() {
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX - dropSize.width/2, y: gameView.bounds.midY - dropSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehavior.addBarrier(PathName.BarrierPathName, path: path)
        gameView.setPath(PathName.BarrierPathName, path: path)
    }
    
    func removeCompeleteRow() {
        var needRemoveViews = [UIView]()
        var needRemove = true
        var startY = gameView.bounds.maxY - dropSize.height
        do {
            needRemove = true
            needRemoveViews = [UIView]()
            var startX = CGFloat(0)
            for _ in 0..<dropsPerRow {
                let rect = CGRect(origin: CGPoint(x: startX, y: startY), size: dropSize)
                if let dropitView = gameView.hitTest(CGPoint(x: rect.midX, y: rect.midY), withEvent: nil) {
                    if dropitView.superview == gameView {
                        needRemoveViews.append(dropitView)
                    } else {
                        needRemove = false
                        break
                    }
                }
                startX += dropSize.width
            }
            startY -= dropSize.height
        } while startY >= 0 && !needRemove
        
        if needRemove {
            for view in needRemoveViews {
                dropitBehavior.removeDrop(view)
            }
        }
        
    }

    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompeleteRow()
    }

}

private extension CGFloat {
    static func random(max: Int) -> CGFloat{
        return CGFloat(arc4random() % UInt32(max))
    }
}


private extension UIColor {
    
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.blackColor()
        case 1: return UIColor.greenColor()
        case 2: return UIColor.yellowColor()
        case 3: return UIColor.blueColor()
        case 4: return UIColor.orangeColor()
        default: return UIColor.blackColor()
        }
    }
}
