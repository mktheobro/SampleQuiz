//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by 久保政人 on 2021/06/16.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var judgeImageview: UIImageView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLebel = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("選択したのはレベル\(selectLebel)")
        
        csvArray = loadCSV(fileName: "quiz\(selectLebel)")
        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    //ボタンを押したときに呼ばれる
    @IBAction func btnAction(sender: UIButton){
        if sender.tag == Int(quizArray[1]){
            correctCount += 1
            print("正解")
            judgeImageview.image = UIImage(named: "correct")
        }else{
            print("不正解")
            judgeImageview.image = UIImage(named: "incorrect")
        }
        print("スコア:\(correctCount)")
        //0.5秒後に○×を消す処理
        judgeImageview.isHidden = false //２問目以降に○×が非表示になるのを避ける処理
        answerButton1.isEnabled = false //◯×が表示中はボタンを押せなくする処理
        answerButton2.isEnabled = false //◯×が表示中はボタンを押せなくする処理
        answerButton3.isEnabled = false //◯×が表示中はボタンを押せなくする処理
        answerButton4.isEnabled = false //◯×が表示中はボタンを押せなくする処理
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageview.isHidden = true
            self.answerButton1.isEnabled = true //◯×が表示中はボタンを押せなくする処理を打ち消す処理
            self.answerButton2.isEnabled = true //◯×が表示中はボタンを押せなくする処理を打ち消す処理
            self.answerButton3.isEnabled = true //◯×が表示中はボタンを押せなくする処理を打ち消す処理
            self.answerButton4.isEnabled = true //◯×が表示中はボタンを押せなくする処理を打ち消す処理
            self.nextQuiz() //ダブルクリックを防ぐためにこちらにnextQuizを移動
        }
        
        
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String]{
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvDate = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvDate.replacingOccurrences(of: "\r", with: "\n" )
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        }catch{
            print("エラー")
        }
        return csvArray
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
