//
//  AirportCell.swift
//  CityAirportSearch
//
//  Created by Shreya on 19/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit

class AirportCell: UITableViewCell {

    
    @IBOutlet weak var airportNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var runwayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(usingViewModel viewModel : AirportCellViewPresentable) {
        self.airportNameLabel.text = viewModel.name
        self.distanceLabel.text = viewModel.formattedDistance
        self.countryLabel.text = viewModel.address
        self.runwayLabel.text = viewModel.runwayLength
        self.selectionStyle = .none
    }
    
}
