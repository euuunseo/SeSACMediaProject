//
//  SimilarAndVideoViewController.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/11/16.
//

import UIKit

protocol collectionViewAttributeProtocol {
    func configureCollectionVIewCell()
    func configureCollectionViewFlowLayout()
    
}

class SimilarAndVideoViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    var similarList: SimilarAPI = SimilarAPI(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    var videoList: VideoAPI = VideoAPI(id: 0, results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionVIewCell()
        configureCollectionViewFlowLayout()
        segmentDesign()
        
        TMBD_APIManager.shared.callSimilarRequest(movieId: 448491) { data in
            self.similarList = data
            self.collectionView.reloadData()
            }
        
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        
        let similar = 0
        let video = 1
        
        //리틀포레스트 448491
        
        let group = DispatchGroup()
        
        if segmentedControl.selectedSegmentIndex == video {
            
            group.enter()
            TMBD_APIManager.shared.callVideoAPIRequest(movidID: 448491) { data in
                self.videoList = data
                print("====\(self.videoList)")
                group.leave()
                
            }
        } else if segmentedControl.selectedSegmentIndex == similar {
            
            group.enter()
            TMBD_APIManager.shared.callSimilarRequest(movieId: 448491) { data in
                self.similarList = data
                print("시밀러 리스트 : \(self.similarList)")
                group.leave()
                }
        }
        
        group.notify(queue: .main) {
            print("=====끝!!!!=====")
            self.collectionView.reloadData()
        }
    }


    func segmentDesign () {
        segmentedControl.setTitle("Similar", forSegmentAt: 0)
        segmentedControl.setTitle("Video", forSegmentAt: 1)
    }

}

extension SimilarAndVideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return similarList.results.count
        } else if segmentedControl.selectedSegmentIndex == 1 {
            return videoList.results.count
        } else {
            return similarList.results.count
        }
           
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarAndVideoCollectionViewCell.reuseIdentifier, for: indexPath) as? SimilarAndVideoCollectionViewCell else {
            return UICollectionViewCell()
        }
 
        if segmentedControl.selectedSegmentIndex == 1 {
            cell.titleLabel.text = " \(videoList.results[indexPath.row].name) \n 게시 날짜 : \(videoList.results[indexPath.row].publishedAt)"
        } else {
            cell.titleLabel.text = similarList.results[indexPath.row].title
        }
        
        collectionView.reloadData()
        
        return cell
    }
    
    
}

extension SimilarAndVideoViewController: collectionViewAttributeProtocol {
    
    func configureCollectionVIewCell() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "SimilarAndVideoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SimilarAndVideoCollectionViewCell.reuseIdentifier)
        
    }
    
    func configureCollectionViewFlowLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        
        collectionView.collectionViewLayout = layout
    }
    
    
}
