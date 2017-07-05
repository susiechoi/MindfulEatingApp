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
    
    // retrieve previously-inputed bad foods in array form
    // append newest food input to array if not already contained within
    // write out to badFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        let badFoodDefaults = UserDefaults.standard
        var badFoodArray = badFoodDefaults.object(forKey: "savedBadFoodArray") as? [String] ?? [String]()
        if badFoodToShow != ""{
            if !badFoodArray.contains(badFoodToShow){
                badFoodArray.append(badFoodToShow)
            }
        }
        for badFood in badFoodArray {
            badFoodView.text.append("-\(badFood)\n")
        }
        badFoodDefaults.set(badFoodArray, forKey: "savedBadFoodArray")
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
