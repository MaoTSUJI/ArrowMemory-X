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
    
    @IBOutlet weak var okButton: UIButton!
    
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
//    let dotCircle = String.fontAwesomeIcon(name: .dotCircle)
    lazy var arrowArray = [arrowLeft, arrowRight, arrowUp, arrowDown]
    // 下2行デバッグ用
    let arrowArrayString = ["arrowLeft", "arrowRight", "arrowUp", "arrowDown"]
    var arrowRandomArrayString:[String] = ["0","1","2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeButtonDesign(button: okButton)
        
        // 配列の中身をリセット
        numRandomArray.removeAll()
        arrowRandomArray.removeAll()
        arrowRandomArrayString.removeAll()
        // ランダム配列の作成
        for _ in 0..<arrowNum {
            // 0から5までのランダムな変数を指定
            let randomNum = Int.random(in: 0 ..< arrowArray.count)
            numRandomArray.append(randomNum)
            arrowRandomArray.append(arrowArray[randomNum])
        }
        
        print("Quiz画面　次に返す値：配列　\(numRandomArray)")
        print("Quiz画面　矢印の確認　\(arrowRandomArrayString)")
        
        // セル、中身の生成
        makeLabel(arrowNum: arrowNum)
        
        for i in 0..<labelArray.count {
            makeLabelContent(label: labelArray[i] as? UILabel, arrowId: i, cellWidth: Double((labelArray[i] as! UILabel).bounds.height))
        }
        
    }
    
    // ランダムな番号の配列で返す
    @IBAction func didClickRemember(_ sender: UIButton) {
        
        let inputValue:[[Any]] = [numRandomArray, labelArray]
        performSegue(withIdentifier: "toAnswer", sender: inputValue)
        
        print("inputValueの中身\(inputValue)")
    }
    
    // 値を渡す準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            let nextVC = segue.destination as! AnswerViewController
            nextVC.value = sender as! [[Any]]
        }
    }

    // セルのラベル作成
    func makeLabel(arrowNum: Int) {
        
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
        let y = Double(screenHeight) * 0.2
        let d = cellWidth + constInterval * cellWidth
        
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
    }
    
    // ラベルの中身生成
    func makeLabelContent(label: UILabel!, arrowId: Int, cellWidth: Double) {
        label.font = UIFont.fontAwesome(ofSize: CGFloat(cellWidth), style: .solid)
        label.text = arrowRandomArray[arrowId]  // FontAwesomeで出力
        label.textAlignment = NSTextAlignment.center    // 中央寄せ
    }

    // ボタンのデザインを作成
    func makeButtonDesign(button: UIButton!) {
        button.backgroundColor = .lightGray
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
    }

}
