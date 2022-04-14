//
//  Course.swift
//  LessonNetworkRequests
//
//  Created by Ян Таше on 13.04.2022.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct Courses: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
