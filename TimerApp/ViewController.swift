//
//  ViewController.swift
//  TimerApp
//
//  Created by Hikaru Ikuta on 2017/01/01.
//  Copyright © 2017年 Hikaru Ikuta. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    var bell: AVAudioPlayer = AVAudioPlayer()
    
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        if flag == true {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
            flag = false
            
        }
        
        
    }
    @IBOutlet weak var patioPic: UIImageView!
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        timer.invalidate()
        
        time = 180
        
        flag = true
        
        timerLabel.text = "3:00"
        
        patioPic.transform = CGAffineTransform(scaleX: CGFloat(1), y: CGFloat(1))
        
    }
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        flag = true
    }
    
    //時間を300秒とする
    var time = 180
    //イメージを関数化しておく
    let patio = UIImage(named: "ホリエモン通常.png")
    let patio2 = UIImage(named: "ホリエモンお怒り.png")
    //
    var timer = Timer()
    //
    var flag = true
    
    
    //タイマーに関する関数
    func decreaseTimer(){
        //１秒ごと減っていく
        time -= 1
        //分と秒に分ける。timeを60で割り分にする
        let min = time/60
        //timeを60で割った時の余りで表示
        let sec = NSString(format: "%02d", time % 60)
        //ラベルに表示
        timerLabel.text = "\(min):\(sec)"
        
        //写真を表示
        patioPic.image = patio
        
        //5秒間に１スケールごと減っていく
        let rate = Double(time) / 180
        
        patioPic.transform = CGAffineTransform(scaleX: CGFloat(rate), y: CGFloat(rate))
        
        
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "sei_ge_bell01", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            bell = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
        }
        
        
        if time == 120 {
            bell.play()
        }
        
        
        if time <= 60
        {
            patioPic.image = patio2
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
