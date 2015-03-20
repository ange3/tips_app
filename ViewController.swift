//
//  ViewController.swift
//  tips
//
//  Created by Angela Sy on 3/11/15.
//  Copyright (c) 2015 Angela Sy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel:
        UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var totalLabel: UILabel!
    
//    This is only called once when the view first loads
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(0, forKey: "default_tip_segment")
        defaults.setObject("22", forKey: "custom_tip_value")
    }

//    This function is called every time the view is opened
    override func viewWillAppear(animated: Bool) {
        // set default tip segment
        let defaults = NSUserDefaults.standardUserDefaults()
        var selected_tip_segment = defaults.integerForKey("default_tip_segment")
        tipControl.selectedSegmentIndex = selected_tip_segment
        // set custom tip value
        if let custom_tip_val = defaults.objectForKey("custom_tip_value"){
            tipControl.setTitle("\(custom_tip_val as NSString)%", forSegmentAtIndex: 2)
        }
        onEditingChanged(billField)
    }

    // Update view after bill value has been changed
    @IBAction func onEditingChanged(sender: UITextField) {
        println("User editing bill")
        var tipPercentages = [0.18, 0.2, 0.22]
        // check for custom tip percentage
        let defaults = NSUserDefaults.standardUserDefaults()
        if let custom_tip = defaults.objectForKey("custom_tip_value"){
            var tip_val = NSNumberFormatter().numberFromString(custom_tip as NSString)?.doubleValue
            tipPercentages[2] = tip_val!*0.01
        }
        // calculate values of tip and total
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        if let billAmount = NSNumberFormatter().numberFromString(billField.text)?.doubleValue{
            var tip = billAmount*tipPercentage
            var total = billAmount + tip
            tipLabel.text = "$\(tip)"
            totalLabel.text = "$\(total)"
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
        }
    }
    
    // Update view after chosen tip percentage has been changed
    @IBAction func tipOnValueChanged(sender: UISegmentedControl) {
        onEditingChanged(billField)
    }
    
    // Tap Gesture to exit keyboard
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

