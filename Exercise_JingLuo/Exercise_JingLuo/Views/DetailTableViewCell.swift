//
//  DetailTableViewCell.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit
import Kingfisher

struct DetailCellDisplayModel {
    var title: String?
    var imageURL: String?
    var description: String?
}

class DetailTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var displayImageView: UIImageView!
    var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        displayImageView = UIImageView()
        contentView.addSubview(displayImageView)
        
        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    func configureCell(_ model: DetailCellDisplayModel?) {
        guard let model = model else {
            return
        }
        
        titleLabel.text = model.title
        if let imageurl = model.imageURL {
            displayImageView.kf.setImage(with: URL(string: imageurl))
        }
        descriptionLabel.text = model.description
    }
}
