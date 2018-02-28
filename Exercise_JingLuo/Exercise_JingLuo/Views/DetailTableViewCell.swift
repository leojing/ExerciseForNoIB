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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        titleLabel = UILabel()
//        titleLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        contentView.addSubview(titleLabel)
//
//        displayImageView = UIImageView()
//        displayImageView.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
//        contentView.addSubview(displayImageView)
//
//        descriptionLabel = UILabel()
//        descriptionLabel.frame = CGRect(x: 0, y: 40, width: 40, height: 40)
//        contentView.addSubview(descriptionLabel)
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        displayImageView.image = UIImage(named: "default-placeholder")
        descriptionLabel.text = nil
    }
    
    func configureCell(_ model: Row?) {
        guard let model = model else {
            return
        }
        titleLabel.text = model.title
        if let imageurl = model.imageHref as? String {
            displayImageView.kf.setImage(with: URL(string: imageurl.removingPercentEncoding!), placeholder: UIImage(named: "default-placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        descriptionLabel.text = model.descriptionField
    }
}
