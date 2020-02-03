//
//  cardBehaviour.swift
//  playingCard
//
//  Created by AHMED GAMAL  on 9/19/19.
//  Copyright © 2019 AHMED GAMAL . All rights reserved.
//

import UIKit

class cardBehaviour: UIDynamicBehavior {
    
    lazy var collissionBehaviour : UICollisionBehavior = {
        let behaviour = UICollisionBehavior()
        behaviour.translatesReferenceBoundsIntoBoundary = true//to make items bounce into view boundries
        return behaviour
    }()
    
    lazy var itemBehaviour : UIDynamicItemBehavior = {
        let behaviour = UIDynamicItemBehavior()
        behaviour.allowsRotation = false
        behaviour.elasticity = 1.0
       // behaviour.friction = 0.0
        behaviour.resistance = 0.0
        return behaviour
    }()
    
    private func push (_ item : UIDynamicItem){
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = (2*CGFloat.pi).arc4random
        push.magnitude = CGFloat(1.0) + CGFloat (2.arc4random)
        push.action = {[unowned push, weak self] in self?.removeChildBehavior(push)}
        
        addChildBehavior(push)
    }
    
    func addItem(_ Item : UIDynamicItem){
        collissionBehaviour.addItem(Item)
        itemBehaviour.addItem(Item)
        push(Item)
    }
    func removeItem(_ Item : UIDynamicItem){
        collissionBehaviour.removeItem(Item)
        itemBehaviour.removeItem(Item)
        // we dont remove push because it automatically removed items from it when it begin
    }
    
    override init() {
        super.init()
        addChildBehavior(collissionBehaviour)
        addChildBehavior(itemBehaviour)
    }
    convenience init(in animator : UIDynamicAnimator ) {
        self.init()
        animator.addBehavior(self)
    }
}
