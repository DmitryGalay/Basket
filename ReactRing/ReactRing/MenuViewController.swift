//
//  ViewController.swift


import UIKit
import GameKit

import GLKit

class MenuViewController: UIViewController {
	
	@IBOutlet var hdLogo: UIImageView!
	
	var isAuthenticated: Bool? {
		didSet {
			if isAuthenticated != oldValue, isAuthenticated == true {
				UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
				UserDefaults.standard.synchronize()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        hdLogo.isHidden = AppSettings.configuration == .free
		
		isAuthenticated = UserDefaults.standard.object(forKey: "isAuthenticated") as? Bool
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		AudioManager.shared.play(music: Audio.MusicFiles.background)
	}
	
    //MARK: - Actions
    @IBAction func didTappedLeadersboardButton(_ sender: UIButton) {
        reportScore()
    }
	
	//MARK: - Private methods
	 private func reportScore() {
		 authPlayerOnStart(false) { (success) in
			 if success {
				 self.reportScoreAndShowLeaderBoard()
			 }
		 }
	 }
	 
	 func reportScoreAndShowLeaderBoard() {
        guard let leaderboardId = AppSettings.leaderboardId else {
                   return
               }
        let scoreReporter = GKScore(leaderboardIdentifier: leaderboardId)
		 scoreReporter.value = Int64(Options.shared.score)
		 
		 let scoreArray = [scoreReporter]
		 GKScore.report(scoreArray, withCompletionHandler: nil)
		 
		 showGameCenterVC()
	 }
	 
	 private func showGameCenterVC() {
		 let gameCenterVC = GKGameCenterViewController()
		 gameCenterVC.gameCenterDelegate = self
		 
		 present(gameCenterVC, animated: true, completion: nil)
	 }
	 
	 private func authPlayerOnStart(_ onStart: Bool, block: @escaping (_ success: Bool) -> ()) {
		 if onStart, isAuthenticated != true {
			 block(false)
			 return
		 }
		 
		 if !onStart, isAuthenticated == true {
			 block(true)
			 return
		 }

		 let localPlayer = GKLocalPlayer.local
		 localPlayer.authenticateHandler = { (controller, error) in
			 if let currentController = controller {
				 self.present(currentController, animated: true, completion: nil)
			 } else {
				 self.isAuthenticated = error == nil ? localPlayer.isAuthenticated : false
				 block(localPlayer.isAuthenticated)
			 }
		 }
	 }
}

//MARK: - Extensions
extension MenuViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
