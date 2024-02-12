//
//  SchoolDetailsViewController.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import UIKit

class SchoolDetailsViewController: UIViewController {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var mathScoreLabel: UILabel!
    @IBOutlet weak var readingScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    
    var highSchool: HighSchool?
    var satScores: SATScores?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SAT scores"
        
        updateUI()
    }
    
    func updateUI() {
        guard let highSchool = highSchool else { return }
        schoolNameLabel.text = highSchool.school_name
        if let satScores = satScores {
            mathScoreLabel.text = "Math: \(satScores.sat_math_avg_score)"
            readingScoreLabel.text = "Reading: \(satScores.sat_critical_reading_avg_score)"
            writingScoreLabel.text = "Writing: \(satScores.sat_writing_avg_score)"
        } else {
            mathScoreLabel.text = "SAT scores are not available"
            readingScoreLabel.text = "SAT scores are not available"
            writingScoreLabel.text = "SAT scores are not available"
        }
    }
}
