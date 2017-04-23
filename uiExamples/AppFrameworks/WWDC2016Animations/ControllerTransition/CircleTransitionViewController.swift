//
//  CircleTransitionViewController.swift
//  uiExamples
//
//  Created by David Martinez on 22/04/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class CircleTransitionViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installPanGestureRecognizer(inView: button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = button.frame.width / 2.0
    }
    
    private func installPanGestureRecognizer(inView: UIButton) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        // Next live disable the ibaction when gesture is recognized
        gesture.cancelsTouchesInView = true
        inView.addGestureRecognizer(gesture)
    }
    
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let x: CGFloat = sender.view!.center.x + translation.x
        let y: CGFloat = sender.view!.center.y + translation.y
        let center = CGPoint(x: x, y: y)
        
        let viewRadiusX = sender.view!.frame.width / 2.0
        let viewRadiusY = sender.view!.frame.height / 2.0
        guard center.x > viewRadiusX, center.x < view.frame.width - viewRadiusX else {
            return
        }
        guard center.y > viewRadiusY + topLayoutGuide.length, center.y < view.frame.height - viewRadiusY else {
            return
        }
        
        sender.view!.center = center
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }
}

extension CircleTransitionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CircleAnimationTransition(fromView: button)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleDismissAnimationTransition(toView: button)
    }
    
}
