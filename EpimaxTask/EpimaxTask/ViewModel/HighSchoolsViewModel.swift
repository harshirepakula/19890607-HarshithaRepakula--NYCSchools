//
//  HighSchoolsViewModel.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import Foundation
import Combine
import UIKit


class HighSchoolsViewModel: ObservableObject {
    
    @Published var highSchools: [HighSchool] = []
    private var currentPage = 0
    private var isLoadingData = false
    private var cancellable: AnyCancellable?
    private var cancellables: Set<AnyCancellable> = []
    

    func fetchHighSchools() {

        guard !isLoadingData else { return }
        isLoadingData = true
        cancellable = APIManager.fetchHighSchools(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoadingData = false
                switch completion {
                case .failure(let error):
                    
                    print("Error fetching high schools: \(error)")
                    break
                case .finished:
                    self.currentPage += 1
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                if response.schools.isEmpty {
                    self.isLoadingData = true
                }else
                {

                self.highSchools.append(contentsOf: response.schools)
                }
            })


    }

    func isFetchingData() -> Bool {
            return isLoadingData
        }
    
    

    
    
    func fetchSATScores(for highSchool: HighSchool, completion: @escaping (SATScores?) -> Void) {
        guard !isLoadingData else { return }
        
        isLoadingData = true
        
        cancellable = APIManager.fetchSATScores(for: highSchool)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoadingData = false
                switch completion {
                case .failure(let error):
                    print("Error fetching SAT scores: \(error)")
                    
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] satScores in
                guard let self = self else { return }
                self.isLoadingData = false
                completion(satScores)
            })
    }
    
    
    
}



