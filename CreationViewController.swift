//
//  CreationViewController.swift
//  NewFlash
//
//  Created by Anthony Edwards on 11/12/18.
//  Copyright © 2018 Anthony Edwards. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }

    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextField!
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    var initialQuestion: String?
    var initialAnswer: String?
    @IBAction func didTapOnDOne(_ sender: Any) {
        let questionText = questionTextField.text;
        let answerText = answerTextField.text;
        dismiss(animated: true);
        flashcardsController.updateFlashCard(question: questionText!,answer: answerText!);
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
