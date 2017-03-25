//
//  PinterestViewController.swift
//  uiExamples
//
//  Created by David Martinez on 12/03/2017.
//  Copyright © 2017 Atenea. All rights reserved.
//
//
// This example is based on raywenderlich tutorial located at
// https://www.raywenderlich.com/107439/uicollectionview-custom-layout-tutorial-pinterest
//

import UIKit

protocol PinterestView: NSObjectProtocol {
    
    func appendPinteresetItems(items: [PinterestItem])
}

class PinterestViewController: UIViewController, PinterestView {

    private var presenter: PinterestPresenter!
    fileprivate var items: [PinterestItem] = []
    fileprivate var numberOfColumns = 2
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PinterestFactory.getPresenter()
        presenter.bind(view: self)
        
        configureCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let isWideDesign = self.view.bounds.width > self.view.bounds.height
        if isWideDesign {
            numberOfColumns = 3
        } else {
            numberOfColumns = 2
        }
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func configureCollectionView() {
        
        let nib = UINib(nibName: "PinterestCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "pinterestcell")
        
        let layout = PinterestCollectionViewLayout()
        layout.setDelegate(delegate: self)
        collectionView.collectionViewLayout = layout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadMoreItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func appendPinteresetItems(items: [PinterestItem]) {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        collectionView.reloadData()
    }
    
    @IBAction func actionClose(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension PinterestViewController: UICollectionViewDelegate {
    
}

extension PinterestViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pinterestcell", for: indexPath) as! PinterestCollectionViewCell
        let item = self.items[indexPath.row]
        cell.showPinterestItem(pinterestItem: item)
        return cell
    }
}

extension PinterestViewController: PinterestCollectionViewLayoutDelegate {
    
    func numberOfColumnsFor(collectionView: UICollectionView) -> Int {
        return numberOfColumns
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath,
                        cellWidth: CGFloat) -> CGFloat {
        
        let item = self.items[indexPath.row]
        guard let imageUrl = item.imageUrl else {
            return 0.0
        }
        
        guard let url = URL(string: imageUrl) else {
            return 0.0
        }
        
        let pathComponents = url.pathComponents
        guard pathComponents.count >= 3 else {
            return 0.0
        }
        
        let indexWidth = 1
        let indexHeight = 2
        let width = CGFloat(NumberFormatter().number(from: pathComponents[indexWidth])!)
        let height = CGFloat(NumberFormatter().number(from: pathComponents[indexHeight])!)
        
        let ratio = width / cellWidth
        let cellHeight = height / ratio
        
        return cellHeight
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        cellWidth width: CGFloat) -> CGFloat {
        
        let topPadding = CGFloat(4)
        let defaultPadding = CGFloat(8)
        
        let fontCaption = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightSemibold)
        let fontTitle = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightRegular)
        
        let item = self.items[indexPath.row]
        
        let widthAvailable = width - 2*defaultPadding
        let captionHeight = heightFor(string: item.caption, font: fontCaption, width: widthAvailable)
        let titleHeight = heightFor(string: item.title, font: fontTitle, width: widthAvailable)
        
        let height = topPadding + captionHeight + defaultPadding + titleHeight + defaultPadding
        return height
    }
    
    func heightFor(string:String, font: UIFont, width: CGFloat) -> CGFloat {
        let s = NSString(string: string)
        let bound = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let rect = s.boundingRect(with: bound, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
}
