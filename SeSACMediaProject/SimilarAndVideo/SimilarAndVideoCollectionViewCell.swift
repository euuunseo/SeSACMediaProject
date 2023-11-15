//
//  SimilarAndVideoCollectionViewCell.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/11/16.
//

import UIKit

class SimilarAndVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
    }

}
