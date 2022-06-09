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
