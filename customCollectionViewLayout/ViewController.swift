//
//  ViewController.swift
//  customCollectionViewLayout
//
//  Created by Igor Chernyshov on 02/06/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}

	func configureUI() {
		createCollectionView()
	}
	
	func createCollectionView() {
		let customLayout = PhotoCollectionViewLayout()
		customLayout.delegate = self
		
		let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: customLayout)
		collectionView.dataSource = self
		collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "reuseID")
		collectionView.backgroundColor = UIColor(red: 41.0/255.0, green: 40.0/255.0, blue: 52.0/255.0, alpha: 1)
		self.view.addSubview(collectionView)
	}
	
	private func image(at indexPath: IndexPath) -> UIImage? {
		return UIImage(named: "\(indexPath.row + 1)")
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 18
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as? PhotoCell else {
			return UICollectionViewCell()
		}
		cell.imageView.image = self.image(at: indexPath)
		return cell
	}
}

extension ViewController: PhotoCollectionViewLayoutDelegate {
	
	func ratio(forItemAt indexPath: IndexPath) -> CGFloat {
		guard let image = self.image(at: indexPath) else {
			return 1.0
		}
		return image.size.width / image.size.height
	}
}
