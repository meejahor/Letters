//
//  Tile.swift
//  Letters
//
//  Created by Andrew Smith on 12/10/2021.
//

import SpriteKit
import GameplayKit

class Tile: SKShapeNode {
	static var numTilesAcrossScreen = 8
	static var innerSizeScale: CGFloat = 0.8
	static var cornerScale: CGFloat = 0.3
	static var borderWidth: CGFloat = 5
	
	static var scene: SKScene?
	static var size: CGFloat?
	static var innerSize: CGFloat?
	static var cornerSize: CGFloat?
	static var fontSize: CGFloat?
	
	static func initialize(scene: SKScene) {
		Tile.scene = scene
		Tile.size = scene.size.width / CGFloat(numTilesAcrossScreen)
		Tile.innerSize = Tile.size! * Tile.innerSizeScale
		Tile.cornerSize = Tile.size! * cornerScale
		Tile.fontSize = Tile.scene!.frame.width * 0.075
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
		super.init()
		let innerSize = Tile.innerSize!
		let cornerSize = Tile.cornerSize!
		self.path = CGPath(
			roundedRect: CGRect(x: -innerSize/2, y: -innerSize/2, width: innerSize, height: innerSize),
			cornerWidth: cornerSize, cornerHeight: cornerSize,
			transform: nil
		)
		self.position = Tile.CalcPosition(x: x, y: y)
		self.lineWidth = Tile.borderWidth
		self.strokeColor = SKColor.gray
		self.fillColor = SKColor.darkGray

		let label = SKLabelNode.init(text: letter)
		label.text = letter
		label.fontName = "ArialRoundedMTBold"
		label.fontSize = Tile.fontSize!
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
