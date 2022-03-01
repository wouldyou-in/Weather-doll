//
//  UIView+.swift
//  weather-doll
//
//  Created by 박익범 on 2022/02/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func getDeviceHeight() -> Int{
        return Int(UIScreen.main.bounds.height)
        }
    func getDeviceWidth() -> Int{
        return Int(UIScreen.main.bounds.width)
    }
    
    func getShadowView(color : CGColor, masksToBounds : Bool, shadowOffset : CGSize, shadowRadius : Int, shadowOpacity : Float){
        layer.shadowColor = color
        layer.masksToBounds = masksToBounds
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
    }
    func removeShadowView(){
        layer.shadowOpacity = 0
    }
    
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    func presentAnimation() {
        let height = UIScreen.getDeviceHeight() * 0.73
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.snp.updateConstraints{
                $0.height.equalTo(height)
            }
            self.superview?.layoutIfNeeded()
        }
    }
    func dismissAnimation(view: UIView) {
        let height = UIScreen.getDeviceHeight() * 0.73
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.snp.updateConstraints{
                $0.height.equalTo(0)
            }
            view.isHidden = true
            self.superview?.layoutIfNeeded()
        }
    }
    func changeColor() {
        UIView.animate(withDuration: 0.5){
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.superview?.layoutIfNeeded()
        }
    }
}

