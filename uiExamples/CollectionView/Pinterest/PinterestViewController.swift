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
    var items: [PinterestItem] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PinterestFactory.getPresenter()
        presenter.bind(view: self)
        
        let nib = UINib(nibName: "PinterestCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "pinterestcell")
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
