//
//  ViewController.swift
//  JuliansInteractiveStory
//
//  Created by Julian Khatibi on 6/15/16.
//  Copyright © 2016 Julian Khatibi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let story = Page(story: .TouchDown)
        story.firstChoice = (title: "some title", page: Page(story: .Droid))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" {
            if let PageController = segue.destinationViewController as? PageController {
                PageController.page = Adventure.story
            }
        }
    }


}

