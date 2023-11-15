//
//  CreditViewController.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/11/01.
//

import UIKit
import Kingfisher

struct Credit {
    let name: String
    let originalName: String
    let image: String
    
}



class CreditViewController: UIViewController {

    @IBOutlet var castCollectionVIew: UICollectionView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backImage: UIImageView!
    
    
    
    var creditList: [Credit] = []
    
    var movieidContents: Int = 0
    
    @IBOutlet var castCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        
        flowLayout()
        callRequest()
        
    }

    func callRequest () {
        
        TMBD_APIManager.shared.callMovieIdRequest(movieId: movieidContents) { json in
            for item in json["cast"].arrayValue {
                let name = item["character"].stringValue
                let originalName = item["original_name"].stringValue
                let image = item["profile_path"].stringValue
                          
            let data = Credit(name: name, originalName: originalName, image: image)
                
            self.creditList.append(data)
                
            }
            self.castCollectionVIew.reloadData()
        }
        
    }

}


extension CreditViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func flowLayout () {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: width, height: 110)
        
        castCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditCollectionViewCell", for: indexPath) as! CreditCollectionViewCell
        
        cell.nameLabel.text = creditList[indexPath.row].name
        cell.originalNameLabel.text = creditList[indexPath.row].originalName
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + creditList[indexPath.row].image)
        
        cell.actorIamgeView.kf.setImage(with: url)
        

        return cell
    }
    
    
    
}

