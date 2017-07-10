//
//  ViewController.swift
//  Food Awareness
//
//  Guidance for segue usage from Yp.py, see https://youtu.be/2e5WkFOntEo
//  Guidance for back button creation from Andrew Bancroft, see https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/ 
//  Guidance for saving user defaults from https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults
//  Guidance for "Return" key-triggered keyboard dismissal from Joey Devilla, see: http://www.globalnerdy.com/2015/05/12/how-to-dismiss-the-ios-keyboard-when-the-user-taps-the-return-key-in-swift/
//  Guidance for view/any tap-triggered keyboard dismissal from Todd Perkins, see Lynda course "Learning iOS 10 App Development: 1 Create Your First App"
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodInputField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        foodInputField.delegate = self
    }
    
    // dismiss keyboard if return key tapped
    func textFieldShouldReturn(_ foodInputField: UITextField) -> Bool {
        foodInputField.resignFirstResponder()
        return true
    }
    
    // dismiss keyboard if elsewhere on view tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // segue to respective food type VC so food input may be added to appropriate bad/neutral/good list
    @IBAction func inputBadFood(_ sender: Any) {
        if foodInputField.text == "" {
            untypedAlert()
        }
        else {
            performSegue(withIdentifier: "badFoodSegue", sender: self)
        }
    }
    @IBAction func inputNeutralFood(_ sender: Any) {
        if foodInputField.text == "" {
            untypedAlert()

        }
        else {
            performSegue(withIdentifier: "neutralFoodSegue", sender: self)
        }
    }
    @IBAction func inputGoodFood(_ sender: Any) {
        if foodInputField.text == ""{
            untypedAlert()
        }
        else {
            performSegue(withIdentifier: "goodFoodSegue", sender: self)
        }
    }
    
    @IBAction func viewBadFood(_ sender: Any) {
        performSegue(withIdentifier: "badFoodSegue", sender: self)
    }
    
    @IBAction func viewNeutralFood(_ sender: Any) {
        performSegue(withIdentifier: "neutralFoodSegue", sender: self)
    }
    
    @IBAction func viewGoodFood(_ sender: Any) {
        performSegue(withIdentifier: "goodFoodSegue", sender: self)
    }
    
    // for use in various un-typed entries
    func untypedAlert(){
        let alert = UIAlertController(title: "Oops!", message: "Please input a food first.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it.", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "badFoodSegue" {
            let destination = segue.destination as! BadFoodVC
            destination.badFoodToShow = foodInputField.text!
            foodInputField.text = ""
        }
        else if segue.identifier == "neutralFoodSegue" {
            let destination = segue.destination as! NeutralFoodVC
            destination.neutralFoodToShow = foodInputField.text!
            foodInputField.text = ""
        }
        else {
            let destination = segue.destination as! GoodFoodVC
            destination.goodFoodToShow = foodInputField.text!
            foodInputField.text = ""
        }
    }
    
    // allow segue back to initial VC for further food input
    @IBAction func backToMenu(segue: UIStoryboardSegue){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

