//
//  Options.swift

import Foundation

private let kGameVibration = "kGameVibaration"
private let kGameSound = "kGameSound"
private let kGameScoreKey = "gameScoreKey"

class Options {
    static let shared = Options()
    
	init() {
		if UserDefaults.standard.value(forKey: kGameSound) == nil {
			sound = true
		}
		if UserDefaults.standard.value(forKey: kGameVibration) == nil {
			vibration = true
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
	
	var score: Int {
		set {
            UserDefaults.standard.set(newValue, forKey: kGameScoreKey)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: kGameScoreKey)
        }
    }
}
