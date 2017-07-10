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
    }
    
    // remove just-added "good" food
    // if just viewing, send mistap alert
    @IBAction func undoAdd(_ sender: Any) {
        if goodFoodToShow != "" {
            goodFoodArray.remove(at: goodFoodArray.count-1)
            goodFoodView.text = ""
            for goodFood in goodFoodArray {
                goodFoodView.text.append("-\(goodFood)")
                if goodFoodArray.index(of: goodFood) != goodFoodArray.count-1 {
                    goodFoodView.text.append("\n")
                }
            }
        }
        else {
            mistappedAlert()
        }
    }
    
    // alert if user attempts to "undo add" when no food was added to list
    func mistappedAlert(){
        let alert = UIAlertController(title: "Oops!", message: "No food was added.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Got it.", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // dismiss keyboard if tapped outside text view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // return to initial view
    @IBAction func backButtonTapped(_ sender: Any) {
        doneEditing()
        self.performSegue(withIdentifier: "backToMenuFromGood", sender: self)
    }
    
    func doneEditing() {
        goodFoodView.resignFirstResponder()
        goodFoodArray = goodFoodView.text.components(separatedBy: "\n-")
        let firstItem = goodFoodArray[0]
        let firstTruncIndex = firstItem.index(firstItem.startIndex, offsetBy: 1)
        let truncFirstItem = firstItem.substring(from: firstTruncIndex)
        goodFoodArray[0] = truncFirstItem
        goodFoodDefaults.set(goodFoodArray, forKey: "savedgoodFoodArray")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
