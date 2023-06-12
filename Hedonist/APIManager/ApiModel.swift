//
//  ApiModel.swift
//  Hedonist
//
//  Created by a.lobanov on 1/2/23.
//

import Foundation

struct Record: Codable {
    let record: [Landmark]
}

struct Landmark: Codable {
    let category: String?
    let name: String?
    let address: String?
    let lat: Double?
    let long: Double?
    let descript: String?
    let phone: String?
    let workhours: String?
    let image: String?
}
