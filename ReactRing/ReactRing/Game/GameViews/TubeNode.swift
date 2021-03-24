//
//  TubeNode.swift
//  TubeSorter
//
//  Created by Dmitry Pavlov on 11.04.2020.
//  Copyright © 2020 Dmitry Pavlov. All rights reserved.
//

import Foundation
import SpriteKit
class TubeNode: SKSpriteNode{
    var capacity: Int = 5{
        willSet{
            if newValue < 2 {
                self.capacity = 2
            }
        }
    }
    var balls = [BallNode](){
        willSet{
            if balls.count == capacity{
                return
            }
        }
    }
    var finished: Bool{
        balls.count == capacity && balls.allSatisfy{
            $0.textureNum == balls.first?.textureNum
        }
    }
}
