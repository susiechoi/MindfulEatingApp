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
    
    // retrieve previously-inputed good foods in array form
    // append newest food input to array if not already contained within
    // write out to goodFoodView
    // re-write defaults to incorporate newest food input
    override func viewDidLoad() {
        super.viewDidLoad()
        let goodFoodDefaults = UserDefaults.standard
        var goodFoodArray = goodFoodDefaults.object(forKey: "savedGoodFoodArray") as? [String] ?? [String] ()
        if goodFoodToShow != ""{
            if !goodFoodArray.contains(goodFoodToShow){
                goodFoodArray.append(goodFoodToShow)
            }
        }
        for goodFood in goodFoodArray {
            goodFoodView.text.append("-\(goodFood)\n")
        }
        goodFoodDefaults.set(goodFoodArray, forKey: "savedGoodFoodArray")
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
