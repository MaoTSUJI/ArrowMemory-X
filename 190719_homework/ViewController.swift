//
//  ViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/19.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let levelArray = ["easy": 3,"normal": 5,"difficult": 7]
    
    @IBAction func didClickEasy(_ sender: UIButton) {
        let inputValue = levelArray["easy"]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuiz" {
            let nextVC = segue.destination as! QuizViewController
            nextVC.arrowNum = sender as! Int
            
        }
    }


}

