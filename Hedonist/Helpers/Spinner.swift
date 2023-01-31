//
//  Spinner.swift
//  Hedonist
//
//  Created by a.lobanov on 1/31/23.
//

import UIKit

final class Spinner: UIView {
    var innerFillColor: UIColor  = .clear
    var innerStrokeColor: UIColor = .red
    var innerLineWidth: CGFloat = 2.0
    var innerEndStroke: CGFloat = 0.75
    var innerAnimationDuration: CGFloat = 1.6
    
    var innerView: UIView = UIView()
    var currentInnerRotation: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        innerStrokeColor = .gray
        innerStrokeColor = .white
        
        addSubview(innerView)
        innerView.frame = CGRect(x: 0, y: 0, width: rect.size.width - 20, height: rect.size.height - 20)
        innerView.center = self.convert(self.center, from: self.superview!)
        
        let innerLayer = CAShapeLayer()
        innerLayer.path = UIBezierPath(ovalIn: innerView.bounds).cgPath
        innerLayer.lineWidth = innerLineWidth
        innerLayer.strokeStart = 0
        innerLayer.strokeEnd = innerEndStroke
        innerLayer.lineCap = .round
        innerLayer.fillColor = innerFillColor.cgColor
        innerLayer.strokeColor = innerStrokeColor.cgColor
        
        innerView.layer.addSublayer(innerLayer)
        startAnimating()
    }
    
    private func animateInnerRing(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0 * CGFloat(Double.pi / 180)
        rotationAnimation.toValue = 360 * CGFloat(Double.pi / 180)
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        innerView.layer.add(rotationAnimation, forKey: "rotateInner")
    }
    
    func startAnimating(){
        isHidden = false
        animateInnerRing()
    }
    
    func stopAnimating(){
        isHidden = true
        innerView.layer.removeAllAnimations()
    }
}
