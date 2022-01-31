//
//  UIViewController+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2022 RichAppz Limited (https://richappz.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

public extension UIViewController {
    
    /**
     Presentation of incoming `UIViewController`
     - Parameter vc: UIViewController
     - Parameter presentationStyle: UIModalPresentationStyle
     */
    func presentViewController(_ vc: UIViewController, presentationStyle style: UIModalPresentationStyle, animated: Bool = true) {
        vc.modalPresentationStyle = style
        present(vc, animated: animated, completion: nil)
    }
    
    /**
    Setting of the large title on the `UINavigationController`
    - Parameter largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode
    */
    func setLargeTitleDisplayMode(_ largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode) {
        switch largeTitleDisplayMode {
        case .automatic:
            guard let navigationController = navigationController else { break }
            if let index = navigationController.children.firstIndex(of: self) {
                setLargeTitleDisplayMode(index == 0 ? .always : .never)
            } else {
                setLargeTitleDisplayMode(.always)
            }
        case .always:
            navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
            // Even when .never, needs to be true otherwise animation will be broken on iOS11, 12, 13
            navigationController?.navigationBar.prefersLargeTitles = true
        case .never:
            navigationController?.navigationBar.prefersLargeTitles = false
        @unknown default:
            assertionFailure("\(#function): Missing handler for \(largeTitleDisplayMode)")
        }
    }
    
    func pushViewController(_ vc: UIViewController, _ isAnimated: Bool = true) {
        navigationController?.pushViewController(vc, animated: isAnimated)
    }
    
    /**
    Returns the top most `UIViewController` in the current `UIViewController`
    */
    var topMostViewController: UIViewController? {
        if presentedViewController == nil { return self }
        
        if let navigation = presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController
        }
        
        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController
            }
            return tab.topMostViewController
        }
        return presentedViewController!.topMostViewController
    }
    
}

public extension UIApplication {
    
    /**
    Returns the top most `UIViewController` in the `UIApplication`
    */
    var topMostViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            // This is new to iOS13.0 😩 https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            return keyWindow?.rootViewController?.topMostViewController
        } else {
            return keyWindow?.rootViewController?.topMostViewController
        }
    }
    
    var topMostNavigationController: UINavigationController? {
        if let controller = topMostViewController as? UINavigationController {
            return controller
        } else {
            return topMostViewController?.navigationController
        }
    }
    
}
