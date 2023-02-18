//
//  RMSettingOptions.swift
//  MortyApp
//
//  Created by KH on 17/02/2023.
//

import UIKit

enum RMSettingOptions: CaseIterable {
  
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReferance
    case viewSeries
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms"
        case .privacy:
            return "Privacy"
        case .apiReferance:
            return "Api Referance"
        case .viewSeries:
            return "View Service"
        case .viewCode:
            return "View Code"
        }
    }
    
    var displayImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReferance:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return UIColor.systemRed
        case .contactUs:
            return UIColor.systemBlue
        case .terms:
            return UIColor.systemGray
        case .privacy:
            return UIColor.systemPink
        case .apiReferance:
            return UIColor.systemBrown
        case .viewSeries:
            return UIColor.systemRed
        case .viewCode:
            return UIColor.systemYellow
        }
    }
}
