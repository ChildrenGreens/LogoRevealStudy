//
//  ViewController.swift
//  LogoRevealStudy
//
//  Created by caiqiujun on 16/3/11.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let logo = SwiftLogoLayer.logoLayer()
    let transition = RevealAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Start"
        navigationController?.delegate = self
        //添加手势识别器
        let tap = UITapGestureRecognizer(target: self, action: "didTap")
        view.addGestureRecognizer(tap)
        
        
        logo.position = CGPoint(x: view.layer.bounds.size.width / 2, y: view.layer.bounds.size.height / 2)
        logo.fillColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(logo)
        
        
    }
    
    func didTap() {
        performSegueWithIdentifier("details", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.operation = operation
        
        return transition
        
    }
}

