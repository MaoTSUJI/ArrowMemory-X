//
//  ViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/19.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var difficultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        easyButton.backgroundColor = .lightGray
        easyButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        easyButton.layer.cornerRadius = 18
        easyButton.clipsToBounds = true
        
        normalButton.backgroundColor = .lightGray
        normalButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        normalButton.layer.cornerRadius = 18
        normalButton.clipsToBounds = true
        
        difficultButton.backgroundColor = .lightGray
        difficultButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        difficultButton.layer.cornerRadius = 18
        difficultButton.clipsToBounds = true
        
    }

    let levelArray = ["easy": 3,"normal": 5,"difficult": 7]
    
    // ここもっと短くしたい！！
    @IBAction func didClickEasy(_ sender: UIButton) {
        let inputValue = levelArray["easy"]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }
    
    @IBAction func didClickNormal(_ sender: UIButton) {
        let inputValue = levelArray["normal"]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }
    
    @IBAction func didClickDifficult(_ sender: UIButton) {
        let inputValue = levelArray["difficult"]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuiz" {
            let nextVC = segue.destination as! QuizViewController
            nextVC.arrowNum = sender as! Int
        }
    }


}

