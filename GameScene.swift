//
//  GameScene.swift
//  Letters
//
//  Created by Andrew Smith on 11/10/2021.
//

import SpriteKit
import GameplayKit

class Tile: SKShapeNode {
	init(x: CGFloat, y: CGFloat, size: CGFloat, letter: String) {
		super.init()
		let cornerSize = size * 0.3;
		self.path = CGPath(
			roundedRect: CGRect(x: -size/2, y: -size/2, width: size, height: size),
			cornerWidth: cornerSize, cornerHeight: cornerSize,
			transform: nil
		)
		self.position = CGPoint(x: x, y: y)
		self.lineWidth = 5
		self.strokeColor = SKColor.gray
		self.fillColor = SKColor.darkGray

		let label = SKLabelNode.init(text: letter)
		label.text = letter
		label.fontName = "ArialRoundedMTBold"
		label.fontSize = 100
		let scalingFactor = (size * 0.6) / label.frame.height
		label.fontSize *= scalingFactor
		label.position = CGPoint(
			x: self.frame.midX,
			y: self.frame.midY
		)
		label.horizontalAlignmentMode = .center
		label.verticalAlignmentMode = .center
		self.addChild(label)

		self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//		self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//										  SKAction.fadeOut(withDuration: 0.5),
//										  SKAction.removeFromParent()]))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class GameScene: SKScene {
    


    override func didMove(to view: SKView) {

		let size = self.size.width / 8
		let tile = Tile(x: self.frame.midX, y: self.frame.midY*0.5, size: size,letter: "A")
		self.addChild(tile)

//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.tile?.copy() as! SKShapeNode? {
//            n.position = pos
//            self.addChild(n)
//        }
    }
    
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
