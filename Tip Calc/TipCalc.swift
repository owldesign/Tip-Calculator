//
//  TipCalc.swift
//  Tip Calc
//
//  Created by Vadim Goncharov on 12/8/15.
//  Copyright © 2015 Vadim Goncharov. All rights reserved.
//

import Foundation


class TipCalc {
    
    var tipAmount: Float = 0
    var amountBeforeTax: Float = 0
    var tipPercentage: Float = 0
    var totalAmount: Float = 0
    var totalPeople: Int = 0
    var totalAmountPerPerson: Float = 0
    
    init(amountBeforeTax: Float, tipPercentage: Float, totalPeople: Int) {
        self.amountBeforeTax = amountBeforeTax
        self.tipPercentage = tipPercentage
        self.totalPeople = totalPeople
    }
    
    func calculateTip() {
        tipAmount = amountBeforeTax * tipPercentage
        totalAmount = tipAmount + amountBeforeTax
        totalAmountPerPerson = (tipAmount + amountBeforeTax) / Float(totalPeople)
    }
//    
//    func calculatePayPerPerson() {
//        tipAmount = amountBeforeTax * tipPercentage
//        totalAmount = tipAmount + amountBeforeTax
//        totalAmountPerPerson = (tipAmount + amountBeforeTax) / Float(totalPeople)
//    }
    
}