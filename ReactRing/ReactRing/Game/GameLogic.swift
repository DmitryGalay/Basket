//
//  GameLogic.swift
//  ThimbleCards
//
//  Created by Dmitry Pavlov on 28.03.2020.
//  Copyright © 2020 Dmitry Pavlov. All rights reserved.
//

import Foundation
class GameLogic{
    private let kGameDifficult = "kGameDifficult"
    private let kScoreEasy = "kScoreEasy"
    private let kScoreMiddle = "kScoreMiddle"
    private let kScoreHard = "kScoreHard"

    static let shared = GameLogic()

    enum GameDifficults: Int{
        case easy = 0
        case middle
        case hard
    }
    
    var gameDifficult: GameDifficults{
        get{
            let difficult = UserDefaults.standard.integer(forKey: kGameDifficult)
            return GameDifficults.init(rawValue: difficult) ?? GameDifficults.easy
        }
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: kGameDifficult)
            UserDefaults.standard.synchronize()
        }
    }
    var score: Int{
        get{
            switch gameDifficult {
            case .easy:
                return UserDefaults.standard.integer(forKey: kScoreEasy)
            case .middle:
                return UserDefaults.standard.integer(forKey: kScoreMiddle)
            case .hard:
                return UserDefaults.standard.integer(forKey: kScoreHard)
            }
        }
        set{
            switch gameDifficult {
            case .easy:
                UserDefaults.standard.set(newValue, forKey: kScoreEasy)
                UserDefaults.standard.synchronize()
            case .middle:
                UserDefaults.standard.set(newValue, forKey: kScoreMiddle)
                UserDefaults.standard.synchronize()
            case .hard:
                UserDefaults.standard.set(newValue, forKey: kScoreHard)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
