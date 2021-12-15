//
//  EmptyCell.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 19.07.2019.
//

import UIKit

class EmptyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
