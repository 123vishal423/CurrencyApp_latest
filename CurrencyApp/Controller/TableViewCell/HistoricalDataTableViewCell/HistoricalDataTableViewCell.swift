//
//  HistoricalDataTableViewCell.swift
//  CurrencyApp
//
//  Created by badal on 01/12/22.
//

import UIKit

class HistoricalDataTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!

    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var egpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var ausLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var cnyLabel: UILabel!
    @IBOutlet weak var qarLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
