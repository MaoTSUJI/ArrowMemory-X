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
    
    var correctAnswerLabelArray:[Any] = []
    var yourAnswerLabelArray:[Any] = []
    
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
//        commentLabel.text = sayComment(count: correctCount)

        // ラベルのセルを作成
        let correctAnswerLabelArray = makeLabel(arrowNum: correctNumArray.count, heightLabelRate: 0.4)
        let yourAnswerLabelArray = makeLabel(arrowNum: yourNumArray.count, heightLabelRate: 0.6)
        
        // ラベルにテキスト代入
        for i in 0..<correctAnswerLabelArray.count {
            makeLabelContent(label: correctAnswerLabelArray[i] as? UILabel , arrowId: correctNumArray[i], cellWidth: Double((correctAnswerLabelArray[i] as! UILabel).bounds.height))
        }
        
        for i in 0..<yourAnswerLabelArray.count {
            makeLabelContent(label: yourAnswerLabelArray[i] as? UILabel , arrowId: yourNumArray[i], cellWidth: Double((yourAnswerLabelArray[i] as! UILabel).bounds.height))
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
    
    
    // セルのラベル作成
    func makeLabel(arrowNum: Int, heightLabelRate: Double) -> [Any]  {
        
        // 矢印の表示位置を設定するパラメータ
        // スクリーンの幅・高さを取得
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        
        let constInterval = 0.2 // 矢印のセルとセルの感覚
        let constEdge = 0.5 // セルの端とスクリーンの端との感覚
        // 各定数に応じたセルサイズの算出
        let molecule = Double(screenWidth)
        let denominator = (1 + constInterval) * Double(arrowNum) + 2 * constEdge - constInterval
        let cellWidth = molecule / denominator     // セルのサイズ
        // ラベルの初期位置、次のセルとの間隔を算出
        let x = constEdge * cellWidth
        let y = Double(screenHeight) * heightLabelRate
        let d = cellWidth + constInterval * cellWidth
        
        var labelArray:[Any] = []
        
        // ラベルの生成
        for i in 0..<arrowNum {
            let label = UILabel(frame: CGRect(x: x + (d * Double(i)), y: y , width: cellWidth, height: cellWidth))
            
            // ラベルデザイン
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
            label.layer.cornerRadius = CGFloat(cellWidth * 0.2)  // 角丸のサイズ
            // 生成したラベルを配列に格納
            labelArray.append(label)
            
            view.addSubview(label)

        }
        
        return labelArray
    }
    
    // ラベルの中身生成
    func makeLabelContent(label: UILabel!, arrowId: Int, cellWidth: Double) {
        
        label.font = UIFont.fontAwesome(ofSize: CGFloat(cellWidth), style: .solid)
        label.text = arrowArray[arrowId]  // FontAwesomeで出力
        label.textAlignment = NSTextAlignment.center    // 中央寄せ
        
    }
    
}
