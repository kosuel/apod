//
//  Extensions.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import Foundation
import UIKit

enum ApiKeys{
    static let nasaApiKey = "LggVWOT1UkH4vIQkIne5dHB1jHqmhVcTh32EqpzQ"
}

extension UIColor {
    static var cellColors: [UIColor] {
        [
            UIColor(rgb: 0x1a237e),
            UIColor(rgb: 0x283593),
            UIColor(rgb: 0x303f9f),
            UIColor(rgb: 0x3949ab),
            UIColor(rgb: 0x3f51b5),
            UIColor(rgb: 0x5c6bc0)
        ]
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension Date{
    func addDays(_ days:Int) -> Date{        
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func isSameDate(to date:Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    var start: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

extension UIButton{
    
    func fill(background:UIColor, text:UIColor, border:UIColor?=nil, isRoundCorner:Bool=true){
    
        self.backgroundColor = background;
        self.tintColor = text;
        
        if let border = border {
            self.layer.borderColor = border.cgColor;
            self.layer.borderWidth = 1;
        }
        else{
            self.layer.borderColor = UIColor.clear.cgColor;
            self.layer.borderWidth = 0;
        }
        
        if isRoundCorner {
            self.layer.cornerRadius = 5;
        }
        else{
            self.layer.cornerRadius = 0;
        }
    }
}

extension UIViewController {
    func presentAlert(title:String?, message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        
        present(alert, animated: true)
    }
}
