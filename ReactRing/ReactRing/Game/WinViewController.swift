//
//  WinViewController.swift
//  JokerSortBall
//
//  Created by Dmitry Pavlov on 21.04.2020.
//

import UIKit

class WinViewController: UIViewController {

    var delegate: GameViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)
        self.dismiss(animated: true){
            self.delegate?.startNewGame()
        }
    }
}
