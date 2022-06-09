//
//  Extensions.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import Foundation

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
