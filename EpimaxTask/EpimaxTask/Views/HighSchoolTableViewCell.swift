//
//  HighSchoolTableViewCell.swift
//  EpimaxTask
//
//  Created by Kartheek Repakula on 10/02/24.
//

import UIKit

class HighSchoolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var schoolNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
