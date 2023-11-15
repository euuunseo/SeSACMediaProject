//
//  TrendViewController.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/10/31.
//

import UIKit
import Kingfisher

struct Movie {
    let date: String
    let genre: String
    let thumbnail: String
    let title: String
    let overview: String
    let rate: Double
    let movieId: Int
}

class TrendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movieList: TrendAPI = TrendAPI(totalPages: 0, page: 0, totalResults: 0, results: [])
    // codable
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionViewCellLayout()
        
        callRequest()
        
    }
    
    func callRequest () {
        
        TMBD_APIManager.shared.callRequest { response in
            self.movieList = response
            
            print(self.movieList)
            self.collectionView.reloadData()
        }
    }
    
}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionViewCellLayout () {
            let layout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.width
            
            layout.itemSize = CGSize(width: width , height: 480)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
            layout.minimumLineSpacing = 50
            
            collectionView.collectionViewLayout = layout
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let vc = storyboard?.instantiateViewController(identifier: "CreditViewController") as! CreditViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
            vc.movieidContents = movieList.results[indexPath.row].id
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return movieList.results.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.reuseIdentifier, for: indexPath) as! TrendCollectionViewCell
            
            let row = indexPath.row
            
            cell.titleLabel.text = movieList.results[row].title
            cell.dateLabel.text = movieList.results[row].releaseDate
            cell.detailLabel.text = movieList.results[row].overview
            //오류?? 왜..??
            //cell.hashTagLabel.text = movieList.results[row].mediaType
            
            
            let rate: Double = movieList.results[row].popularity
            let str = String(format: "%.1f", rate)
            cell.rateLabel.text = str
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + (movieList.results[row].posterPath ?? ""))
            
            
            cell.posterImage.kf.setImage(with: url)
            
            cell.configureCell()
            
            return cell
        }
        
        
}
    

