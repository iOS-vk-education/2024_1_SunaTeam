//
//  OnboardingViewController.swift
//  Suna Travel
//
//  Created by Иван Тарасюк on 12.11.2024.
//

import UIKit
import SwiftUI

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if isFirstLaunch {
                    let onboardingView = UIHostingController(rootView: OnboardingContainerView(isFirstLaunch: Binding(
                        get: { isFirstLaunch },
                        set: { newValue in
                            isFirstLaunch = newValue
                            UserDefaults.standard.set(newValue, forKey: "isFirstLaunch")
                        }
                    )))
                    addChild(onboardingView)
                    onboardingView.view.frame = view.bounds
                    view.addSubview(onboardingView.view)
                    onboardingView.didMove(toParent: self)
                }
    }
}
