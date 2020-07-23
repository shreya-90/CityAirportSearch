//
//  CityCellTableViewCell.swift
//  CityAirportSearch
//
//  Created by Shreya on 17/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(usingViewModel viewModel :  CityViewModelPresentable){
        self.cityLabel.text = viewModel.city
        self.locationLabel.text = viewModel.location
        self.selectionStyle = .none 
    }

    
}
