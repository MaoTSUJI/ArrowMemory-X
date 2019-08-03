//
//  AnswerViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var arrow1: UILabel!
    @IBOutlet weak var arrow2: UILabel!
    @IBOutlet weak var arrow3: UILabel!
    
    // 前のページから受け取る変数
    // 正しい答えの配列番号
    var correctNumArray:[Int] = []
    // あなたの回答の配列番号
    var yourNumArray:[Int] = []
    // スワイプまたはタップされた回数をカウントする変数
    var count = 0
    
    var inputArrowNum :Int = 0
    
    // 冗長やから省略したい
    ////////////////////////////////////////////////////////////////////////////////
    // FontAwesomeで矢印配列の用意
    let arrowLeft = String.fontAwesomeIcon(name: .arrowLeft)
    let arrowRight = String.fontAwesomeIcon(name: .arrowRight)
    let arrowUp = String.fontAwesomeIcon(name: .arrowUp)
    let arrowDown = String.fontAwesomeIcon(name: .arrowDown)
    let dotCircle = String.fontAwesomeIcon(name: .dotCircle)
    lazy var arrowArray = [arrowLeft, arrowRight, arrowUp, arrowDown, dotCircle]
    let arrowArrayString = ["arrowLeft", "arrowRight", "arrowUp", "arrowDown", "dotCircle"]
    ////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セルの作成(ダミー)
        makeCell(arrowNum: correctNumArray.count)
        
        // Backボタンを削除
        navigationController?.navigationBar.isHidden = true
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
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        inputArrowNum = 4
        didAction()
    }
    
    func insertArray() {
        // 入力値の確認
        let value = inputArrowNum
        yourNumArray.append(value)

    }

    // 入力した時の処理
    func didAction() {
        
        
        // 動作したらカウントアップ
        count += 1
        
        // 答えと一致した時テキストカラーを黒、一致しなかったとき赤
        if count == 1 {
            arrow1.text = yourAnswerArray[0]
            if correctAnswerArray[0] == yourAnswerArray[0] {
                arrow1.textColor = .black
            } else {
                arrow1.textColor = .red
            }
            
            arrow2.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色

        } else if count == 2 {
            arrow2.text = yourAnswerArray[1]
            if correctAnswerArray[1] == yourAnswerArray[1] {
                arrow2.textColor = .black
            } else {
                arrow2.textColor = .red
            }
            
            arrow3.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
            
        } else if count == 3 {
            arrow3.text = yourAnswerArray[2]
            if correctAnswerArray[2] == yourAnswerArray[2] {
                arrow3.textColor = .black
            } else {
                arrow3.textColor = .red
            }
        }
        
    }
    
 
    
    @IBAction func didClickToResult(_ sender: UIButton) {
        // 複数の配列を送るために、多重配列を用意
        var arrays:[[String]] = [[],[]]
        arrays[0] = correctAnswerArray
        arrays[1] = yourAnswerArray
   
//        print(arrays)
        
        let inputValue = arrays
        performSegue(withIdentifier: "toResult", sender: inputValue)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let nextVC = segue.destination as! ResultViewController
            nextVC.arrayValue = sender as! [[String]]
        }
    }

// 冗長やから省略したい
////////////////////////////////////////////////////////////////////////////////
    // セルのラベル作成　（ダミー）
    func makeCell(arrowNum: Int) {
        // スクリーンの幅・高さを取得
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        var cellWidth = 0.0   // 矢印のセルサイズ （これは変数）
        let constInterval = 0.2 // 矢印のセルとセルの感覚
        let constEdge = 0.5 // セルの端とスクリーンの端との感覚
        
        // 各定数に応じたセルサイズの算出
        let molecule = Double(screenWidth)
        let denominator = (1 + constInterval) * Double(arrowNum) + 2 * constEdge - constInterval
        cellWidth = molecule / denominator
        // ラベルの初期位置、次のセルとの間隔を算出
        let x = constEdge * cellWidth
        let y = Double(screenHeight) * 0.2
        let d = cellWidth + constInterval * cellWidth
        
        // ラベルの生成
        for i in 0..<arrowNum {
            let label = UILabel(frame: CGRect(x: x + (d * Double(i)), y: y , width: cellWidth, height: cellWidth))
            
            // ラベルの中身生成
            label.font = UIFont.fontAwesome(ofSize: CGFloat(cellWidth), style: .solid)
            
            label.textAlignment = NSTextAlignment.center
            
            // ラベルデザイン
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
            label.layer.cornerRadius = CGFloat(cellWidth * 0.2)  // 角丸のサイズ
            
            view.addSubview(label)
        }
    }
////////////////////////////////////////////////////////////////////////////////


    
    
}
