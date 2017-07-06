//
//  NeutralFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//

import UIKit

class NeutralFoodVC: UIViewController {
    
    @IBOutlet weak var neutralFoodView: UITextView!
    var neutralFoodArray = [String]()
    var neutralFoodToShow = ""
    var neutralFoodDefaults = UserDefaults.standard
    
    // retrieve previously-inputed neutral foods in array form
    // append newest food input to array if not already contained within
    // write out to neutraldFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        neutralFoodArray = neutralFoodDefaults.object(forKey: "savedneutralFoodArray") as? [String] ?? [String]()
        if neutralFoodToShow != ""{
            if !neutralFoodArray.contains(neutralFoodToShow){
                neutralFoodArray.append(neutralFoodToShow)
            }
        }
        for neutralFood in neutralFoodArray {
            neutralFoodView.text.append("-\(neutralFood)")
            if neutralFoodArray.index(of: neutralFood) != neutralFoodArray.count-1 {
                neutralFoodView.text.append("\n")
            }
        }
        neutralFoodDefaults.set(neutralFoodArray, forKey: "savedneutralFoodArray")
    }
    
    @IBAction func doneEditing(_ sender: Any) {
        neutralFoodView.resignFirstResponder()
        neutralFoodArray = neutralFoodView.text.components(separatedBy: "\n-")
        let firstItem = neutralFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        neutralFoodArray[0] = truncFirstItem
        neutralFoodDefaults.set(neutralFoodArray, forKey: "savedneutralFoodArray")
    }
    
    func textViewShouldEndEditing(_ neutralFoodView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMenuFromNeutral", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
