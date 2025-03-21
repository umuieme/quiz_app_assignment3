//
//  QuestionsTableViewController.swift
//  QuizApp-Assignment3
//
//  Created by Umesh Basnet on 18/03/2025.
//

import UIKit

class QuestionsTableViewController: UITableViewController, QuizSavingDelegate {

   
    
    var questionList : [Question] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuizManager.shared.quizDelegate = self
        questionList = QuizManager.shared.getQuestionList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questionList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuizTableViewCell

        cell.questionLabel?.text = questionList[indexPath.row].question
        cell.correctAnswerLabel?.text = questionList[indexPath.row].correctAnswer
        cell.incorrectAnswerLabel?.text = questionList[indexPath.row].incorrectAnswers[0]
        cell.incorrectAnswerLabel2?.text = questionList[indexPath.row].incorrectAnswers[1]
        cell.incorrectAnswerLabel3?.text = questionList[indexPath.row].incorrectAnswers[2]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 193
    }
    
    func savingDidFinishedWithSuccess(questionList: [Question]) {
        self.questionList = questionList
        tableView.reloadData()
    }
    
    func saveDidCancelled() {
            
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionBuilderController = segue.destination as? QuestionBuilderViewController {
            if let selectedRow = tableView.indexPathForSelectedRow {
                questionBuilderController.quiz = questionList[selectedRow.row]
            }
        }
    }
    

}
