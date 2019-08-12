//
//  ResultViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var correct1: UILabel!
    @IBOutlet weak var correct2: UILabel!
    @IBOutlet weak var correct3: UILabel!
    
    @IBOutlet weak var yourAnswer1: UILabel!
    @IBOutlet weak var yourAnswer2: UILabel!
    @IBOutlet weak var yourAnswer3: UILabel!
    
    @IBOutlet weak var designLabel: UILabel!
    
    // 前のページから受け取る変数を用意
    var arrayValue:[[String]] = [[],[]]
    var correctAnswerArray:[String] = ["1","2","3"]
    var yourAnswer:[String] = ["1","2","3"]
    
    // 正解率をカウント
    var correctCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        replyButton.backgroundColor = .lightGray
        replyButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        replyButton.layer.cornerRadius = 18
        replyButton.clipsToBounds = true
        
        homeButton.backgroundColor = .lightGray
        homeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        homeButton.layer.cornerRadius = 18
        homeButton.clipsToBounds = true
        
        // 正解とあなたの答えの配列分割
        correctAnswerArray = arrayValue[0]
        yourAnswer = arrayValue[1]
        
        // 正答数をカウント
        for i in 0...(yourAnswer.count - 1) {
            if yourAnswer[i] == correctAnswerArray[i] {
                correctCount += 1
            }
        }
        
        resultLabel.text = "\(yourAnswer.count)問中\(correctCount)問正解！"
        
        commentLabel.text = sayComment(count: correctCount)
        
        // ラベルにテキスト代入
        correct1.text = correctAnswerArray[0]
        correct2.text = correctAnswerArray[1]
        correct3.text = correctAnswerArray[2]
        
        yourAnswer1.text = yourAnswer[0]
        yourAnswer2.text = yourAnswer[1]
        yourAnswer3.text = yourAnswer[2]
        
        designLabel.layer.borderWidth = 1.0
        designLabel.layer.borderColor = UIColor.lightGray.cgColor // 枠線の色
        designLabel.layer.cornerRadius = 10.0  // 角丸のサイズ
        
        // Backボタンを削除
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    
    @IBAction func didClickAgain(_ sender: UIButton) {
        let inputValue = arrayValue[0].count
        performSegue(withIdentifier: "backToQuiz", sender: inputValue)
    }

    @IBAction func didClickHome(_ sender: UIButton) {
        performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToQuiz" {
            let nextVC = segue.destination as! QuizViewController
            nextVC.arrowNum = sender as! Int
        }
    }
    
    func sayComment(count: Int) -> String {
        switch count {
        case 0:
            return "全然あかんやん！"
        case 1:
            return "もうちょい頑張りや〜"
        case 2:
            return "おしいな！"
        default:
            return "やるやん！"
        }
    }
    
}
