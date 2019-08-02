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
    // 正しい答えの配列
    var correctAnswerArray:[String] = ["空やで"]
    // あなたの回答
    var yourAnswerArray:[String] = ["1","2","3"]
    // スワイプまたはタップされた回数をカウントする変数
    var count = 0
    
    var inputArrow :String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrow1.text = correctAnswerArray[0]
        arrow2.text = correctAnswerArray[1]
        arrow3.text = correctAnswerArray[2]
        
        arrow1.textColor = .clear
        arrow2.textColor = .clear
        arrow3.textColor = .clear
        
        arrow1.layer.borderWidth = 1.0
        arrow1.layer.borderColor = UIColor.darkGray.cgColor // 枠線の色
        arrow1.layer.cornerRadius = 10.0  // 角丸のサイズ
    
        arrow2.layer.borderWidth = 1.0
        arrow2.layer.borderColor = UIColor.lightGray.cgColor // 枠線の色
        arrow2.layer.cornerRadius = 10.0  // 角丸のサイズ
    
        arrow3.layer.borderWidth = 1.0
        arrow3.layer.borderColor = UIColor.lightGray.cgColor // 枠線の色
        arrow3.layer.cornerRadius = 10.0  // 角丸のサイズ
        
        
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        inputArrow = "・"
        didAction()
    }
    
    @IBAction func switeLeft(_ sender: UISwipeGestureRecognizer) {
        inputArrow = "←"
        didAction()
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        inputArrow = "→"
        didAction()
    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        inputArrow = "↑"
        didAction()
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        inputArrow = "↓"
        didAction()
    }

    // タップまたはスワイプのアクションを起こしたとき、
    func didAction() {
        
        // 入力値の確認
        let value = inputArrow
        yourAnswerArray[count] = value!
        // 入力値（配列）の確認
        print(yourAnswerArray)
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
        print(count)
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
    
}
