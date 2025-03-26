//
//  QuizPlayViewController.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 19/03/2025.
//

import UIKit

class QuizPlayViewController: UIViewController {

    var quizList: [Question] = []
    var currentIndex = 0

    @IBOutlet weak var quizzProgressView: UIProgressView!

    @IBOutlet weak var quizProgressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var firstOptionLabel: UIButton!

    @IBOutlet weak var secondOptionLabel: UIButton!

    @IBOutlet weak var thirdOptionLabel: UIButton!
    @IBOutlet weak var fourthOptionLabel: UIButton!

    @IBOutlet weak var previousButton: UIButton!

    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        QuizManager.shared.startQuiz()
        quizList = QuizManager.shared.getQuestionList().shuffled()
        currentIndex = 0
        setQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func onBackPressed(_ sender: Any) {
        showConfirmationDialog(title: "Are you sure you want to exit?", message: "All your progress will be lost") { confirm in
            if confirm {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setQuestion() {
        quizProgressLabel.text = "\(currentIndex + 1) of \(quizList.count)"
        quizzProgressView.setProgress(
            Float(currentIndex + 1) / Float(quizList.count), animated: true)
        let currentQuiz = quizList[currentIndex]
        questionLabel.text = currentQuiz.question

        firstOptionLabel.setTitle(currentQuiz.incorrectAnswers[0], for: .normal)

        secondOptionLabel.setTitle(
            currentQuiz.incorrectAnswers[1], for: .normal)
        thirdOptionLabel.setTitle(currentQuiz.incorrectAnswers[2], for: .normal)
        fourthOptionLabel.setTitle(currentQuiz.correctAnswer, for: .normal)
        updateOptionSelection()

        if currentIndex < quizList.count - 1 {
            nextButton.setTitle("Next >>", for: .normal)
        } else {
            nextButton.setTitle("Submit", for: .normal)
        }
        
        nextButton.isEnabled = QuizManager.shared.getUserAnswerFor(question: currentQuiz) != nil

        previousButton.isEnabled = currentIndex > 0

    }

    @IBAction func onAnswerSelected(_ sender: UIButton) {

        let currentQuiz = quizList[currentIndex]
        if let userAnswer = sender.currentTitle {
            QuizManager.shared.answerQuiz(
                question: currentQuiz, selectedOption: userAnswer)
            updateOptionSelection()
        }
        nextButton.isEnabled = true
    }

    @IBAction func onPreviousPressed(_ sender: Any) {
        if currentIndex == 0 {
            return
        }

        currentIndex = currentIndex - 1
        setQuestion()
    }

    @IBAction func onNextPressed(_ sender: Any) {
        if currentIndex == quizList.count - 1 {
            showConfirmationDialog(title: "Submit quiz?", message: "After this you won't be able to make changes to your answer") { confirm in
                if confirm {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "ResultViewController")
                    self.navigationController?.pushViewController(secondVC, animated: true);
                }
            }
            
            return
        }
        
        
        currentIndex = currentIndex + 1
        setQuestion()
    }

    func updateOptionSelection() {
        let currentQuiz = quizList[currentIndex]
        let selectedAnswer = QuizManager.shared.getUserAnswerFor(question: currentQuiz)
        setButtonStyle(
            button: firstOptionLabel,
            isSelected: selectedAnswer == firstOptionLabel.currentTitle)
        setButtonStyle(
            button: secondOptionLabel,
            isSelected: selectedAnswer == secondOptionLabel.currentTitle)
        setButtonStyle(
            button: thirdOptionLabel,
            isSelected: selectedAnswer == thirdOptionLabel.currentTitle)
        setButtonStyle(
            button: fourthOptionLabel,
            isSelected: selectedAnswer == fourthOptionLabel.currentTitle)

    }

    func setButtonStyle(button: UIButton, isSelected: Bool) {
        if isSelected {
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.systemBlue
            button.layer.borderWidth = 0
        } else {
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = UIColor.white
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.layer.borderWidth = 2
        }
    }

}
