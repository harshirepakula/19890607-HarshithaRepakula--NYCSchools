//
//  HighSchoolsViewController.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import UIKit
import Combine

class HighSchoolsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var loadingView: UIActivityIndicatorView!
    
    internal var viewModel = HighSchoolsViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatUI()
        
    }
    
    
    func creatUI()
    {
        self.navigationItem.title = "NYC High Schools"
        tableView.tableFooterView = UIView()
        
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 0.3189919591, green: 0.4862425923, blue: 0.01109100971, alpha: 1)
            appearance.titleTextAttributes = [.font:
                                                UIFont.boldSystemFont(ofSize: 20.0),
                                              .foregroundColor: UIColor.white]
            
            // Customizing our navigation bar
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            setupLoadingIndicator()
            
            showLoadingIndicator(true)
            
            if Reachability.isConnectedToNetwork()
            {
                viewModel.fetchHighSchools()
                bindViewModel()
                
            }
            else
            {
                self.showToast(message: "Please check your network connection")
            }
            
        }
        else
        {
            // Fallback on earlier versions
        }
        
        
        
    }
    
    private func setupLoadingIndicator() {
        loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.center = view.center
        loadingView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(loadingView)
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        if show {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
    }
    
    
    
    private func bindViewModel() {
        
        viewModel.$highSchools
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.showLoadingIndicator(false)
            }
            .store(in: &cancellables)
    }
}

extension HighSchoolsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.highSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HighSchoolTableViewCell
        let highSchool = viewModel.highSchools[indexPath.row]
        cell.schoolNameLbl.text = highSchool.school_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !viewModel.isFetchingData() {
            
            print(!viewModel.isFetchingData())
            if Reachability.isConnectedToNetwork()
            {
                viewModel.fetchHighSchools()
            }
            else
            {
                self.showToast(message: "Please check your network connection")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSchool = viewModel.highSchools[indexPath.row]
        
        
        if Reachability.isConnectedToNetwork()
        {
            viewModel.fetchSATScores(for: selectedSchool) { [weak self] satScores in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.showSchoolDetails(for: selectedSchool, with: satScores)
                }
            }
        }
        else
        {
            self.showToast(message: "Please check your network connection")
        }
        
    }
    
    private func showSchoolDetails(for school: HighSchool, with satScores: SATScores?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "SchoolDetailsViewController") as? SchoolDetailsViewController else {
            return
        }
        detailsViewController.highSchool = school
        detailsViewController.satScores = satScores
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}



