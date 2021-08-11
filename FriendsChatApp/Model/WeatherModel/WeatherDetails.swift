//
//  WeatherDetails.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 7/1/21.
//

import Foundation

struct WeatherDetails {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
}
