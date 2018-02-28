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
    
    let titleLabel = UILabel()
    let displayImageView = UIImageView()
    let descriptionLabel = UILabel()
    let lineView = UIView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    static func nib() -> UINib {
//        return UINib(nibName: String(describing: self), bundle: nil)
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        displayImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(displayImageView)

        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byCharWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)

        lineView.backgroundColor = .red
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        setupTitleLabelConstraints()
        setupDisplayImageViewConstraints()
        setupDescriptionLabelConstraints()
        setupLineViewConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.mas_makeConstraints { make in
            make?.top.equalTo()(contentView.mas_topMargin)?.with().offset()(5)
            make?.leading.equalTo()(displayImageView.mas_trailing)?.with().offset()(5)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(5)
        }
    }
    
    private func setupDisplayImageViewConstraints() {
        displayImageView.mas_makeConstraints { make in
            make?.top.equalTo()(contentView.mas_topMargin)?.with().offset()(5)
            make?.bottom.greaterThanOrEqualTo()(contentView.mas_bottomMargin)?.with().offset()(-5)
            make?.leading.equalTo()(contentView.mas_leading)?.with().offset()(0)
            make?.width.offset()(150)
            make?.height.offset()(90)
        }
    }
    
    private func setupDescriptionLabelConstraints() {
        descriptionLabel.mas_makeConstraints { make in
            make?.top.equalTo()(titleLabel.mas_bottomMargin)?.with().offset()(5)
            make?.bottom.equalTo()(contentView.mas_bottomMargin)?.with().offset()(-5)
            make?.leading.equalTo()(displayImageView.mas_trailing)?.with().offset()(5)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(5)
        }
    }
    
    private func setupLineViewConstraints() {
        lineView.mas_makeConstraints { make in
            make?.bottom.equalTo()(contentView.mas_bottomMargin)?.with().offset()(0)
            make?.leading.equalTo()(contentView.mas_leading)?.with().offset()(0)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(0)
            make?.height.offset()(1)
        }
    }
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        displayImageView.image = UIImage(named: "default-placeholder")
    }
    
    func configureCell(_ model: Row?) {
        guard let model = model else {
            return
        }
    
        titleLabel.text = model.title
        if let imageurl = model.imageHref as? String {
            displayImageView.kf.setImage(with: URL(string: imageurl.removingPercentEncoding!), placeholder: UIImage(named: "default-placeholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                if let image = image {
                    self.displayImageView.image = image

                    let newSize = self.displayImageView.resizeFrameWith(image, restrictedByWidth: 150)
                    self.displayImageView.mas_makeConstraints({ make in
                        make?.width.offset()(newSize.width)
                        make?.height.offset()(newSize.height)
                    })
                } else {
                    self.displayImageView.mas_makeConstraints { make in
                        make?.width.offset()(150)
                        make?.height.offset()(90)
                    }
                }
            })
        }
        descriptionLabel.text = model.descriptionField
    }
}
