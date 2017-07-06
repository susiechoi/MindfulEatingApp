//
//  GoodFoodVC.swift
//  Food Awareness
//
//  Created by Susie Choi on 6/28/17.
//  Copyright © 2017 Susie Choi. All rights reserved.
//

import UIKit

class GoodFoodVC: UIViewController {
    
    @IBOutlet weak var goodFoodView: UITextView!
    var goodFoodArray = [String]()
    var goodFoodToShow = ""
    var goodFoodDefaults = UserDefaults.standard
    
    // retrieve previously-inputed good foods in array form
    // append newest food input to array if not already contained within
    // write out to goodFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        goodFoodArray = goodFoodDefaults.object(forKey: "savedgoodFoodArray") as? [String] ?? [String]()
        if goodFoodToShow != ""{
            if !goodFoodArray.contains(goodFoodToShow){
                goodFoodArray.append(goodFoodToShow)
            }
        }
        for goodFood in goodFoodArray {
            goodFoodView.text.append("-\(goodFood)")
            if goodFoodArray.index(of: goodFood) != goodFoodArray.count-1 {
                goodFoodView.text.append("\n")
            }
        }
        goodFoodDefaults.set(goodFoodArray, forKey: "savedgoodFoodArray")
    }
    
    @IBAction func doneEditing(_ sender: Any) {
        goodFoodView.resignFirstResponder()
        goodFoodArray = goodFoodView.text.components(separatedBy: "\n-")
        let firstItem = goodFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        goodFoodArray[0] = truncFirstItem
        goodFoodDefaults.set(goodFoodArray, forKey: "savedgoodFoodArray")
    }
    
    func textViewShouldEndEditing(_ goodFoodView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backToMenuFromGood", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
