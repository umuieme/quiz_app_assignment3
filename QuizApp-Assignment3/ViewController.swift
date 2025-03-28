//
//  ViewController.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnStartQuiz: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if(QuizManager.shared.getQuestionList().isEmpty){
            btnStartQuiz.isEnabled = false
            btnStartQuiz.setTitle("Quiz is empty", for: .normal)
        } else {
            btnStartQuiz.isEnabled = true
            btnStartQuiz.setTitle("Start Quiz", for: .normal)

        }
    }


}

