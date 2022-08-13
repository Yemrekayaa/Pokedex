//
//  Extensions.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import Foundation
import UIKit

class Extensions{
    static func getID(with url: String) -> Int?{
        return Int(url.components(separatedBy: "/")[6])
    }
}


extension UIColor{
    
    
    static func rgbConvert(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat = 1) -> UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    struct MyTheme {
        static var primaryColor: UIColor {UIColor.systemMint}
        static var secondaryColor: UIColor {UIColor.rgbConvert(80, 150, 255)}
        static var primaryBorderColor: UIColor {UIColor.black}
    }
    
    struct TypeColor {
        static var color: [String:UIColor] =
        ["bug":UIColor.systemGreen,
         "dark": UIColor.systemBrown,
         "dragon": UIColor.purple,
         "electric": UIColor.systemYellow,
         "fairy": UIColor.systemPink,
         "fighting": UIColor.systemRed,
         "fire": UIColor.rgbConvert(238, 129, 48),
         "flying": UIColor.systemPurple,
         "ghost": UIColor.systemPurple,
         "grass": UIColor.systemGreen,
         "ground": UIColor.brown,
         "ice": UIColor.systemBlue,
         "normal": UIColor.rgbConvert(168, 167, 122),
         "poison":  UIColor.purple,
         "psychic":  UIColor.systemPink,
         "rock": UIColor.brown,
         "stell":  UIColor.gray,
         "water": UIColor.blue]
    }
    
}


extension UIView {
    enum ViewSide {
        case left, right, top, bottom
    }
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: thickness, height: self.frame.size.height)
        case .right: border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
        case .top: border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: thickness)
        case .bottom: border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.frame.size.width, height: thickness)
        }
        
        self.layer.addSublayer(border)
    }
    
}


