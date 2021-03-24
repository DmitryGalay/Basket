//
//  WinViewController.swift
//  JokerSortBall
//
//  Created by Dmitry Pavlov on 21.04.2020.
//

import UIKit

class LoseViewController: UIViewController {

    @IBAction func homeButtonTouch(_ sender: Any) {
        self.dismiss(animated: true){
            self.delegate?.goToMainMenu()
        }
    }
    @IBAction func restartButtonTouch(_ sender: Any) {
        self.dismiss(animated: true){
            self.delegate?.startNewGame()
        }
    }
    var delegate: GameViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
