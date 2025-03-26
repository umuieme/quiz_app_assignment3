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

    private var questionList: [Question] = [
        Question(
               question: "What is the primary programming language used for iOS development?",
               correctAnswer: "Swift",
               incorrectAnswers: ["Java", "Kotlin", "Python"]
           ),
           Question(
               question: "Which framework is primarily used for building iOS user interfaces?",
               correctAnswer: "UIKit",
               incorrectAnswers: ["SwiftUI", "Jetpack Compose", "React Native"]
           ),
           Question(
               question: "What file format is used for storing iOS app user interface layouts?",
               correctAnswer: ".xib",
               incorrectAnswers: [".xml", ".storyboard", ".json"]
           ),
           Question(
               question: "Which tool is used to manage dependencies in Swift projects?",
               correctAnswer: "CocoaPods",
               incorrectAnswers: ["Gradle", "Maven", "npm"]
           ),
           Question(
               question: "What is the default database used in iOS development?",
               correctAnswer: "Core Data",
               incorrectAnswers: ["SQLite", "Firebase", "Realm"]
           ),
           Question(
               question: "Which iOS design pattern is most commonly used in UIKit-based apps?",
               correctAnswer: "MVC",
               incorrectAnswers: ["MVVM", "MVP", "VIPER"]
           ),
           Question(
               question: "What is the purpose of the AppDelegate in an iOS app?",
               correctAnswer: "Handles application lifecycle events",
               incorrectAnswers: ["Manages UI layouts", "Stores user data", "Handles API requests"]
           ),
           Question(
               question: "Which framework is used to handle network requests in iOS?",
               correctAnswer: "URLSession",
               incorrectAnswers: ["Alamofire", "Retrofit", "Volley"]
           ),
           Question(
               question: "What is the function of Auto Layout in iOS development?",
               correctAnswer: "Defines responsive UI constraints",
               incorrectAnswers: ["Handles animations", "Manages app navigation", "Optimizes app performance"]
           ),
           Question(
               question: "Which tool is used to debug and analyze iOS applications?",
               correctAnswer: "Xcode Instruments",
               incorrectAnswers: ["Android Studio Profiler", "Postman", "GitHub Actions"]
           )
    ]
    
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
