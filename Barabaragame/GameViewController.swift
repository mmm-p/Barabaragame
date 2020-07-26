//
//  GameViewController.swift
//  barabara2
//
//  Created by 柳川万結 on 2018/11/04.
//  Copyright © 2018年 柳川万結. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
    
    
    @IBOutlet var imgView1:  UIImageView!//上の画像
    @IBOutlet var imgView2:  UIImageView!//真ん中の画像
    @IBOutlet var imgView3:  UIImageView!//下の画像
    
    @IBOutlet var resultLabel:  UILabel! //スコアを表示するランキング
    
    var timer: Timer! //画像を動かすためのタイマー
    var score: Int = 1000//スコアの値
    let defaults: UserDefaults = UserDefaults.standard //スコアの保存をするための変数
    let width: CGFloat = UIScreen.main.bounds.size.width //画面幅
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0] //画面の位置の配列
    
    var dx: [CGFloat] = [1.0, 0.5, -1.0] //画像の動かす幅の配列
    
    func  start() {
        //結果ラベルを見やすくする
        resultLabel.isHidden = true
        
        //タイマーを動かす
        timer  =  Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up),userInfo: nil, repeats: true)
        timer.fire()
        setAudioPlayer(soundName: "distantfuture", type: "MP3")
        audioPlayer.play()
        
    }
    
    
    
    @objc func up() {
        for i in 0..<3{
            //端に来たら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0{
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i] //画像の位置をdx分ずらす
        }
        imgView1.center.x = positionX[0]//上の画像をずらした位置に移動する
        imgView2.center.x = positionX[1]//真ん中の画像をずらした位置に移動させる
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]//画像の位置を画面幅の中心にする
        self.start()//前ページで書いたstartというメソッドをを呼び起こす
    }
    
    
    
    
    //ストップボタンを押したら
    @IBAction func stop () {
        if timer.isValid == true { //もしタイマーが動いてたら
            timer.invalidate() //タイマーを止める（無効にする）
            audioPlayer.stop()
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i]))*2 //スコアの計算をする
            }
            let highScore1: Int? = defaults.integer(forKey: "score1")//ユーザーデフォルト
            let highScore2: Int? = defaults.integer(forKey: "score2")
            let highScore3: Int? = defaults.integer(forKey: "score3")
            
            if score > highScore1! || highScore1 == nil {//ランキング１位の記録を更新
                defaults.set(score, forKey: "score1")
                defaults.set(highScore1, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
            } else if score > highScore2! || highScore2 == nil {//ランキング２位を更新したら
                
                defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
            } else if score > highScore3!  || highScore3 == nil {//ランキング３位を更新したから
                
                defaults.set(score, forKey: "score3")
            }
            defaults.synchronize()
            
            
            resultLabel.text = "Score: " + String(score)//結果ラベルにスコアを表示する
            resultLabel.isHidden = false //結果ラベルを隠さない（現す)
        }
    }
    
    @IBAction func retry() {
        score = 1000//スコアの値をリセットする
        positionX = [width/2, width/2, width/2]//画像の位置を真ん中に戻す
        if timer.isValid == false {
            self.start() //スタートメソッドを呼び出す
            audioPlayer.play()
        }
       
        
        
    }
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
        audioPlayer.stop()
        
    }
    
    
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAudioPlayer(soundName: String, type: String) {
        
        let soundFilePath = Bundle.main.path(forResource: soundName, ofType: type )!
        let fileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("音楽ファイルが読み込みませんでした")
        }
    }
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
