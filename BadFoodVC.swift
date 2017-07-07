//
//  BadFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//

import UIKit

class BadFoodVC: UIViewController {
    
    @IBOutlet weak var badFoodView: UITextView!
    var badFoodArray = [String]()
    var badFoodToShow = ""
    var badFoodDefaults = UserDefaults.standard
    var goodFoodArray = [String]()
    var randomGoodFood = ""
    
    // retrieve previously-inputed bad foods in array form
    // append newest food input to array if not already contained within
    // write out to badFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        badFoodArray = badFoodDefaults.object(forKey: "savedBadFoodArray") as? [String] ?? [String]()
        if badFoodToShow != ""{
            if !badFoodArray.contains(badFoodToShow){
                badFoodArray.append(badFoodToShow)
            }
        }
        for badFood in badFoodArray {
            badFoodView.text.append("-\(badFood)")
            if badFoodArray.index(of: badFood) != badFoodArray.count-1 {
                badFoodView.text.append("\n")
            }
        }
        badFoodDefaults.set(badFoodArray, forKey: "savedBadFoodArray")
    }

    @IBAction func doneEditing(_ sender: Any) {
        badFoodView.resignFirstResponder()
        badFoodArray = badFoodView.text.components(separatedBy: "\n-")
        let firstItem = badFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        badFoodArray[0] = truncFirstItem
        badFoodDefaults.set(badFoodArray, forKey: "savedBadFoodArray")
    }
    
    func textViewShouldEndEditing(_ badFoodView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func suggestionAlert(){
        goodFoodArray = badFoodDefaults.object(forKey: "savedGoodFoodArray") as? [String] ?? [String]()
        let randomGoodFoodIndex = Int(arc4random_uniform(UInt32(goodFoodArray.count)))
        randomGoodFood = goodFoodArray[randomGoodFoodIndex]
        let suggestion = UIAlertController(title: "Quick tip", message: "We noticed that \(badFoodToShow) made you feel overstuffed and sluggish, but that \(randomGoodFood) made you feel happy & energized. Maybe you can grab some \(randomGoodFood) instead of \(badFoodToShow) next time.", preferredStyle: UIAlertControllerStyle.alert)
        suggestion.addAction(UIAlertAction(title: "Ok, maybe.", style: UIAlertActionStyle.default, handler: { (action) in self.segueBack() }))
        self.present(suggestion, animated: true, completion: nil)
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        if badFoodToShow != "" {
            suggestionAlert()
        }
        else {
            segueBack()
        }
        
    }
    
    func segueBack(){
        self.performSegue(withIdentifier: "backToMenu", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
