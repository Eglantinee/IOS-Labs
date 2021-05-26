//
//  PictureViewController.swift
//  App
//
//  Created by Ivan on 09.05.2021.
//

import UIKit
import Foundation
import SDWebImage

struct SingleImage: Codable {
    var id: Int
    var webformatURL: String
}

struct Images: Codable {
    var hits: [SingleImage]
}

class PictureViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UINavigationItem!
    @IBOutlet weak var pictureActivityIndicator: UIActivityIndicatorView!
    
    var imagePicker: ImagePicker!
    var pictures: [SingleImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparations()
        pictureActivityIndicator.hidesWhenStopped = true
        pictureActivityIndicator.layer.cornerRadius = 5
        getImages()
    }

    func getImages() {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pixabay.com"
        urlComponents.path = "/api"

        urlComponents.queryItems = [URLQueryItem(name: "key", value: "19193969-87191e5db266905fe8936d565"), URLQueryItem(name: "image_type", value: "photo"), URLQueryItem(name: "per_page", value: "27"), URLQueryItem(name: "q", value: "night+city")]

        guard let url = urlComponents.url else {
            return
        }

        pictureActivityIndicator.startAnimating()

        URLSession(configuration: .default).dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in

            if let error = error {
                print(error)
                return
            }

            if let data = data {
                do {
                    let serverResponse = try JSONDecoder().decode(Images.self, from: data)

                    DispatchQueue.main.async {
                        self?.pictureActivityIndicator.stopAnimating()
                        self?.pictures = serverResponse.hits
                        self?.collectionView.reloadData()
                    }

                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
    
    func preparations() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = createLayout()
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
//    @IBAction func showImagePicker(_ sender: Any) {
//        self.imagePicker.show()
//    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            
            let bigPicture = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0)))
            
            
            let littlePicture = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0)))
            
            let littlePicture2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),                                 heightDimension: .fractionalHeight(1/4)),
                subitem: littlePicture, count: 3)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitem: littlePicture2, count: 2)
        
            let middleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/4)), subitems: [verticalGroup, bigPicture])
            
            let allGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1)),
                
                subitems: [horizontalGroup, middleGroup, horizontalGroup])
            
            return NSCollectionLayoutSection(group: allGroup)
        }
        
        return layout
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
        cell.pictureImageView.sd_setImage(with: URL(string: pictures[indexPath.row].webformatURL), placeholderImage: UIImage(systemName: "photo.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        return cell
    }
}
