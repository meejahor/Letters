//
//  GameScene.swift
//  Letters
//
//  Created by Andrew Smith on 11/10/2021.
//

import SpriteKit
import GameplayKit

class Tile: SKShapeNode {
	static var scene: SKScene?
	static var size: CGFloat?
	static var cornerSize: CGFloat?
	
	static func initialize(scene: SKScene) {
		Tile.scene = scene
		Tile.size = scene.size.width / 8
		Tile.cornerSize = Tile.size! * 0.3
	}
	
	init(x: CGFloat, y: CGFloat, letter: String) {
		super.init()
		let size = Tile.size!
		let cornerSize = Tile.cornerSize!
//		self.position = CGPoint(x: x, y: y)
		self.path = CGPath(
			roundedRect: CGRect(x: -size/2, y: -size/2, width: size, height: size),
			cornerWidth: cornerSize, cornerHeight: cornerSize,
			transform: nil
		)
		self.lineWidth = 5
		self.strokeColor = SKColor.gray
		self.fillColor = SKColor.darkGray

		let label = SKLabelNode.init(text: letter)
		label.text = letter
		label.fontName = "ArialRoundedMTBold"
		label.fontSize = 100
		let scalingFactor = (size * 0.6) / label.frame.height
		label.fontSize *= scalingFactor
//		label.position = CGPoint(
//			x: 0,
//			y: self.frame.midY
//		)
		label.horizontalAlignmentMode = .center
		label.verticalAlignmentMode = .center
		self.addChild(label)

//		self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//		self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//										  SKAction.fadeOut(withDuration: 0.5),
//										  SKAction.removeFromParent()]))

		Tile.scene!.addChild(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class GameScene: SKScene {

    override func didMove(to view: SKView) {

		Tile.initialize(scene: self)
		Tile(x: self.frame.midX, y: self.frame.midY*0.5, letter: "A")

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
