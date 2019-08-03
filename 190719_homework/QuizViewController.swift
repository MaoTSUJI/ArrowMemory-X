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
    
    var arrowNum = 0    // 前の画面から持ってきた値, レベルに応じた矢印の数3,5,7
    let arrowArray:[String] = ["←", "→", "↑", "↓", "・"]
    var arrowRandomArray:[String] = []
    
    //インスタンスプロパティの初期化式に他のインスタンス変数を使用することはできない
    // クラスに直接処理を書いてはいけない、関数の中で処理を書く
    // クラスに書いていいのは、プロパティ(変数の宣言)とメソッド(関数の宣言)
    // 処理を書くならメソッドの中に
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 変数iを使わないのであれば、[_]で代用すれば良い
        for _ in 0..<arrowNum {
            // 0から5までのランダムな変数を指定
            var randomNum = Int.random(in: 0 ..< arrowArray.count)
            arrowRandomArray.append(arrowArray[randomNum])
        }
        
        arrowQuiz1.text = arrowRandomArray[0]
        arrowQuiz2.text = arrowRandomArray[1]
        arrowQuiz3.text = arrowRandomArray[2]
        
        // ラベルの生成
        for i in 0..<arrowNum {
            let label = UILabel(frame: CGRect(x: 50 + (100 * i), y: 80 , width: 80, height: 100))
            label.font = UIFont.fontAwesome(ofSize: 100, style: .solid)
            label.text = String.fontAwesomeIcon(name: .arrow-up)
            view.addSubview(label)
        }
    }
    
    @IBAction func didClickRemember(_ sender: UIButton) {
        let inputValue = arrowRandomArray
        performSegue(withIdentifier: "toAnswer", sender: inputValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            let nextVC = segue.destination as! AnswerViewController
            nextVC.correctAnswerArray = sender as! [String]
        }
    }


}

