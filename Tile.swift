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
	
	static var delayBeforeTileAppears: Double = 0
	static var delayBetweenEachTileAppearing: Double = 0.025

	static var moveTime = 0.2
	static var expandTime = 0.1
	static var shrinkTime = 0.2

	var label: SKLabelNode
	var letter: String
	
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
			color: UIColor.init(red: 1, green: 1, blue: 1, alpha: 0),
			size: CGSize(width: Tile.size!, height: Tile.size!)
		)
		
		self.position = Tile.CalcPosition(x: x, y: y)
		self.zPosition = GameScene.Z_TILE

		label.zPosition = GameScene.Z_TILE_LETTER
		label.text = letter
		label.fontName = "ArialRoundedMTBold"
		label.fontSize = Tile.fontSize!
		label.fontColor = UIColor.black
		label.horizontalAlignmentMode = .center
		label.verticalAlignmentMode = .center
		self.addChild(label)
		
		self.run(SKAction.sequence([
			SKAction.fadeAlpha(to: 0, duration: 0),
			SKAction.wait(forDuration: Tile.delayBeforeTileAppears),
			SKAction.group([
				SKAction.fadeAlpha(to: 1, duration: 0.1),
				SKAction.scale(by: 1.6, duration: 0.1)
			]),
			SKAction.scale(by: 0.625, duration: 0.1),
		]))
		
		Tile.delayBeforeTileAppears += Tile.delayBetweenEachTileAppearing

		Tile.scene!.addChild(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func clicked() {
		let targetPosition = Tile.scene!.getPositionOfLetter(c: letter)
		
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
