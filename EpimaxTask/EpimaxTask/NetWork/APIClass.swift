//
//  APIClass.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import UIKit
import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class APIManager {
    static let baseURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    
    static func fetchHighSchools(page: Int) -> AnyPublisher<HighSchoolResponse, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "$limit", value: "10"),
            
            URLQueryItem(name: "$offset", value: "\(page * 10)")
            // Assuming 10 items per page
        ]
        
        print(components.url)
        guard let url = components.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [HighSchool].self, decoder: JSONDecoder())
            .map { schools in
                HighSchoolResponse(schools: schools)
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    static func fetchSATScores(for highSchool: HighSchool) -> AnyPublisher<SATScores?, Error> {
        // Construct the URL for fetching SAT scores
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Construct query parameters
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "dbn", value: highSchool.dbn)
        ]
        
        guard let requestURL = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Create URLRequest
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // Perform the data task
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [SATScores].self, decoder: JSONDecoder())
            .tryMap { satScoresArray -> SATScores? in
                // Assuming the API returns an array of SATScores and we want the first one
                return satScoresArray.first
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//last School for Legal Studies"
//first Clinton School Writers & Artists, M.S. 260",
