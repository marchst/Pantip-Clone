//
//  Extensions.swift
//  Pantip-Clone
//
//  Created by Surapunya Thongdee on 12/11/2564 BE.
//

import SwiftUI
import UIKit
import Kingfisher

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        let array = self.viewControllers
        for controller in array! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -16, right: 0)
//            controller.tabBarController?.tabBar.backgroundColor = UIColor()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor(named: "tabbar")
            UITabBar.appearance().standardAppearance = tabBarAppearance

//            navigationItem.backBarButtonItem = UIBarButtonItem(
//                title: "",
//                style: .plain,
//                target: self,
//                action: #selector(popToPrevious)
//            )

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//                navigationItem.backBarButtonItem = UIBarButtonItem(
//                    title: "",
//                    style: .plain,
//                    target: self,
//                    action: #selector(popToPrevious)
//                )
            }
        }
    }
    
//    @objc private func popToPrevious() {
//        // our custom stuff
//        navigationController?.popViewController(animated: true)
//    }
    
}

extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
    func tabBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    
    func hiddenNavigationBarStyle() -> some View {
        self.modifier( HiddenNavigationBar() )
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

}

extension Image {
    func resizeTo(width: CGFloat, height: CGFloat) -> some View {
        self.resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}

extension KFImage {
    func resizeTo(width: CGFloat, height: CGFloat) -> some View {
        self.resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}

extension UIApplication {
    func endEditting() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

