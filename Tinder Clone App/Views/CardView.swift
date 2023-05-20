//
//  CardView.swift
//  Tinder Clone App
//
//  Created by Burak Güzey on 20.05.2023.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let threshold: CGFloat = 90

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
                
                
            } else {
                self.transform = .identity
            }
            
        }) { _ in
            self.transform = .identity
            self.removeFromSuperview()
          //  self.frame = CGRect(x: 0, y: 0, width: (self.superview!.frame.width), height: self.superview!.frame.height)
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 15
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
