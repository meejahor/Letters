//
//  Tile.swift
//  Letters
//
//  Created by Andrew Smith on 12/10/2021.
//

import SpriteKit
import GameplayKit

class Tile: SKSpriteNode {
	static var gridSize = 8
	
	static var scene: GameScene?
	static var size: CGFloat?
	static var innerSize: CGFloat?
	static var cornerSize: CGFloat?
	static var fontSize: CGFloat?
	
	static var moveTime = 0.2
	static var expandTime = 0.1
	static var shrinkTime = 0.2

	var label: SKLabelNode
	var letter: String?
	
	static func initialize(scene: GameScene) {
		Tile.scene = scene
		Tile.size = scene.size.width / CGFloat(gridSize)
		Tile.fontSize = scene.frame.width * 0.075
	}
	
	static func CalcPosition(x: Int, y: Int) -> CGPoint {
		var p = CGPoint.zero
		let size = Tile.size!
		p.x = size * CGFloat(x)
		p.x += size * 0.5
		p.y = Tile.scene!.frame.height - (size * CGFloat(y))
		p.y -= size * 0.5
		return p
	}
	
	@discardableResult init(x: Int, y: Int, letter: String) {
		self.letter = letter
		label = SKLabelNode.init(text: letter)
		
		super.init(
			texture: SKTexture(imageNamed: "tile"),
			color: UIColor.white,
			size: CGSize(width: Tile.size!, height: Tile.size!)
		)
		
		self.zPosition = GameScene.Z_TILE
		
//		let innerSize = Tile.innerSize!
//		let cornerSize = Tile.cornerSize!
		
//		self.path = CGPath(
//			roundedRect: CGRect(x: -innerSize/2, y: -innerSize/2, width: innerSize, height: innerSize),
//			cornerWidth: cornerSize, cornerHeight: cornerSize,
//			transform: nil
//		)
		
		self.position = Tile.CalcPosition(x: x, y: y)

//		self.lineWidth = Tile.borderWidth
//		self.strokeColor = SKColor.gray
//		self.fillColor = SKColor.darkGray

		label.zPosition = GameScene.Z_TILE_LETTER
		label.text = letter
		label.fontName = "ArialRoundedMTBold"
		label.fontSize = Tile.fontSize!
		label.fontColor = UIColor.black
		label.horizontalAlignmentMode = .center
		label.verticalAlignmentMode = .center
		self.addChild(label)

//		self.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))

		Tile.scene!.addChild(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func clicked() {
		let targetPosition = Tile.scene!.getPositionOfLetter(c: letter!)
		
		if targetPosition != nil {
			self.run(SKAction.sequence([
				SKAction.move(to: targetPosition!, duration: Tile.moveTime),
//				SKAction.customAction(withDuration: 0, actionBlock: {_,_ in
//					self.fillColor = UIColor.red
//					self.strokeColor = UIColor.red
//				}),
				SKAction.scale(by: 2, duration: Tile.expandTime),
				SKAction.scale(by: 0.5, duration: Tile.shrinkTime),
			]))
		} else {
			self.run(SKAction.sequence([
				SKAction.group([
					SKAction.scale(by: 1.5, duration: 0.2),
					SKAction.fadeOut(withDuration: 0.2)
				]),
				SKAction.removeFromParent()
			]))
		}
	}
}
