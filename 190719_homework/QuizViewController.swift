//
//  QuizViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/20.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var arrowQuiz1: UILabel!
    @IBOutlet weak var arrowQuiz2: UILabel!
    @IBOutlet weak var arrowQuiz3: UILabel!
    
    let arrowArray:[String] = ["←", "→", "↑", "↓", "・"]
    
    var arrowNum:Int = 0
    
    var arrowRandomArray:[String] = []
    //インスタンスプロパティの初期化式に他のインスタンス変数を使用おすることはできない
    
    // クラスに直接処理を書いてはいけない、関数の中で処理を書く
    // クラスに書いていいのは、プロパティ(変数の宣言)とメソッド(関数の宣言)
    // 処理を書くならメソッドの中に
    
    var len: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(arrowNum)
        
        len = arrowArray.count
        
        // 変数iを使わないのであれば、[_]で代用すれば良い
        for _ in 1...len {
            arrowRandomArray.append(arrowArray[Int(arc4random()) % arrowArray.count])
        }
        
        arrowQuiz1.text = arrowRandomArray[0]
        arrowQuiz2.text = arrowRandomArray[1]
        arrowQuiz3.text = arrowRandomArray[2]
        
        for i in 1...10 {
            let label = UILabel(frame: CGRect(x: 200, y: 200 + (10 * i), width: 200, height: 100))
            label.text = "From pro"
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

