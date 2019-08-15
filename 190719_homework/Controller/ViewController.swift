//
//  ViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/19.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var difficultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ここの省略法を知りたい
        makeButtonDesign(button: easyButton)
        makeButtonDesign(button: normalButton)
        makeButtonDesign(button: difficultButton)
        
    }

    let levelArray = ["easy": 3,"normal": 5,"difficult": 7]
    
    // レベルを選択し、次の画面へ遷移するボタン
    @IBAction func didClickEasy(_ sender: UIButton) {
        goToQuiz(level: "easy")
    }
    
    @IBAction func didClickNormal(_ sender: UIButton) {
        goToQuiz(level: "normal")
    }
    
    @IBAction func didClickDifficult(_ sender: UIButton) {
        goToQuiz(level: "difficult")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuiz" {
            let nextVC = segue.destination as! QuizViewController
            nextVC.arrowNum = sender as! Int
        }
    }

    // ボタンのデザインを作成
    func makeButtonDesign(button: UIButton!) {
        button.backgroundColor = .lightGray
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
    }
    
    // 選択したレベル情報の値を渡す　//次の画面に遷移
    func goToQuiz(level: String){
        let inputValue = levelArray[level]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }

}

