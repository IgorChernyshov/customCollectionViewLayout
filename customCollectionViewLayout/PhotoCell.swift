//
//  SnowboardingPhotoCell.swift
//  customCollectionViewLayout
//
//  Created by Igor Chernyshov on 02/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	
	let imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addImageView()
		configureConstraints()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addImageView() {
		self.imageView.contentMode = .scaleAspectFit
		self.contentView.addSubview(imageView)
	}
	
	private func configureConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.imageView.image = nil
	}
	
}
