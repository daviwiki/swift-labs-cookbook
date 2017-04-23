//
//  CircleDismissAnimationTransition.swift
//  uiExamples
//
//  Created by David Martinez on 23/04/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class CircleDismissAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    private let view: UIView
    private var transitionContext: UIViewControllerContextTransitioning?
    private var snapshot: UIView!
    
    init(toView view: UIView) {
        self.view = view
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 4.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        // Take a snapshot for the contents of the origin view controller previous to dismiss.
        // This snapshot is the component that will be animated
        guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else { return }
        snapshot.layer.masksToBounds = true
        
        self.snapshot = snapshot
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.isHidden = true
        
        // Calculate initial mask. The initial mask will be a circle with the
        // centar locaed at "view" property center and radius the longest distance
        // between this center and all the destination controller vertexs
        var vertexs = [CGPoint]()
        vertexs.append(CGPoint(x: 0.0, y: 0.0))
        vertexs.append(CGPoint(x: fromVC.view.frame.width, y: 0.0))
        vertexs.append(CGPoint(x: 0.0, y: fromVC.view.frame.height))
        vertexs.append(CGPoint(x: fromVC.view.frame.width, y: fromVC.view.frame.height))
        
        let center = view.center
        let radius = getLongestDistance(from: center, to: vertexs)
        let maskInset = view.frame.insetBy(dx: -radius, dy: -radius)
        let initialMask = UIBezierPath(ovalIn: maskInset)
        
        // calculate destination mask
        let finalMask = UIBezierPath(ovalIn: view.frame)
        
        // Create a CAShapeLayer to represent visually the mask defined before.
        // We include the "maskLayer.path = finalMask.cgPath" to avoid the layer
        // snapping back after the animation has ended
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalMask.cgPath
        snapshot.layer.mask = maskLayer
        
        // Perform the mask animation
        let animationDuration = transitionDuration(using: transitionContext)
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = initialMask.cgPath
        maskLayerAnimation.toValue = finalMask.cgPath
        maskLayerAnimation.duration = animationDuration
        maskLayerAnimation.delegate = self
        
        // Perform an alpha animation for the snapshot
        let ratio = 0.25
        let delta: TimeInterval = animationDuration * ratio
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1.0
        alphaAnimation.toValue = 0.0
        alphaAnimation.duration = delta
        alphaAnimation.beginTime = CACurrentMediaTime() + (animationDuration - delta)
        
        maskLayer.add(maskLayerAnimation, forKey: "path")
        maskLayer.add(alphaAnimation, forKey: "opacity")
    }
    
    private func getLongestDistance(from origin: CGPoint, to vertexs:[CGPoint]) -> CGFloat {
        guard vertexs.count > 0 else { return 0.0 }
        
        var maximum: CGFloat = 0.0
        for vertex in vertexs {
            let d = distance(a: origin, b: vertex)
            if d > maximum {
                maximum = d
            }
        }
        
        return maximum
    }
    
    private func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let context = transitionContext else { return }
        
        context.completeTransition(!context.transitionWasCancelled)
        
        // Remove the snapshot from the container view
        snapshot.removeFromSuperview()
    }
    
}
