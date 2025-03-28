//
//  QuizManager.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

import Foundation

class QuizManager {
    
    static let shared = QuizManager()
    
    var quizDelegate : QuizSavingDelegate?
    private var userAnswers: [UUID: String] = [:]

    private var questionList: [Question] = []
    
    func startQuiz() {
        userAnswers = [:]
    }

    func addQuiz(question: Question) {
        questionList.append(question)
        quizDelegate?.savingDidFinishedWithSuccess(questionList: questionList)
    }
    
    func updateQuiz(question: Question) {
        let index = questionList.firstIndex { q in
            return q.uuid == question.uuid
        }
        if let index = index {
            questionList[index] = question
            quizDelegate?.savingDidFinishedWithSuccess(questionList: questionList)
        }
    }
    
    func getQuestionList() -> [Question]{
        return questionList;
    }
    
    func answerQuiz( question: Question, selectedOption: String){
        userAnswers[question.uuid] = selectedOption
    }
    
    func getUserAnswerFor(question: Question) -> String? {
        return userAnswers[question.uuid];
    }
    
    func getMarkPercentage() -> (marks: Int, correctAnswerCount: Int, incorrectAnswerCount: Int) {
        var correctAnswersCount = 0
        var incorrectAnswerCount = 0
        questionList.forEach { question in
            if(userAnswers[question.uuid] == question.correctAnswer){
                correctAnswersCount = correctAnswersCount + 1
            } else {
                incorrectAnswerCount = incorrectAnswerCount + 1
            }
        }
        let marksObtained = Int((Float(correctAnswersCount)/Float(questionList.count)) * 100)
        return (marksObtained, correctAnswersCount, incorrectAnswerCount)
    }

}
