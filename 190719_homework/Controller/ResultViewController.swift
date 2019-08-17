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
    @IBOutlet weak var designLabel: UILabel!
    
    // 前のページから受け取る変数を用意
    var arrayValue:[[Int]] = [[],[]]
    var correctNumArray:[Int] = []
    var yourNumArray:[Int] = []
    
    // 正解率をカウント
    var correctCount = 0
    
    var correctAnswerLabelArray:[Any] = []
    var yourAnswerLabelArray:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeButtonDesign(button: replyButton)
        makeButtonDesign(button: homeButton)
        
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
//        commentLabel.text = sayComment(count: correctCount)

        // ラベルのセルを作成
        correctAnswerLabelArray = makeLabel(arrowNum: correctNumArray.count, heightLabelRate: 0.4)
        yourAnswerLabelArray = makeLabel(arrowNum: yourNumArray.count, heightLabelRate: 0.6)
        
        // ラベルにテキスト代入
        for i in 0..<correctAnswerLabelArray.count {
            
            makeLabelContent(label: correctAnswerLabelArray[i] as? UILabel, cellWidth: Double((correctAnswerLabelArray[i] as! UILabel).bounds.height), arrowId: correctNumArray[i], arrowArray: Arrow.arrowArray)

        }
        
        for i in 0..<yourAnswerLabelArray.count {
            
            makeLabelContent(label: yourAnswerLabelArray[i] as? UILabel, cellWidth: Double((yourAnswerLabelArray[i] as! UILabel).bounds.height), arrowId: yourNumArray[i], arrowArray: Arrow.arrowArray)
            
            // 答えと一致値したとき、テキストカラーを黒
            if correctNumArray[i] == yourNumArray[i] {
                (yourAnswerLabelArray[i] as! UILabel).textColor = .black
            }else {
                (yourAnswerLabelArray[i] as! UILabel).textColor = .red
                
            }
            
        }
        
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
    
    
}
