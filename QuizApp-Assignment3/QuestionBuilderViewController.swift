//
//  QuestionBuilderViewController.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

import UIKit

class QuestionBuilderViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var incorrectAnswer1TextField: UITextField!
    @IBOutlet weak var incorrectAnswer2TextField: UITextField!
    @IBOutlet weak var incorrectAnswer3TextField: UITextField!
    
    var quiz : Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(quiz != nil){
            questionTextField.text = quiz?.question
            correctAnswerTextField.text = quiz?.correctAnswer
            incorrectAnswer1TextField.text = quiz?.incorrectAnswers[0]
            incorrectAnswer2TextField.text = quiz?.incorrectAnswers[1]
            incorrectAnswer3TextField.text = quiz?.incorrectAnswers[2]
        }

    }

    @IBAction func onExitPressed(_ sender: Any) {
        showConfirmationDialog(title: "Exit Quiz Builder?", message: "All your data will be lost.") { confirm in
            if(confirm){
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func onSavePressed(_ sender: Any) {

        guard let question = questionTextField.text, !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("question invalid")
            showErrorDialogWith(message: "Question is required", title: "Missing field")
            return
        }

        guard let correctAnswer = correctAnswerTextField.text,
            !correctAnswer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            print("correct answer invalid")
            showErrorDialogWith(message: "Correct answer is required", title: "Missing field")

            return
        }

        guard let incorrectAnswer1 = incorrectAnswer1TextField.text,
            !incorrectAnswer1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            print("1  answer invalid")
            showErrorDialogWith(message: "All three incorrect is required", title: "Missing field")
            return
        }

        guard let incorrectAnswer2 = incorrectAnswer2TextField.text,
            !incorrectAnswer2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            showErrorDialogWith(message: "All three incorrect is required", title: "Missing field")
            print("2  answer invalid")

            return
        }

        guard let incorrectAnswer3 = incorrectAnswer3TextField.text,
            !incorrectAnswer3.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            showErrorDialogWith(message: "All three incorrect is required", title: "Missing field")
            return
        }

        
        
        if(quiz == nil){
            let quiz = Question(question: question, correctAnswer: correctAnswer, incorrectAnswers: [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3])
            QuizManager.shared.addQuiz(question: quiz)
        } else {
            let quiz = Question(uuid: quiz!.uuid, question: question, correctAnswer: correctAnswer, incorrectAnswers: [incorrectAnswer1, incorrectAnswer2, incorrectAnswer3])
            QuizManager.shared.updateQuiz(question: quiz)
        }
//        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }

}
