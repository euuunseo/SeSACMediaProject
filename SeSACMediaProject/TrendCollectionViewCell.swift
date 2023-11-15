//
//  TrendCollectionViewCell.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/10/31.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hashTagLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var serveRateLabel: UILabel!
    @IBOutlet var seeDetailLabel: UILabel!
    
    func configureCell () {
        
        let basicFont = UIFont.systemFont(ofSize: 13)
        let bigFont = UIFont.boldSystemFont(ofSize: 16)
        
        posterImage.contentMode = .scaleToFill
        
        //그림자
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
        clipsToBounds = false

        backgroundColor = .white
        
        serveRateLabel.textAlignment = .center
        serveRateLabel.textColor = .white
        serveRateLabel.backgroundColor = .systemPink
        rateLabel.backgroundColor = .white
        rateLabel.textAlignment = .center
        
        rateLabel.font = basicFont
        serveRateLabel.font = basicFont
        detailLabel.font = basicFont
        seeDetailLabel.font = basicFont
        dateLabel.font = basicFont
        
        titleLabel.font = bigFont
        hashTagLabel.font = bigFont
    }
}
