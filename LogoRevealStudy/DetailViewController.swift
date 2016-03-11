//
//  DetailViewController.swift
//  LogoRevealStudy
//
//  Created by caiqiujun on 16/3/11.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let maskLayer = SwiftLogoLayer.logoLayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        maskLayer.position = CGPoint(x: view.layer.bounds.size.width / 2, y: view.layer.bounds.size.height / 2)
        view.layer.mask = maskLayer
        
        title = "Pack List"
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.layer.mask = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
