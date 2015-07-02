//
//  DropitBehavior.swift
//  Dropit
//
//  Created by liubin on 15/6/30.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {
    
    let gravityBehavior = UIGravityBehavior()
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = true
        behavior.elasticity = 0.5
        return behavior
    }()

    override init() {
        super.init()
        
        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    func addDrop(view: UIView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        
        gravityBehavior.addItem(view)
        collisionBehavior.addItem(view)
        itemBehavior.addItem(view)

    }
    
    func removeDrop(view: UIView) {
        gravityBehavior.removeItem(view)
        collisionBehavior.removeItem(view)
        itemBehavior.removeItem(view)

        view.removeFromSuperview()
    }
    
    func addBarrier(name: String, path: UIBezierPath) {
        collisionBehavior.removeBoundaryWithIdentifier(name)
        collisionBehavior.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    
}
