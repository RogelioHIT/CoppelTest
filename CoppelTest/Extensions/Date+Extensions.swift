//
//  Date+Extensions.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

extension Date {
    var appDateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        return dateFormatter.string(from: self)
    }
}
