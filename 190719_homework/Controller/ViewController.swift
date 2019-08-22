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
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var difficultButton: UIButton!
    
    @IBOutlet weak var easyLevelLabel: UILabel!
    @IBOutlet weak var normalLevelLabel: UILabel!
    @IBOutlet weak var difficultLevelLabel: UILabel!
    
    let levelArray = ["easy": 5, "normal": 7, "difficult": 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ラベル
        let titleImage = UIImage(named: "title")
        titleImageView.image = titleImage
        
        let logoImage = UIImage(named: "splashImage")
        logoImageView.image = logoImage
        
        // 各ボタンのデザインを設定
        makeButtonDesign(button: easyButton)
        makeButtonDesign(button: normalButton)
        makeButtonDesign(button: difficultButton)
        
        // レベルに合わせて星のアイコンを表示
        makeLevelLabel(label: easyLevelLabel, level: "easy")
        makeLevelLabel(label: normalLevelLabel, level: "normal")
        makeLevelLabel(label: difficultLevelLabel, level: "difficult")
        
    }
    
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

    // 選択したレベル情報の値を渡す　//次の画面に遷移
    func goToQuiz(level: String){
        let inputValue = levelArray[level]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }
    
    // レベルに合わせて星のアイコンを設置
    func makeLevelLabel(label: UILabel, level: String) {
        
        var stars = ""
        let num = levelArray[level]!
        let starSolid = String.fontAwesomeIcon(name: .star)
        let styleSolid = UIFont.fontAwesome(ofSize: CGFloat(20), style: .solid)
        
        for _ in 0 ..< num {
            stars += starSolid
        }
        
        label.font = styleSolid
        label.textColor = Color().pastelYellow
        label.text = stars
        
    }
    
}

