//
//  TagsTableViewCell.swift
//  Catty App
//
//  Created by Vladimir Alyoshkin on 30.11.21.
//

import UIKit

class TagsTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
        func configure(tag: String) {
        titleLable.text = tag
   }
}
