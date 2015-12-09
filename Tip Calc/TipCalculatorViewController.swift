//
//  TipCalculatorViewController.swift
//  Tip Calc
//
//  Created by Vadim Goncharov on 12/8/15.
//  Copyright © 2015 Vadim Goncharov. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet
    
    @IBOutlet weak var amountBeforeTaxTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    
    // Totals
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipsAmount: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    
    @IBOutlet weak var amountPerPerson: UILabel!
    @IBOutlet weak var eachPersonPaysLabel: UILabel!
    
    // MARK: - Properties
    
    var tipCalc = TipCalc(amountBeforeTax: 30.00, tipPercentage: 0.2, totalPeople: 1)
    
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update Lable Styles
        tipPercentageSlider.minimumTrackTintColor = UIColorFromRGB(0x8FC0A9)
        tipPercentageLabel.layer.cornerRadius = 5.0
        tipPercentageLabel.layer.masksToBounds = true
        tipPercentageLabel.layer.borderWidth = 2.0
        tipPercentageLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        numberOfPeopleSlider.minimumTrackTintColor = UIColorFromRGB(0x8FC0A9)
        numberOfPeopleLabel.layer.cornerRadius = 5.0
        numberOfPeopleLabel.layer.masksToBounds = true
        numberOfPeopleLabel.layer.borderWidth = 2.0
        numberOfPeopleLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        totalAmount.text = String(format: "$%0.2f", arguments: [tipCalc.amountBeforeTax])
        amountBeforeTaxTextField.text = String(format: "$%0.2f", arguments: [tipCalc.amountBeforeTax])
        tipPercentageLabel.text = String(format: "%d%%", arguments: [Int(tipCalc.tipPercentage * 100)])
        tipsAmount.text = String(format: "$%0.2f", arguments: [tipCalc.tipPercentage * 100])

        

    }

    
    func calcTip() {
        tipCalc.tipPercentage = Float(tipPercentageSlider.value)
        
        let cleanAmount = amountBeforeTaxTextField.text!.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        tipCalc.amountBeforeTax = ((cleanAmount) as NSString).floatValue
        
        tipCalc.totalPeople = Int(numberOfPeopleSlider.value)
        
        
        tipCalc.calculateTip()
        updateUI()
    }
    

    
    func updateUI() {
        grandTotal.text = String(format: "$%0.2f", arguments: [tipCalc.totalAmount])
        tipsAmount.text = String(format: "$%0.2f", arguments: [tipCalc.tipAmount])
        amountPerPerson.text = String(format: "$%0.2f", arguments: [tipCalc.totalAmountPerPerson])
    }
    
    // MARK: - UIControl Events
    
    @IBAction func amountBeforeTaxTextFieldChanged(sender: AnyObject) {
        calcTip()
        totalAmount.text = "\(amountBeforeTaxTextField.text!)"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == amountBeforeTaxTextField {
            textField.resignFirstResponder()
            calcTip()
        }
        return true
    }
    
    
    @IBAction func tipPercentageSliderValueChagned(sender: AnyObject) {
        tipPercentageLabel.text! = String(format: "%02d%%", arguments: [Int(tipPercentageSlider.value * 100)])
        calcTip()
    }
    
    
    @IBAction func numberOfPeopleSliderValueChanged(sender: AnyObject) {
        numberOfPeopleLabel.text! = String(format: "%2d", arguments: [Int(numberOfPeopleSlider.value)])
        if numberOfPeopleSlider.value > 1 {

            UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.amountPerPerson.alpha = 1.0
            }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.eachPersonPaysLabel.alpha = 1.0
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.amountPerPerson.alpha = 0.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.eachPersonPaysLabel.alpha = 0.0
                }, completion: nil)
        }
        calcTip()
    }
    
    
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    
}
