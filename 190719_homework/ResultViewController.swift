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
    
    // 冗長やから省略したい
    ////////////////////////////////////////////////////////////////////////////////
    // FontAwesomeで矢印配列の用意
    let arrowLeft = String.fontAwesomeIcon(name: .arrowLeft)
    let arrowRight = String.fontAwesomeIcon(name: .arrowRight)
    let arrowUp = String.fontAwesomeIcon(name: .arrowUp)
    let arrowDown = String.fontAwesomeIcon(name: .arrowDown)
    //    let dotCircle = String.fontAwesomeIcon(name: .dotCircle)
    lazy var arrowArray = [arrowLeft, arrowRight, arrowUp, arrowDown]
    let arrowArrayString = ["arrowLeft", "arrowRight", "arrowUp", "arrowDown"]
    ////////////////////////////////////////////////////////////////////////////////
    
    // 前のページから受け取る変数を用意
    var arrayValue:[[Int]] = [[],[]]
    var correctNumArray:[Int] = []
    var yourNumArray:[Int] = []
    
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
        
        correctNumArray = arrayValue[0] // 正解
        yourNumArray = arrayValue[1]    // あなたの答え
        
        print(correctNumArray.count, yourNumArray.count)
        // 正答数をカウント
        for i in 0...(yourNumArray.count - 1) {
            if yourNumArray[i] == correctNumArray[i] {
                correctCount += 1
            }
        }
        
        resultLabel.text = "\(yourNumArray.count)問中\(correctCount)問正解！"
        
        commentLabel.text = sayComment(count: correctCount)
        
        // ラベルにテキスト代入
        correct1.text = arrowArray[correctNumArray[0]]
        correct2.text = arrowArray[correctNumArray[1]]
        correct3.text = arrowArray[correctNumArray[2]]
        
        yourAnswer1.text = arrowArray[yourNumArray[0]]
        yourAnswer2.text = arrowArray[yourNumArray[1]]
        yourAnswer3.text = arrowArray[yourNumArray[2]]
        
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
