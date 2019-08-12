//
//  AnswerViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var resultButton: UIButton!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //////////////////////////////////////////////////////////////////////////////
        resultButton.backgroundColor = .lightGray
        resultButton.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        resultButton.layer.cornerRadius = 18
        resultButton.clipsToBounds = true
        //////////////////////////////////////////////////////////////////////////////
        
        // 前画面で生成したランダムな数字の配列
        let value0 = value[0]
        print("value0: \(value0)")

        // 受け取った値（正しい答え）をIntに変更し、配列に格納
        for num in value0 {
            correctNumArray.append(num as! Int)
        }
        
        // セル（解答欄）の生成
        makeLabel(arrowNum: correctNumArray.count)
        
        print("correctNumArray: \(correctNumArray)")
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
    
    func insertArray() {
        // 入力値の確認
        let num = inputArrowNum
        yourNumArray.append(num)

    }

    // 入力した時の処理
    func didAction() {
        
        // 入力値を配列に格納
        yourNumArray.append(inputArrowNum)
        
        // セルの中に矢印を記入
        makeLabelContent(label: labelArray[count] as? UILabel, arrowId: inputArrowNum, cellWidth: Double((labelArray[count] as! UILabel).bounds.height))
        
        // 答えと一致値したとき、テキストカラーを黒
        if correctNumArray[count] == inputArrowNum {
            (labelArray[count] as! UILabel).textColor = .black
        }else {
            (labelArray[count] as! UILabel).textColor = .red
            
        }
        
        // 動作したらカウントアップ
        count += 1
        
    }
    
    @IBAction func didClickToResult(_ sender: UIButton) {
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
    
////////////////////////////////////////////////////////////////////////////////////////////////////
    // セルのラベル作成
    func makeLabel(arrowNum: Int) {
        
        // クラス記述で省略したい
        ////////////////////////////////////////////////////////////////////////
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
        ////////////////////////////////////////////////////////////////////////

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
        label.text = arrowArray[arrowId]  // FontAwesomeで出力
        label.textAlignment = NSTextAlignment.center    // 中央寄せ
    }
////////////////////////////////////////////////////////////////////////////////////////////////////
    
}
