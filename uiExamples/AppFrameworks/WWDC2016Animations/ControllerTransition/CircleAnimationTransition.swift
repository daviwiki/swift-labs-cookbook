//
//  CircleAnimationTransition.swift
//  uiExamples
//
//  Created by David Martinez on 22/04/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class CircleAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    private let view: UIView
    private var transitionContext: UIViewControllerContextTransitioning?
    
    init(fromView view: UIView) {
        self.view = view
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toVC.view)
        
        // Calculate initial mask
        let initialMask = UIBezierPath(ovalIn: view.frame)
        
        // Calculate final mask. The final mask will be a circle with center
        // located at the "view" property center and a radius that will be the
        // distance with the farthest extreme vertex of the view controller.
        
        // 1. Calculate the distance with the most farthest vertex of 
        // destination view controller.
        var vertexs = [CGPoint]()
        vertexs.append(CGPoint.zero)
        vertexs.append(CGPoint(x: 0.0, y: toVC.view.frame.height))
        vertexs.append(CGPoint(x: toVC.view.frame.width, y: 0.0))
        vertexs.append(CGPoint(x: toVC.view.frame.width, y: toVC.view.frame.height))
        
        // 2. radius to this vertex:
        let radius = getLongestDistance(from: view.center, to: vertexs)
        
        // 3. calcualte the frame for the destination mask:
        let maskInset = view.frame.insetBy(dx: -radius, dy: -radius)
        
        // 4. define the bezier path for the destination mask:
        let finalMask = UIBezierPath(ovalIn: maskInset)
        
        // Create a CAShapeLayer to represent visually the mask defined before.
        // We include the "maskLayer.path = finalMask.cgPath" to avoid the layer
        // snapping back after the animation has ended
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalMask.cgPath
        toVC.view.layer.mask = maskLayer
        
        // Finally perform the animation and execute it
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = initialMask.cgPath
        maskLayerAnimation.toValue = finalMask.cgPath
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let context = transitionContext else { return }
        
        // It's very important notify that the animation has ended (successfully or cancelled)
        context.completeTransition(!context.transitionWasCancelled)
        
        // Remove the mask that is used to animate the transition
        let toVC = context.viewController(forKey: .to)
        toVC?.view.layer.mask = nil
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
}
