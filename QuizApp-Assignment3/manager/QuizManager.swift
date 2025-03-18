//
//  QuizManager.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

class QuizManager {
    
    static let shared = QuizManager()
    
    var quizDelegate : QuizSavingDelegate?

    var questionList: [Question] = []

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

}
