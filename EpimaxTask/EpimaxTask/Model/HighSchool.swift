//
//  HighSchool.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import Foundation

struct HighSchool: Codable {
    let dbn: String
    let school_name: String
  
}

struct HighSchoolResponse: Codable {
    let schools: [HighSchool]
   
}

struct SATScores: Codable {
    let dbn: String
    let sat_math_avg_score: String
    let sat_critical_reading_avg_score: String
    let sat_writing_avg_score: String
}
