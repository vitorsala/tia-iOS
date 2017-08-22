//
//  AbsenceRouter.swift
//  MackTIA
//
//  Created by Aleph Retamal on 4/15/16.
//  Copyright (c) 2016 Mackenzie. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol AbsenceRouterInput
{
  func navigateToSomewhere()
}

class AbsenceRouter: AbsenceRouterInput
{
  weak var viewController: AbsenceViewController!
  
  // MARK: Navigation
  
  func navigateToSomewhere()
  {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:
    
    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)
    
    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)
    
    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    
    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }
  
  // MARK: Communication
  
  func passDataToNextScene(_ segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router which scenes it can communicate with
    
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue)
    }
  }
  
  func passDataToSomewhereScene(_ segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router how to pass data to the next scene
    
    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.output.name = viewController.output.name
  }
}
