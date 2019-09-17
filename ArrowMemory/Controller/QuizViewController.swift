//
//  QuizViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Firebase

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    
    let admobId = "ca-app-pub-4793875012538951/1659731726"
    
    var arrowNum = 3    // 前の画面から持ってきた値, レベルに応じた矢印の数3,5,7
    var arrowRandomArray:[String] = []
    var numRandomArray:[Int] = []
    
    // 生成するラベルを入れる配列を用意
    var labelArray:[Any] = []
    
    var arrowRandomArrayString:[String] = ["0","1","2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 多言語対応
        quizDescriptionLabel.text = NSLocalizedString("quizDescription", comment: "")
        okButton.setTitle(NSLocalizedString("remember", comment: ""), for: .normal)
        backButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        
        // ラベル
        let quizImage = UIImage(named: NSLocalizedString("quizLabel", comment: ""))
        quizImageView.image = quizImage
        
        makeButtonDesign(button: okButton)
        
        // 配列の中身をリセット
        numRandomArray.removeAll()
        arrowRandomArray.removeAll()
        arrowRandomArrayString.removeAll()
        // ランダム配列の作成
        for _ in 0..<arrowNum {
            // 0から5までのランダムな変数を指定
            let randomNum = Int.random(in: 0 ..< Arrow.arrowArray.count)
            numRandomArray.append(randomNum)
            arrowRandomArray.append(Arrow.arrowArray[randomNum])
        }
        
        print("Quiz画面　次に返す値：配列　\(numRandomArray)")
        print("Quiz画面　矢印の確認　\(arrowRandomArrayString)")
        
        // セル、中身の生成
        labelArray = makeLabel(arrowNum: arrowNum, heightLabelRate: 0.25)
        
        for i in 0..<labelArray.count {
            makeLabelContent(label: labelArray[i] as? UILabel, cellWidth: Double((labelArray[i] as! UILabel).bounds.height), arrowId: i, arrowArray: arrowRandomArray)
        }
        
        // バナー広告
        bannerView.adUnitID = admobId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBack", sender: nil)
        
    }
    
    
    // ランダムな番号の配列で返す
    @IBAction func didClickRemember(_ sender: UIButton) {
        
        let inputValue:[[Any]] = [numRandomArray, labelArray]
        performSegue(withIdentifier: "toAnswer", sender: inputValue)
        
//        print("inputValueの中身\(inputValue)")
    }
    
    // 値を渡す準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            let nextVC = segue.destination as! AnswerViewController
            nextVC.value = sender as! [[Any]]
        }
    }


}
