//
//  RevealAnimator.swift
//  LogoRevealStudy
//
//  Created by caiqiujun on 16/3/11.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

import UIKit

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 2.0
    
    weak var storedContext: UIViewControllerContextTransitioning?
    
    var operation = UINavigationControllerOperation.Push
    
    
    /**
     *  动画持续时间
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 保存跳转上下文
        storedContext = transitionContext
        
        
        // 如果跳转方向是MasterVC--->DetailVC
        if operation == .Push {
            // 从跳转上下文中选出开始控制器和结束控制器
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
            
            
            // 将跳转目的视图控制器的主视图添加到跳转上下文的容器视图中
            transitionContext.containerView()?.addSubview(toVc.view)
            
            //配置变形的核心动画,将logo上移一段距离并放大到150倍
            let animation = CABasicAnimation(keyPath: "transform")
            
            animation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
            animation.toValue = NSValue(CATransform3D:
                CATransform3DConcat(
                CATransform3DMakeTranslation(0.0, -10.0, 0.0),
                CATransform3DMakeScale(150.0, 150.0, 1.0)
                )
            )
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
            //同时给遮罩和logo添加变形动画
            
            toVc.maskLayer.addAnimation(animation, forKey: nil)
            fromVc.logo.addAnimation(animation, forKey: nil)
            
            //配置逐渐显现的核心动画
            let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
            fadeInAnimation.duration = animationDuration
            fadeInAnimation.fromValue = 0.0
            fadeInAnimation.toValue = 1.0
            
            //给目的视图控制器的视图添加fade-in动画
            toVc.view.layer.addAnimation(fadeInAnimation, forKey: nil)

        }
        // 如果跳转方向是返回
        else {
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            transitionContext.containerView()?.insertSubview(toView!, belowSubview: fromView!)
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                fromView!.transform = CGAffineTransformMakeScale(0.1, 0.1)
                fromView!.alpha = 0.0
                }, completion: { (finish) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        
        
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            context.completeTransition(!context.transitionWasCancelled())
            //重置logo
            let fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
            fromVC.logo.removeAllAnimations()
        }
        storedContext = nil
    }
}
