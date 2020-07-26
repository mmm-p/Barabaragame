//
//  RankingViewController.swift
//  barabara2
//
//  Created by 柳川万結 on 2018/11/04.
//  Copyright © 2018年 柳川万結. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLabel1:  UILabel!
    @IBOutlet var rankingLabel2:  UILabel!
    @IBOutlet var rankingLabel3:  UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //"score1"というキーの値を取得して表示
        rankingLabel1.text = String(defaults.integer(forKey: "score1"))
        //"score2"というキーの値を取得して表示
        rankingLabel2.text = String(defaults.integer(forKey: "score2"))
        //"score3"というキーの値を取得して表示
        rankingLabel3.text = String(defaults.integer(forKey: "score3"))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
