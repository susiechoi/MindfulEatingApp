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
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMenu", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
