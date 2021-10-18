//
//  GameScene.swift
//  Letters
//
//  Created by Andrew Smith on 11/10/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	static var Z_TILE: CGFloat = 1
	static var Z_TILE_LETTER: CGFloat = 2
	static var Z_TILE_FRONT: CGFloat = 3
	static var Z_TILE_LETTER_FRONT: CGFloat = 4

//	var grid = [[Tile?](repeating: nil, count: Tile.gridSize)](repeating: nil, count: Tile.gridSize)
	var grid = [Tile?](repeating: nil, count: Tile.gridSize * Tile.gridSize)
	
	static var asciiA = UnicodeScalar("A").value
	
	class Letter {
		var c: String
		var x: CGFloat
		init(c: String, x: CGFloat) {
			self.c = c
			self.x = x
		}
	}
	
	var letters = [Letter]()

    override func didMove(to view: SKView) {

		Tile.initialize(scene: self)
		
		class GridLocation {
			var x, y: Int
			var indexInWord: Int?
			init (x: Int, y: Int, indexInWord: Int? = nil) {
				self.x = x
				self.y = y
				self.indexInWord = indexInWord
			}
		}
		
		var availableForNeededLetters = [GridLocation]()
		var availableForRandomLetters = [GridLocation]()
		var neededLetterPositions = [GridLocation]()

		for x in 0..<Tile.gridSize {
			for y in 0..<Tile.gridSize {
				availableForNeededLetters.append(GridLocation(x: x, y: y))
				availableForRandomLetters.append(GridLocation(x: x, y: y))
			}
		}
		
		let word = "EXAMPLE"
		
		var x = self.size.width
		x -= Tile.size! * CGFloat(word.count)
		x *= 0.5
		x += Tile.size! * 0.5
		
		for c in word {
			let l = Letter(c: String(c), x: x)
			letters.append(l)
			x += Tile.size!
		}
		
		for index in 0..<letters.count {
			let l = letters[index]
			let r = Int.random(in: 0..<availableForNeededLetters.count)
			let loc = availableForNeededLetters[r]
			
			availableForNeededLetters.removeAll(where: {
				(loc.x-1...loc.x+1).contains($0.x) &&
				(loc.y-1...loc.y+1).contains($0.y)
			})
			
			availableForRandomLetters.removeAll(where: {
				$0.x == loc.x && $0.y == loc.y
			})

			let t = Tile(
				x: loc.x, y: loc.y,
				letter: l.c
			)
			
			grid[loc.y * Tile.gridSize + loc.x] = t
			
			let loc2 = GridLocation(x: loc.x, y: loc.y, indexInWord: index)
			neededLetterPositions.append(loc2)
		}
		
		for loc in neededLetterPositions {
			var surrounding = [GridLocation]()
			surrounding.append(GridLocation(x: loc.x-1, y: loc.y))
			surrounding.append(GridLocation(x: loc.x+1, y: loc.y))
			surrounding.append(GridLocation(x: loc.x, y: loc.y-1))
			surrounding.append(GridLocation(x: loc.x, y: loc.y+1))

			surrounding.removeAll(where: {
				$0.x < 0 ||
				$0.x >= Tile.gridSize ||
				$0.y < 0 ||
				$0.y >= Tile.gridSize
			})
			
			surrounding.removeAll(where: {
				grid[$0.y * Tile.gridSize + $0.x] != nil
			})
			
			for sloc in surrounding {
				let t = Tile(x: sloc.x, y: sloc.y, letter: String(word.randomElement()!))
				grid[sloc.y * Tile.gridSize + sloc.x] = t
			}
		}

//		for _ in 1...3 {
//			for c in word {
//				let r = Int.random(in: 0..<availableForRandomLetters.count)
//				let loc = availableForRandomLetters[r]
//				availableForRandomLetters.remove(at: r)
//
//				let t = Tile(
//					x: loc.x, y: loc.y,
//					letter: String(c)
//				)
//
//				grid[loc.y][loc.x] = t
//			}
//		}

//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
    }
    
	func getPositionOfLetter(c: String) -> CGPoint? {
		if let index = letters.firstIndex(where: { $0.c == c }) {
			let l = letters[index]
			letters.remove(at: index)
			return CGPoint(x: l.x, y: Tile.size!)
		}
		
		return nil
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
				(n as! Tile).clicked()
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
