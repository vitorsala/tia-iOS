//
//  AbsenceConfigurator.swift
//  MackTIA
//
//  Created by Aleph Retamal on 4/15/16.
//  Copyright (c) 2016 Mackenzie. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension AbsenceViewController: AbsencePresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }
}

extension AbsenceInteractor: AbsenceViewControllerOutput {
}

extension AbsencePresenter: AbsenceInteractorOutput {
}

class AbsenceConfigurator {
//    private static var __once: () = {
//            Static.instance = AbsenceConfigurator()
//        }()
//    // MARK: Object lifecycle
//    
//    class var sharedInstance: AbsenceConfigurator
//    {
//        struct Static {
//            static var instance: AbsenceConfigurator?
//            static var token: Int = 0
//        }
//        
//        _ = AbsenceConfigurator.__once
//        
//        return Static.instance!
//    }
    
    class var sharedInstance: AbsenceConfigurator {
        struct Static {
            static var instance: AbsenceConfigurator?
            static var doOnce: () {
                Static.instance = AbsenceConfigurator()
            }
        }
        Static.doOnce
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(_ viewController: AbsenceViewController)
    {
        let router = AbsenceRouter()
        router.viewController = viewController
        
        let presenter = AbsencePresenter()
        presenter.output = viewController
        
        let interactor = AbsenceInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
