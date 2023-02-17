//
//  ModalSheetPresentationController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import Foundation
import UIKit

open class ModalSheetPresentationController : UIPresentationController {
    
    private enum modalPosition {
        case middle, top
    }
    
    private var transparencyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var middlePoint: CGPoint?
    private var topPoint: CGPoint?
    private var currentPosition: modalPosition = .middle
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        self.transparencyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissController)))
        self.presentedViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction)))
        
        registerForNotifications()
    }
    
    deinit {
        unregisterForNotifications()
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        self.middlePoint = CGPoint(x: 0, y: self.containerView!.frame.height * 0.5)
        self.topPoint = CGPoint(x: 0, y: 1)
        
        self.currentPosition = .middle
        
        return CGRect(origin: self.middlePoint!, size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height))
    }
    
    public override func presentationTransitionWillBegin() {
        self.transparencyView.alpha = 0
        self.containerView?.addSubview(transparencyView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.transparencyView.alpha = 0.5
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    public override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.transparencyView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.transparencyView.removeFromSuperview()
        })
    }
    
    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let presentedView = presentedView {
            let path = UIBezierPath(roundedRect: presentedView.bounds, byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 22, height: 22))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            presentedView.layer.mask = mask
        }
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        transparencyView.frame = containerView!.bounds
    }
    
    private func registerForNotifications() {
        self.unregisterForNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func animateToPosition() {
        UIView.animate(withDuration: 0.3) {
            switch self.currentPosition {
            case .middle:
                self.presentedViewController.view.frame.origin = CGPoint(x: 0, y: self.middlePoint?.y ?? 1)
                break
            case .top:
                self.presentedViewController.view.frame.origin = CGPoint(x: 0, y: self.topPoint?.y ?? 1)
                break
            }
        }
    }
    
    @objc private func keyboardWillShow() {
        self.currentPosition = .top
        animateToPosition()
    }
    
    @objc private func keyboardWillHide() {
        self.currentPosition = .middle
        animateToPosition()
    }
    
    @objc private func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.presentedViewController.view)
        
        switch self.currentPosition {
        case .middle:
            self.presentedViewController.view.frame.origin = CGPoint(x: 0, y: self.middlePoint!.y + translation.y)
            break
        case .top:
            self.presentedViewController.view.frame.origin = CGPoint(x: 0, y: self.topPoint!.y + translation.y)
            break
        }
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: self.presentedViewController.view)
            if dragVelocity.y >= 1000 {
                if currentPosition == .top {
                    currentPosition = .middle
                    animateToPosition()
                }
                self.dismissController()
            } else if abs(dragVelocity.y) >= 1000 {
                currentPosition = .top
                animateToPosition()
            } else {
                currentPosition = .middle
                animateToPosition()
            }
        }
    }
}
