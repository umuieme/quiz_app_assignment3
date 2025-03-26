//
//  ResultViewController.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 20/03/2025.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var markPercentLabel: UILabel!
    
    @IBOutlet weak var correctAnswersCountLabel: UILabel!
    
    @IBOutlet weak var incorrectAnswerCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let (result, correctAnswerCount, incorrectAnswerCount) = QuizManager.shared.getMarkPercentage()
        markPercentLabel.text = "\(result)%"
        correctAnswersCountLabel.text = "\(correctAnswerCount)"
        incorrectAnswerCountLabel.text = "\(incorrectAnswerCount)"
    }
    

    @IBAction func onDonePressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
