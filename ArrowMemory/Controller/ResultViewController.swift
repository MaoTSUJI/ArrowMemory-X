//
//  ResultViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var brainImageView: UIImageView!
    @IBOutlet weak var correctNumImageView: UIImageView!
    @IBOutlet weak var NumImageView: UIImageView!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var designLabel: UILabel!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    // 前のページから受け取る変数を用意
    var arrayValue:[[Int]] = [[],[]]
    var correctNumArray:[Int] = []
    var yourNumArray:[Int] = []
    
    // 正解数をカウント
    var correctCount = 0
    
    var correctAnswerLabelArray:[Any] = []
    var yourAnswerLabelArray:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let starSolid = String.fontAwesomeIcon(name: .star)
//        let styleSolid = UIFont.fontAwesome(ofSize: CGFloat(20), style: .solid)
//
//        tweetButton.font = styleSolid
//        tweetButton.textColor = Color().pastelYellow
//        tweetButton.text = starSolid
        
        // 結果発表
        let resultImage = UIImage(named: "resultLabel")
        resultImageView.image = resultImage
                    
        let brainImage = UIImage(named: "brain")
        brainImageView.image = brainImage
        
        
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
        
        resultLabel.text = "\(yourNumArray.count)個中\(correctCount)個正解！"
//        commentLabel.text = sayComment(count: correctCount)

        // ラベルのセルを作成
        correctAnswerLabelArray = makeLabel(arrowNum: correctNumArray.count, heightLabelRate: 0.5)
        yourAnswerLabelArray = makeLabel(arrowNum: yourNumArray.count, heightLabelRate: 0.65)
        
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
        
        
        // 正答率を画像で表示
        let correctNumImage = UIImage(named: showResultNumber(num: correctCount))
        correctNumImageView.image = correctNumImage
        
        let NumImage = UIImage(named: showResultNumber(num: yourNumArray.count))
        NumImageView.image = NumImage
        
    }
    
    @IBAction func didClickTweet(_ sender: UIButton) {
        
        let description1 = "#覚えてシュっ"
        let description2 = "#脳トレアプリ"
        let appName = "#ArrowMemory"
        let url = "https://apps.apple.com/app/id1477570525"
        let data = ["\(yourNumArray.count)個中\(correctCount)個正解！ \n \(url)\n \(appName)\(description1)\(description2)"] as [Any]
        
        let controller = UIActivityViewController(activityItems: data, applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = view
        controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        present(controller, animated: true, completion: nil)

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
    
    
    func showResultNumber(num: Int) -> String {
        
        let imageName: String
        
        switch num {
        case 1:
            imageName = "num_1"
        case 2:
            imageName = "num_2"
        case 3:
            imageName = "num_3"
        case 4:
            imageName = "num_4"
        case 5:
            imageName = "num_5"
        case 6:
            imageName = "num_6"
        case 7:
            imageName = "num_7"
        case 8:
            imageName = "num_8"
        case 9:
            imageName = "num_9"
        case 10:
            imageName = "num_10"
        default:
            imageName = "num_0"
        }
        
        return imageName

    }
    
    
}
