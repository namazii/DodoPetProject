//
//  UIColor+Extension.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 01.12.2022.
//

import UIKit

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 1, green: 0.4546356201, blue: 0.007493569981, alpha: 1)
    }
    static var mainWhite: UIColor {
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    static var tabBarItemLight: UIColor {
        #colorLiteral(red: 0.3315069675, green: 0.3315069675, blue: 0.3315069675, alpha: 0.706151697)
    }
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }
    
    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}
