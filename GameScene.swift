//
//  GameScene.swift
//  Letters
//
//  Created by Andrew Smith on 11/10/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

//	var grid = [[Tile?](repeating: nil, count: Tile.gridSize)](repeating: nil, count: Tile.gridSize)
	var grid = Array(repeating: [Tile?](repeating: nil, count: Tile.gridSize), count: Tile.gridSize)

    override func didMove(to view: SKView) {

		Tile.initialize(scene: self)
		
		class GridLocation {
			var x, y: Int
			init (x: Int, y: Int) {
				self.x = x
				self.y = y
			}
		}
		
		var available = [GridLocation]()
		
		for x in 0..<Tile.gridSize {
			for y in 0..<Tile.gridSize {
				available.append(GridLocation(x: x, y: y))
			}
		}
		
		let word = "EXAMPLE"
		for c in word {
			let r = Int.random(in: 0..<available.count)
			let loc = available[r]
			available.remove(at: r)
			let t = Tile(x: loc.x, y: loc.y, letter: String(c))
			grid[loc.y][loc.x] = t
		}
		

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
		guard let touch = touches.first else {
			 return
		}
		
		let touchPosition = touch.location(in: self)
		let touchedNodes = nodes(at: touchPosition)

		for n in touchedNodes {
			if n is Tile {
				n.run(SKAction.sequence([
					SKAction.group([
						SKAction.scale(by: 1.5, duration: 0.2),
						SKAction.fadeOut(withDuration: 0.2)
					]),
					SKAction.removeFromParent()
				]))
				return
			}
		}
	}

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        if let label = self.label {
////            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
////        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
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
