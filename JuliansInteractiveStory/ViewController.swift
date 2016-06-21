//
//  ViewController.swift
//  JuliansInteractiveStory
//
//  Created by Julian Khatibi on 6/15/16.
//  Copyright © 2016 Julian Khatibi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    enum Error: ErrorType {
        case NoName
    }

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keywordWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" {
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw Error.NoName
                    }
                    if let PageController = segue.destinationViewController as? PageController {
                        PageController.page = Adventure.story("Julian")
                    }
                }
            } catch Error.NoName {
                let alertController = UIAlertController(title: "Name Not Provided!", message: "Don't be a lame sauce. Add a name to start your story!", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                alertController.addAction(action)
                presentViewController(alertController, animated: true, completion: nil)
            
            
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    
    func keywordWillShow(notification: NSNotification) {
        if let userInfoDict = notification.userInfo, keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.CGRectValue()
            
            UIView.animateWithDuration(0.8) {
                self.textFieldBottomContraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        UIView.animateWithDuration(0.8){
            self.textFieldBottomContraint.constant = 40.0
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}

