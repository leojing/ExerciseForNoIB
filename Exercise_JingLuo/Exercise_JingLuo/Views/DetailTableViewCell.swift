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
        titleLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        contentView.addSubview(titleLabel)
        
        displayImageView = UIImageView()
        displayImageView.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        contentView.addSubview(displayImageView)
        
        descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 0, y: 40, width: 40, height: 40)
        contentView.addSubview(descriptionLabel)
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    func configureCell(_ model: Row?) {
        guard let model = model else {
            return
        }
        
        titleLabel.text = model.title
        if let imageurl = model.imageHref as? String {
            displayImageView.kf.setImage(with: URL(string: imageurl))
        }
        descriptionLabel.text = model.description
    }
}
