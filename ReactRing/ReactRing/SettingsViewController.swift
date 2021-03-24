//
//  SettingsViewController.swift


import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var sound: UIButton!
    @IBOutlet weak var vibro: UIButton!

    @IBOutlet var LowLevel: UIButton!
    @IBOutlet var MiddleLevel: UIButton!
    @IBOutlet var HighLevel: UIButton!

	override func viewDidLoad() {
        if AppSettings.configuration == .free{
            LowLevel.isSelected = true
            MiddleLevel.isEnabled = false
            HighLevel.isEnabled = false
        }else{
            switch GameLogic.shared.gameDifficult{
            case .easy:
                LowLevelChoosen()
            case .middle:
                MiddleLevelChoosen()
            case .hard:
                HighLevelChoosen()
            }
        }
        sound.isSelected = Options.shared.sound
        vibro.isSelected = Options.shared.vibration
	}
	
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
	@IBAction func backTapped(sender: UIButton) {
		navigationController?.popViewController(animated: true)
	}
    
    @IBAction func SoundTap(_ sender: Any) {
        sound.isSelected = !sound.isSelected
        Options.shared.sound = sound.isSelected
		if Options.shared.sound == false {
            DispatchQueue.global().async {
                AudioManager.shared.pause()
            }
		} else {
			DispatchQueue.global().async {
                AudioManager.shared.play(music: Audio.MusicFiles.background)
            }
		}
    }
    @IBAction func VibroTap(_ sender: Any) {
        vibro.isSelected = !vibro.isSelected
        Options.shared.vibration = vibro.isSelected
    }
    @IBAction func LowLevelTap(_ sender: Any) {
        GameLogic.shared.gameDifficult = .easy
        LowLevelChoosen()
    }
    @IBAction func MiddleLevelTap(_ sender: Any) {
        GameLogic.shared.gameDifficult = .middle
        MiddleLevelChoosen()
    }
    @IBAction func HighLevelTap(_ sender: Any) {
        GameLogic.shared.gameDifficult = .hard
        HighLevelChoosen()
    }

    func LowLevelChoosen(){
        LowLevel.isSelected = true
        MiddleLevel.isSelected = false
        HighLevel.isSelected = false
    }

    func MiddleLevelChoosen(){
        LowLevel.isSelected = false
        MiddleLevel.isSelected = true
        HighLevel.isSelected = false
    }
    func HighLevelChoosen(){
        LowLevel.isSelected = false
        MiddleLevel.isSelected = false
        HighLevel.isSelected = true
    }

}
