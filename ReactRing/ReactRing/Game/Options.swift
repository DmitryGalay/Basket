//
//  Options.swift

import Foundation

private let kCurrentGameSettingsKey = "currentGameSettingsKey"
private let kGameScoreKey = "gameScoreKey"
private let kPurchasedGameSettingIndexes = "purchasedGameSettingIndexes"
private let kGameVibration = "kGameVibaration"
private let kGameSound = "kGameSound"
private let kGameLevel = "kGameLevel"

class Options {
    static let sharedOptions = Options()
    
	var gameLevel: Int {
		get {
			let level = UserDefaults.standard.integer(forKey: kGameLevel)
			return level == 0 ? 1 : level
		}
		set {
			UserDefaults.standard.set(newValue, forKey: kGameLevel)
			UserDefaults.standard.synchronize()
		}
	}
	
    var currentGameSettingsIndex = 0 {
        didSet {
            UserDefaults.standard.set(currentGameSettingsIndex, forKey: kCurrentGameSettingsKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentGameSettings: GameSettings {
        return allGameSettings[currentGameSettingsIndex]
    }
    
    var allGameSettings = [GameSettings]()
    
    var purchasedGameSettingIndexes = [Int]() {
        didSet {
            UserDefaults.standard.set(purchasedGameSettingIndexes, forKey: kPurchasedGameSettingIndexes)
            UserDefaults.standard.synchronize()
        }
    }
    
    var score = 0 {
        didSet {
            UserDefaults.standard.set(score, forKey: kGameScoreKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var vibration: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: kGameVibration)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: kGameVibration)
        }
    }
    
    var sound: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: kGameSound)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: kGameSound)
        }
    }

    
    
    init() {
        currentGameSettingsIndex = UserDefaults.standard.integer(forKey: kCurrentGameSettingsKey)
        score = UserDefaults.standard.integer(forKey: kGameScoreKey)
        if let savedPurchasedIndexes = UserDefaults.standard.object(forKey: kPurchasedGameSettingIndexes) as? [Int] {
            purchasedGameSettingIndexes = savedPurchasedIndexes
        }
        
        let gameSettings2x3 = GameSettings(rows: 3, columns: 2, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 10, price: 0)
        let gameSettings3x4 = GameSettings(rows: 4, columns: 3, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 30, price: 0)
        let gameSettings4x4 = GameSettings(rows: 5, columns: 3, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 60, price: 0)
        let gameSettings4x5 = GameSettings(rows: 6, columns: 3, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 120, price: purchasedGameSettingIndexes.contains(3) ? 0 : 1000)
        let gameSettings5x6 = GameSettings(rows: 6, columns: 4, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 360, price: purchasedGameSettingIndexes.contains(4) ? 0 : 3000)
//        let gameSettings6x6 = GameSettings(rows: 6, columns: 6, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 720, price: purchasedGameSettingIndexes.contains(5) ? 0 : 13000)
//        let gameSettings4x5 = GameSettings(rows: 4, columns: 5, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 120, price: purchasedGameSettingIndexes.contains(3) ? 0 : 0)
//        let gameSettings5x6 = GameSettings(rows: 5, columns: 6, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 360, price: purchasedGameSettingIndexes.contains(4) ? 0 : 0)
//        let gameSettings6x6 = GameSettings(rows: 6, columns: 6, times: [10, 20, 30], flipsCounts: [100, 100, 100], pointsForStar: 720, price: purchasedGameSettingIndexes.contains(5) ? 0 : 0)

        allGameSettings = [gameSettings2x3, gameSettings3x4, gameSettings4x5]
    }
    
    func gameSettingsIsAvaliableAtIndex(_ index: Int) -> Bool {
        let gameSettings = allGameSettings[index]
        return score >= gameSettings.price
    }
    
    func purchaseGameAtIndex(_ index: Int) {
        score -= allGameSettings[index].price
        allGameSettings[index].price = 0
        
        purchasedGameSettingIndexes.append(index)
    }
}
