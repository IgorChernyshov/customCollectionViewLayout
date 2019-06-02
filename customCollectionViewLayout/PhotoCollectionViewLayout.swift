//
//  PhotoCollectionViewLayout.swift
//  customCollectionViewLayout
//
//  Created by Igor Chernyshov on 02/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewLayoutDelegate: class {
	func ratio(forItemAt indexPath: IndexPath) -> CGFloat
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
	
	weak var delegate: PhotoCollectionViewLayoutDelegate?
	
	private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
	
	override var collectionViewContentSize: CGSize {
		var maxX: CGFloat = 0.0
		var maxY: CGFloat = 0.0
		for attribute in self.cache.values {
			if maxX < attribute.frame.maxX {
				maxX = attribute.frame.maxX
			}
			if maxY < attribute.frame.maxY {
				maxY = attribute.frame.maxY
			}
		}
		return CGSize(width: maxX, height: maxY)
	}
	
	override func prepare() {
		super.prepare()
		self.cache = [:]
		guard let collectionView = self.collectionView, let delegate = self.delegate else {	return }
		
		let numberOfItems = collectionView.numberOfItems(inSection: 0)
		let cellHeight = collectionView.frame.height / 2

		var firstRowWidth: CGFloat = 0.0
		var secondRowWidth: CGFloat = 0.0
		var allAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
		for itemIndex in 0..<numberOfItems {
			let indexPath = IndexPath(item: itemIndex, section: 0)
			let ratio = delegate.ratio(forItemAt: indexPath)
			let cellWidth = cellHeight * ratio
			let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
			let isForFirstRow = firstRowWidth <= secondRowWidth
			let x = isForFirstRow ? firstRowWidth : secondRowWidth
			let y = isForFirstRow ? 0.0 : cellHeight
			attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
			allAttributes[indexPath] = attributes
			
			if isForFirstRow {
				firstRowWidth += cellWidth
			} else {
				secondRowWidth += cellWidth
			}
		}
		self.cache = allAttributes
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return self.cache.values.filter { $0.frame.intersects(rect) }
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return self.cache[indexPath]
	}
}

