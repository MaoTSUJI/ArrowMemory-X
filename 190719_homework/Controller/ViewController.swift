//
//  ViewController.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/07/19.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var difficultButton: UIButton!
    
    @IBOutlet weak var easyLevelLabel: UILabel!
    @IBOutlet weak var normalLevelLabel: UILabel!
    @IBOutlet weak var difficultLevelLabel: UILabel!
    
    let levelArray = ["easy": 3,"normal": 5,"difficult": 7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 各ボタンのデザインを設定
        makeButtonDesign(button: easyButton)
        makeButtonDesign(button: normalButton)
        makeButtonDesign(button: difficultButton)
        
        // スプラッシュアニメーション
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "splashImage")!,iconInitialSize: CGSize(width: 250, height: 250), backgroundColor: .white)
        
        revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
        revealingSplashView.delay = 1.0
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
        }
        
        // レベルに合わせて星のアイコンを表示
        let star = String.fontAwesomeIcon(name: .star)
        let styleSolid = UIFont.fontAwesome(ofSize: CGFloat(10), style: .solid)
        let styleRegular = UIFont.fontAwesome(ofSize: CGFloat(10), style: .regular)

        easyLevelLabel.font = styleSolid
        easyLevelLabel.text = star
        
        
    }
    
    // レベルを選択し、次の画面へ遷移するボタン
    @IBAction func didClickEasy(_ sender: UIButton) {
        goToQuiz(level: "easy")
    }
    
    @IBAction func didClickNormal(_ sender: UIButton) {
        goToQuiz(level: "normal")
    }
    
    @IBAction func didClickDifficult(_ sender: UIButton) {
        goToQuiz(level: "difficult")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuiz" {
            let nextVC = segue.destination as! QuizViewController
            nextVC.arrowNum = sender as! Int
        }
    }

    // 選択したレベル情報の値を渡す　//次の画面に遷移
    func goToQuiz(level: String){
        let inputValue = levelArray[level]
        performSegue(withIdentifier: "toQuiz", sender: inputValue)
    }

}

