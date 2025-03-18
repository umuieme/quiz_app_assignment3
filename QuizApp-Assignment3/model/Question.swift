//
//  Quiz.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

import Foundation

class Question {
    let uuid : UUID
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    init(uuid: UUID = UUID(), question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
        self.uuid = uuid
    }
}
