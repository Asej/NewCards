//
//  ViewController.swift
//  NewFlash
//
//  Created by Anthony Edwards on 11/10/18.
//  Copyright © 2018 Anthony Edwards. All rights reserved.
//

import UIKit
struct Flashcard{
    var question : String
    var answer : String
}
class ViewController: UIViewController {
   
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontlabel: UIView!
    @IBOutlet weak var FrontLabel: UILabel!
    @IBOutlet weak var BackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var flashcards=[Flashcard]()
    var index = 0;
@IBAction func didTapFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if(self.FrontLabel.isHidden == false){
                self.FrontLabel.isHidden = true;
            }else{
                self.FrontLabel.isHidden = false;
            }        })
       
    }
    
  
    func updateFlashCard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
      //  FrontLabel.text = question
      //  BackLabel.text = answer
        
        print("added a flashcard");
        print("we now have\(flashcards.count) flashcards");
        
        updateNextPrevButtons()
        
        updateLabel()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashCard(question: "What is the capital of Brasil", answer: "Brasília")
            
        }else{
            updateLabel()
            updateNextPrevButtons()
        }
    }
    @IBAction func didTapPrev(_ sender: Any) {
        index = index - 1
        
        updateLabel()
        
        updateNextPrevButtons()
    }
    @IBAction func didTapNext(_ sender: Any) {
        index = index + 1
        
        updateLabel()
        
        updateNextPrevButtons()
        animateCardOut()
    }
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: {finished in
            
            self.updateLabel()
            
            self.animateCardIn()
        })
    }
    func animateCardIn(){
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity})
    }


    
    func saveAllToDisk(){
        let dictionaryArray = flashcards.map { (flashcards) -> [String : String ] in return ["question" : flashcards.question,"answer": flashcards.answer]        };
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    func updateLabel(){
        let currentflashcard = flashcards[index]
        
        FrontLabel.text = currentflashcard.question
        BackLabel.text = currentflashcard.answer
    }
    
    func updateNextPrevButtons(){
        if index == flashcards.count - 1 {
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
  
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary-> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            
            flashcards.append(contentsOf: savedCards)
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if(segue.identifier == "EditSegue"){
            creationController.initialQuestion = BackLabel.text!
            creationController.initialAnswer = FrontLabel.text!
        }
    }
}

