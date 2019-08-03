//
//  QuizViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import FontAwesome_swift

class QuizViewController: UIViewController {

    @IBOutlet weak var arrowQuiz1: UILabel!
    @IBOutlet weak var arrowQuiz2: UILabel!
    @IBOutlet weak var arrowQuiz3: UILabel!
    
    var arrowNum = 3    // 前の画面から持ってきた値, レベルに応じた矢印の数3,5,7
    var arrowRandomArray:[String] = []
    var numRandomArray:[Int] = []
    
    // 生成するラベルを入れる配列を用意
    var labelArray:[Any] = []
    
    // FontAwesomeで矢印配列の用意
    let arrowLeft = String.fontAwesomeIcon(name: .arrowLeft)
    let arrowRight = String.fontAwesomeIcon(name: .arrowRight)
    let arrowUp = String.fontAwesomeIcon(name: .arrowUp)
    let arrowDown = String.fontAwesomeIcon(name: .arrowDown)
    let dotCircle = String.fontAwesomeIcon(name: .dotCircle)
    lazy var arrowArray = [arrowLeft, arrowRight, arrowUp, arrowDown, dotCircle]
    // 下2行デバッグ用
    let arrowArrayString = ["arrowLeft", "arrowRight", "arrowUp", "arrowDown", "dotCircle"]
    var arrowRandomArrayString:[String] = []
    
    // スクリーンの幅・高さを取得
    let screenWidth = Int(UIScreen.main.bounds.size.width)
    let screenHeight = Int(UIScreen.main.bounds.size.height)
    
    let constInterval = 0.2 // 矢印のセルとセルの感覚
    let constEdge = 0.5 // セルの端とスクリーンの端との感覚
    
    // 各定数に応じたセルサイズの算出
    lazy var molecule = Double(screenWidth)
    lazy var denominator = (1 + constInterval) * Double(arrowNum) + 2 * constEdge - constInterval
    lazy var cellWidth = molecule / denominator     // セルのサイズ
    // ラベルの初期位置、次のセルとの間隔を算出
    lazy var x = constEdge * cellWidth
    lazy var y = Double(screenHeight) * 0.2
    lazy var d = cellWidth + constInterval * cellWidth
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        var arrowArray = [arrowLeft, arrowRight, arrowUp, arrowDown, dotCircle]
        // 変数iを使わないのであれば、[_]で代用すれば良い
        for _ in 0..<arrowNum {
            // 0から5までのランダムな変数を指定
            let randomNum = Int.random(in: 0 ..< arrowArray.count)
            arrowRandomArray.append(arrowArray[randomNum])
            // 確認用
            arrowRandomArrayString.append(arrowArrayString[randomNum])
        }
        
        print("次に返す値：配列　\(numRandomArray)")
        print("矢印の確認　\(arrowRandomArrayString)")
        
        // セル、中身の生成
        makeLabel(arrowNum: arrowNum)
        
        for i in 0..<labelArray.count {
            makeLabelContent(label: labelArray[i] as? UILabel, num: i, cellWidth: cellWidth)
        }
        
    }
    
    // ランダムな番号の配列で返す
    @IBAction func didClickRemember(_ sender: UIButton) {
        let inputValue = numRandomArray
        performSegue(withIdentifier: "toAnswer", sender: inputValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            let nextVC = segue.destination as! AnswerViewController
            nextVC.correctNumArray = sender as! [Int]
        }
    }

    // セルのラベル作成
    func makeLabel(arrowNum: Int) {
        
        // ラベルの生成
        for i in 0..<arrowNum {
            let label = UILabel(frame: CGRect(x: x + (d * Double(i)), y: y , width: cellWidth, height: cellWidth))
            
            // ラベルデザイン
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
            label.layer.cornerRadius = CGFloat(cellWidth * 0.2)  // 角丸のサイズ
            
            labelArray.append(label)
            
            view.addSubview(label)
        }
    }
    
    // ラベルの中身生成
    func makeLabelContent(label: UILabel!, num: Int, cellWidth: Double) {
        label.font = UIFont.fontAwesome(ofSize: CGFloat(cellWidth), style: .solid)
        label.text = arrowRandomArray[num]  // FontAwesomeで出力
        label.textAlignment = NSTextAlignment.center    // 中央寄せ
    }


}

