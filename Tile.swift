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
	static var fontSize: CGFloat?
	
	static var delayBeforeTileAppears: Double = 0
	static var delayBetweenEachTileAppearing: Double = 0.025

	static var moveTime = 0.2
	static var expandTime = 0.25
	static var shrinkTime = 0.2
	static var spin90time = 0.1

	var x, y: Int
	var label: SKLabelNode
	var letter: String
	
	static func initialize(scene: GameScene) {
		Tile.scene = scene
		Tile.size = scene.size.width / CGFloat(gridSize)
		Tile.fontSize = scene.frame.width * 0.075
	}
	
	func CalcPosition() {
		var p = CGPoint.zero
		let size = Tile.size!
		p.x = size * CGFloat(self.x)
		p.x += size * 0.5
		p.y = Tile.scene!.frame.height - (size * CGFloat(self.y))
		p.y -= size * 0.5
		self.position = p
	}
	
	@discardableResult init(x: Int, y: Int, letter: String) {
		self.x = x
		self.y = y
		self.letter = letter
		label = SKLabelNode.init(text: letter)
		
		super.init(
			texture: SKTexture(imageNamed: "tile"),
			color: UIColor.white,
			size: CGSize(width: Tile.size!, height: Tile.size!)
		)
		
		self.CalcPosition()
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
	
	func spin(x: CGFloat, y: CGFloat, newLetter: String) {
		self.run(SKAction.sequence([
			SKAction.group([
				SKAction.scaleX(to: x, duration: Tile.spin90time),
				SKAction.scaleY(to: y, duration: Tile.spin90time)
			]),
			SKAction.customAction(withDuration: 0, actionBlock: {_,_ in
				self.letter = newLetter
				self.label.text = newLetter
			}),
			SKAction.group([
				SKAction.scaleX(to: 1, duration: Tile.spin90time),
				SKAction.scaleY(to: 1, duration: Tile.spin90time)
			])
		]))
	}
	
	func spinNeighbour(xoffset: Int, yoffset: Int, xsize: CGFloat, ysize: CGFloat) {
		let x = self.x + xoffset
		
		if x < 0 { return }
		if x >= Tile.gridSize { return }
		
		let y = self.y + yoffset
		
		if y < 0 { return }
		if y >= Tile.gridSize { return }
		
		guard let neighbour = Tile.scene!.grid[y * Tile.gridSize + x] else {
			return
		}
		
		neighbour.spin(x: xsize, y: ysize, newLetter: letter)
	}
	
	func clicked() {
		let targetPosition = Tile.scene!.getPositionOfLetter(c: letter)
		
		if targetPosition != nil {
			self.zPosition = GameScene.Z_TILE_FRONT
			label.zPosition = GameScene.Z_TILE_LETTER_FRONT
			self.run(SKAction.sequence([
				SKAction.scale(by: 2, duration: Tile.expandTime),
				SKAction.group([
					SKAction.move(to: targetPosition!, duration: Tile.moveTime),
					SKAction.scale(by: 0.5, duration: Tile.shrinkTime)
				]),
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

		spinNeighbour(xoffset: -1, yoffset: 0, xsize: 0, ysize: 1);
		spinNeighbour(xoffset: 1, yoffset: 0, xsize: 0, ysize: 1);
		spinNeighbour(xoffset: 0, yoffset: -1, xsize: 1, ysize: 0);
		spinNeighbour(xoffset: 0, yoffset: 1, xsize: 1, ysize: 0);
	}
}
