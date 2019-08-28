//
//  AnswerViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var swipeSpaceLabel: UILabel!
    
    // 前のページから受け取る値
    var value:[[Any]] = []
    
    // 正しい答えの配列番号
    var correctNumArray:[Int] = []
    var arrowNum:Int = 3

    
    // あなたの回答の配列番号
    var yourNumArray:[Int] = []
    // スワイプまたはタップされた回数をカウントする変数
    var count = 0
    
    var inputArrowNum :Int = 0
    
    // 生成するラベルを入れる配列を用意
    var labelArray:[Any] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ラベル
        let answerImage = UIImage(named: "answerLabel")
        answerImageView.image = answerImage
        
        // スワイプする場所のデザイン
        let rgba = UIColor(red: 59/256, green: 174/256, blue: 170/256, alpha: 0.8)
        
        swipeSpaceLabel.textColor = UIColor.black
        swipeSpaceLabel.backgroundColor = Color().pastelYellow
        swipeSpaceLabel.textAlignment = NSTextAlignment.center
        swipeSpaceLabel.layer.cornerRadius = 10
        swipeSpaceLabel.clipsToBounds = true      // labelの時は必須（角丸）

    //////////////////////////////////////////////////////////////////////////////
        makeButtonDesign(button: resultButton)
        //////////////////////////////////////////////////////////////////////////////
        
        // 前画面で生成したランダムな数字の配列
        let value0 = value[0]
        print("value0: \(value0)")

        // 受け取った値（正しい答え）をIntに変更し、配列に格納
        for num in value0 {
            correctNumArray.append(num as! Int)
        }
        
        arrowNum = correctNumArray.count
        
        // セル（解答欄）の生成
        labelArray = makeLabel(arrowNum: arrowNum, heightLabelRate: 0.25)
        
        for i in 0 ..< arrowNum {
        
            let label = labelArray[i] as! UILabel
            
            if i == 0 {
                label.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
            } else {
                label.layer.borderColor = UIColor.lightGray.cgColor // 枠線の色
            }
            
        }

        
        print("correctNumArray: \(correctNumArray)")

    }
    
    // スワイプ、またはタップをした時の処理
    @IBAction func switeLeft(_ sender: UISwipeGestureRecognizer) {
        inputArrowNum = 0
        didAction()
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        inputArrowNum = 1
        didAction()
    }
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        inputArrowNum = 2
        didAction()
    }
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        inputArrowNum = 3
        didAction()
    }
    
    func insertArray() {
        // 入力値の確認
        let num = inputArrowNum
        yourNumArray.append(num)

    }

    // 入力した時の処理
    func didAction() {
        
        // 指定の数以上入力したら、中断
        if count >= arrowNum {
            return
        }
        
        // 入力値を配列に格納
        yourNumArray.append(inputArrowNum)
        
        print("count: \(count)")
        print("labelArray: \(labelArray)")
        
        // セルの中に矢印を記入
        makeLabelContent(label: labelArray[count] as? UILabel, cellWidth: Double((labelArray[count] as! UILabel).bounds.height), arrowId: inputArrowNum, arrowArray: Arrow.arrowArray)
        
        // 答えと一致値したとき、テキストカラーを黒
        if correctNumArray[count] == inputArrowNum {
            (labelArray[count] as! UILabel).textColor = .black
        }else {
            (labelArray[count] as! UILabel).textColor = .red
            
        }
        
        // 動作したらカウントアップ
        count += 1
        
        if count < labelArray.count {
            let label = labelArray[count] as! UILabel
            label.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
        }
        
        
        
    }
    
    @IBAction func didClickToResult(_ sender: UIButton) {
        
        // 3個入力していないと、処理を中断
        if yourNumArray.count != arrowNum {
            return
        }
        
        // 複数の配列を送るために、多重配列を用意
        var arrays:[[Int]] = [[],[]]
        arrays[0] = correctNumArray
        arrays[1] = yourNumArray
        
        let inputValue = arrays
        
        print("correctNumArray: \(correctNumArray)")
        print("yourNumArray: \(yourNumArray)")
        performSegue(withIdentifier: "toResult", sender: inputValue)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let nextVC = segue.destination as! ResultViewController
            nextVC.arrayValue = sender as! [[Int]]
        }
    }
    
    
}
