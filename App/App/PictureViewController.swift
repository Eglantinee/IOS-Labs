//
//  PictureViewController.swift
//  App
//
//  Created by Ivan on 09.05.2021.
//

import UIKit


class PictureViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UINavigationItem!
    
    var imagePicker: ImagePicker!
    var pictures: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparations()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func preparations() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = createLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.show()
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            
            let bigPicture = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),                           heightDimension: .fractionalHeight(2/4)))
            
            
            let littlePicture = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .fractionalWidth(1/4)))
            
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalWidth(1/4)),
                subitem: littlePicture, count: 3)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(2/4)), subitem: littlePicture, count: 2)
        
//            let middleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/4)), subitems: [verticalGroup, bigPicture])
            
            let allGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1)),
                
                subitems: [horizontalGroup, verticalGroup, bigPicture, horizontalGroup])
            
            return NSCollectionLayoutSection(group: allGroup)
        }
        
        return layout
    }
    
}

extension PictureViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        pictures.append(image!)
        collectionView.reloadData()
    }
}


class PictureCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
}

extension PictureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
        cell.pictureImageView.image = pictures[indexPath.row]
        return cell
    }
}
