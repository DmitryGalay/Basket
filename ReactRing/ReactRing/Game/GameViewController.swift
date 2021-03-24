//
//  GameViewController.swift
//  ThimbleCards
//
//  Created by Dmitry Pavlov on 26.03.2020.
//  Copyright © 2020 Dmitry Pavlov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerProtocol{
    func showWinController()
    func showLoseController()
//    func updateScoreLabel(str: String)
}

protocol GameViewControllerDelegate{
    func startNewGame()
    func goToMainMenu()
}

class GameViewController: UIViewController {

    @IBAction func BackButtonAction(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    
//    @IBOutlet var score: UILabel!
    
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        scene?.gameViewController = self
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        //skView.ignoresSiblingOrder = true
        scene?.scaleMode = .resizeFill
        skView.presentScene(scene)
        if AppSettings.configuration == .free{
            AdMobMnager.shared.addBanner(viewController: self, bannerPosition: .bottom)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        scene?.removeFromParent()
//        scene = nil
//    }
}

extension GameViewController: GameViewControllerProtocol {
    
//    func updateScoreLabel(str: String) {
//        score.text = str
//    }
    
    func showLoseController() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoseView") as? LoseViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func showWinController(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WinView") as? WinViewController else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension GameViewController: GameViewControllerDelegate{
    func goToMainMenu() {
        navigationController?.popViewController(animated: true)
    }
    
    func startNewGame() {
        scene?.resetScene()
    }
}
