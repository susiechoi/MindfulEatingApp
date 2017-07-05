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
    
    // retrieve previously-inputed neutral foods in array form
    // append newest food input to array if not already contained within
    // write out to neutraldFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let neutralFoodDefaults = UserDefaults.standard
        var neutralFoodArray = neutralFoodDefaults.object(forKey: "savedNeutralFoodArray") as? [String] ?? [String]()
        if neutralFoodToShow != ""{
            if !neutralFoodArray.contains(neutralFoodToShow){
                neutralFoodArray.append(neutralFoodToShow)
            }
        }
        for neutralFood in neutralFoodArray {
            neutralFoodView.text.append("-\(neutralFood)\n")
        }
        neutralFoodDefaults.set(neutralFoodArray, forKey: "savedNeutralFoodArray")
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
