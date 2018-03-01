//
//  DetailTableViewCell.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    
    enum Constants {
        static let offset: CGFloat = 5.0
        static let defaultWidth: CGFloat = 150
        static let defaultHeight: CGFloat = 90
    }
    
    let titleLabel = UILabel()
    let displayImageView = UIImageView()
    let descriptionLabel = UILabel()
    let lineView = UIView()

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.contentMode = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        displayImageView.image = UIImage(named: "default-placeholder")
        displayImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(displayImageView)

        descriptionLabel.contentMode = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)

        lineView.backgroundColor = UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: 1.0)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    // MARK: Setup Constraints for all elements
    fileprivate func setupConstraints() {
        setupTitleLabelConstraints()
        setupDisplayImageViewConstraints()
        setupDescriptionLabelConstraints()
        setupLineViewConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.mas_makeConstraints { make in
            make?.top.equalTo()(contentView.mas_top)?.with().offset()(Constants.offset)
            make?.leading.equalTo()(displayImageView.mas_trailing)?.with().offset()(Constants.offset)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(-1 * Constants.offset)
        }
    }
    
    private func setupDisplayImageViewConstraints() {
        displayImageView.mas_makeConstraints { make in
            make?.top.equalTo()(contentView.mas_top)?.with().offset()(Constants.offset)
            make?.bottom.lessThanOrEqualTo()(contentView.mas_bottom)?.with().offset()(-1 * Constants.offset)
            make?.leading.equalTo()(contentView.mas_leading)?.with().offset()(0)
            make?.width.offset()(Constants.defaultWidth)
            make?.height.offset()(Constants.defaultHeight)
        }
    }
    
    private func setupDescriptionLabelConstraints() {
        descriptionLabel.mas_makeConstraints { make in
            make?.top.equalTo()(titleLabel.mas_bottom)?.with().offset()(Constants.offset)
            make?.bottom.equalTo()(contentView.mas_bottom)?.with().offset()(-1 * Constants.offset)
            make?.leading.equalTo()(displayImageView.mas_trailing)?.with().offset()(Constants.offset)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(-1 * Constants.offset)
        }
    }
    
    private func setupLineViewConstraints() {
        lineView.mas_makeConstraints { make in
            make?.bottom.equalTo()(contentView.mas_bottom)?.with().offset()(0)
            make?.leading.equalTo()(contentView.mas_leading)?.with().offset()(0)
            make?.trailing.equalTo()(contentView.mas_trailing)?.with().offset()(0)
            make?.height.offset()(1)
        }
    }
    
    // MARK: Configure Cell
    func configureCell(_ model: Row?) {
        guard let model = model else {
            return
        }
    
        titleLabel.text = model.title
        descriptionLabel.text = model.descriptionField

        if let imageurl = model.imageHref as? String, let decodedUrl = imageurl.removingPercentEncoding {
            displayImageView.kf.setImage(with: URL(string: decodedUrl),
                                  placeholder: UIImage(named: "default-placeholder"),
                                      options: nil,
                                progressBlock: nil,
                            completionHandler: { (image, error, cacheType, url) in
                    if let image = image {
                        self.displayImageView.image = image
                        
                        // Resize imageView by the image ratio, but seems reset constraints doesn't work ???
                        let newSize = self.displayImageView.resizeFrameWith(image, restrictedByWidth: Constants.defaultWidth)
                        self.displayImageView.mas_makeConstraints({ make in
                            make?.width.offset()(newSize.width)
                            make?.height.offset()(newSize.height)
                        })
                    }
                })
        }
    }
}
