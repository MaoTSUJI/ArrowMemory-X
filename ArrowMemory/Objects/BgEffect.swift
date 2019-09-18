//
//  BgEffect.swift
//  ArrowMemory
//
//  Created by 辻真緒 on 2019/09/17.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class BgEffect: SKScene {
    
    let kFadeDuration = TimeInterval(1.3)
    
    var lightNode: SKEmitterNode!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        addPaper()
        showPaper()
    }
    
    override func willMove(from view: SKView) {
        
        lightNode.removeFromParent()
        // 背景色を透明にする.
        self.backgroundColor = UIColor.clear
        
    }
    
    func addPaper(){
        let fileName = "bgEffect"
        let path = Bundle.main.path(forResource: fileName, ofType: "sks")!
        lightNode = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode
        lightNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        lightNode.alpha = 0
        addChild(lightNode)
    }
    
    func showPaper(){
        let show = SKAction.fadeIn(withDuration: kFadeDuration)
        lightNode.run(show)
    }
    
    
    
}
