//
//  LetterViewController.swift
//  CK_Decolando para as Nuvens
//
//  Created by Rebeca Pacheco on 26/11/20.
//

import UIKit

class LetterViewController: UIViewController {
    @IBOutlet weak var letterText: UITextView!
    
    @IBOutlet weak var signature: UITextField!
    
    @IBOutlet weak var ButtonLetter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signature.layer.borderColor = UIColor(red: 0.76, green: 0.27, blue: 0.25, alpha: 1.00).cgColor
        signature.layer.borderWidth = 1
        signature.layer.cornerRadius = 5
        letterText.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @IBAction func onTouchSend(_ sender: Any) {
        let letter = Letter(name: signature.text!, content: letterText.text!)
        
        letter.createRecord(){
            error in
            if error != nil{
                print("Error in CloudKit:", error as Any)
            }else{
                DispatchQueue.main.async {
                    self.clear()
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func clear(){
        letterText.text = "Eu fui uma boa criança esse ano e gostaria de ganhar:"
        signature.text = ""
    }
}
