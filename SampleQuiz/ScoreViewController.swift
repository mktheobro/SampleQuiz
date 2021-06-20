//
//  ScoreViewController.swift
//  SampleQuiz
//
//  Created by 久保政人 on 2021/06/16.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet var scorelabel: UILabel!
    
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        scorelabel.text = "\(correct)問正解！"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
