//
//  WeatherData.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 7/1/21.
//

import Foundation


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
