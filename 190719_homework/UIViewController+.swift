//
//  UIViewController+.swift
//  190719_homework
//
//  Created by 辻真緒 on 2019/08/16.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // ボタンのデザインを作成
    func makeButtonDesign(button: UIButton!) {
        button.backgroundColor = .lightGray
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)  // 4
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
    }
    
    // セルのラベル作成（一つずつ作成）
    func makeLabel(arrowNum: Int, heightLabelRate: Double) -> [Any]  {
        
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
        let y = Double(screenHeight) * heightLabelRate
        let d = cellWidth + constInterval * cellWidth
        
        var labelArray:[Any] = []
        
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
        
        return labelArray
    }
    
    
    // ラベルの中身生成
    func makeLabelContent(label: UILabel!, cellWidth: Double, arrowId: Int, arrowArray: [String]) {
        label.font = UIFont.fontAwesome(ofSize: CGFloat(cellWidth), style: .solid)
        label.text = arrowArray[arrowId]  // FontAwesomeで出力
        label.textAlignment = NSTextAlignment.center    // 中央寄せ
    }

}
