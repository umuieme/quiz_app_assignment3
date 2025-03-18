//
//  QuizSaveProtocol.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

protocol QuizSavingDelegate {
    func savingDidFinishedWithSuccess(questionList: [Question])
    
    func saveDidCancelled()
    
}

