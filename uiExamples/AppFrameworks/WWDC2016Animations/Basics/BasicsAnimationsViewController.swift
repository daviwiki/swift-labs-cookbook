//
//  BasicsAnimationsViewController.swift
//  uiExamples
//
//  Created by David Martinez on 25/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//

import UIKit

class BasicsAnimationsViewController: UIViewController {

    @IBOutlet weak var square: UIView!
    @IBOutlet weak var line: UIView!
    
    @IBAction func reset(_ sender: Any) {
        square.center.x = line.frame.minX
    }
    
    @IBAction func easeIn(_ sender: UIButton) {
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            options: UIViewAnimationOptions.curveEaseIn,
            animations: {
                self.square.center.x = self.line.frame.maxX
            },
            completion: nil)
    }
 
    @IBAction func easeInOut(_ sender: UIButton) {
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            options: UIViewAnimationOptions.curveEaseInOut,
            animations: {
                self.square.center.x = self.line.frame.maxX
        },
            completion: nil)
    }
    
    @IBAction func easeOut(_ sender: UIButton) {
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                self.square.center.x = self.line.frame.maxX
        },
            completion: nil)
    }
    
    @IBAction func spring(_ sender: UIButton) {        
        // usingSpringWithDamping: 
        // Este valor indica la frecuencia de oscilacion
        // al finalizar el rebote. Si es 1, indica que no hay oscilacion. De 0 a 1
        // se marca se incremente la oscilacion, cuando mas cerca de 0, mas fuerte será.
        
        // initialSpringVelocity:
        // Velocidad de arranque de la vista. Un valor de 1 representa a la cantidad
        // de pixels que recorre la vista en un segundo. Por ejemplo si la animacion
        // va a recorrer 200 pixels y quieres una velocidad de arranque de 100px/seg
        // necesitas marcar un valor de:
        //     200 / v_por_seg = 100 -> v_por_seg = 100/200 = 0.5
        // Un valor de 0 representa una velocidad de arranque de 0 px/s
        
        UIView.animate(
            withDuration: 2.0,
            delay: 0.0,
            usingSpringWithDamping: 0.8, /* Oscillation. 1 -> No oscillation, < 1 -> Increase oscillation */
            initialSpringVelocity: 0.0,
            options: UIViewAnimationOptions.curveLinear,
            animations: { 
                self.square.center.x = self.line.frame.maxX
            },
            completion: nil)
    }
    
    
}
