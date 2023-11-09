//
//  UIApplication.swift
//  Pokedex
//
//  Created by Suguru Tokuda on 11/8/23.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
    func setUpTabBarAppearance() {
        @AppStorage("tabBarColor") var tabBarColor: Color = .orange
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(tabBarColor)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    func setUpTAbleViewAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
}
