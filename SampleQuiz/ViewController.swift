//
//  ViewController.swift
//  SampleQuiz
//
//  Created by 久保政人 on 2021/06/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
    }


}

