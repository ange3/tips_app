//
//  SettingsViewController.swift
//  tips
//
//  Created by Angela Sy on 3/15/15.
//  Copyright (c) 2015 Angela Sy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var customTipValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Set up default selected segment
        var defaults = NSUserDefaults.standardUserDefaults()
        var selected_tip_segment = defaults.integerForKey("default_tip_segment")
        tipControl.selectedSegmentIndex = selected_tip_segment
        
        // Set custom tip value in segmented control
        if let custom_tip_val = defaults.objectForKey("custom_tip_value"){
            tipControl.setTitle("\(custom_tip_val as NSString)%", forSegmentAtIndex: 2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackOnTouchUpInside(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func OnValueChangedDefaultTip(sender: UISegmentedControl) {
        var selected_tip_segment = tipControl.selectedSegmentIndex
        // save key in NSUserDefaults
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(selected_tip_segment, forKey: "default_tip_segment")
        defaults.synchronize()
    }

    @IBAction func CustomPercOnEditingChanged(sender: UITextField) {
    }
    

    @IBAction func CustomPercOnEditingDidEnd(sender: UITextField) {
        let custom_tip = sender.text
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(custom_tip, forKey: "custom_tip_value")
        defaults.synchronize()
        println("new custom tip value")
        println(custom_tip)
        // update segmented control labels
        tipControl.setTitle("\(custom_tip as NSString)%", forSegmentAtIndex: 2)
        view.endEditing(true)
    }
    
    
    // Tapping out of custom tip value text field
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
