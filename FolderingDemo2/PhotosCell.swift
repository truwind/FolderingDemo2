//
//  PhotosCell.swift
//  FolderingDemo2
//
//  Created by bflysoft on 2018. 2. 19..
//  Copyright © 2018년 bflysoft. All rights reserved.
//


import UIKit

@objc protocol PhotoCellProtocol {
    func selectedMainImage(index: Int) -> Void
}

class PhotosCell: FoldingCell {
    fileprivate let constOfStackViewInterval : Int = 99
    @IBOutlet weak var constOfStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var lbCloseTitle: UILabel!
    @IBOutlet weak var lbCloseDate: UILabel!
    @IBOutlet weak var lbCloseTime: UILabel!
    @IBOutlet weak var ivClosePhoto: UIImageView!
    
    @IBOutlet weak var lbOpenTitle: UILabel!
    @IBOutlet weak var lbOpenDate: UILabel!
    @IBOutlet weak var lbOpenTime: UILabel!
    @IBOutlet weak var ivOpenPhoto: UIImageView!
    
    // srollview의 mini photo
    @IBOutlet weak var ivPhoto01: UIImageView!
    @IBOutlet weak var ivPhoto02: UIImageView!
    @IBOutlet weak var ivPhoto03: UIImageView!
    @IBOutlet weak var ivPhoto04: UIImageView!
    @IBOutlet weak var ivPhoto05: UIImageView!
    @IBOutlet weak var ivPhoto06: UIImageView!
    @IBOutlet weak var ivPhoto07: UIImageView!
    @IBOutlet weak var ivPhoto08: UIImageView!
    @IBOutlet weak var ivPhoto09: UIImageView!
    @IBOutlet weak var ivPhoto10: UIImageView!
    
    var photoItemViews: [UIImageView]?
    
    fileprivate var curSelectedImageIndex: Int = 0;
    
    /**
     * swift의 변수를 obj-C에서 접근하기 위해서 '@objc'를 추가함.
     * http://jayeshkawli.ghost.io/using-swift-variables-in-objective-c-in-swift-4/
     */
    @objc var number: Int = 0 {
        didSet {
            lbCloseTitle.text = String(number)
            lbOpenTitle.text = String(number)
        }
    }
    
    @objc var imageName : String? = "" {
        didSet {
            ivClosePhoto.image = UIImage(named: imageName!)
            ivOpenPhoto.image = UIImage(named: imageName!)
        }
    }

    @objc var subPhotoNumber : Int = 0 {
        didSet {
            for i in 0 ..< subPhotoNumber {
                print("\(i)")
                let photoView = photoItemViews![i]
                photoView.isHidden = false
            }
//            constOfStackViewWidth.constant = CGFloat(subPhotoNumber*constOfStackViewInterval)
//            print("\(constOfStackViewWidth.constant)")
//            stackView.layoutIfNeeded()
        }
    }
    @objc var delegate: PhotoCellProtocol?
//    @objc var mainImageSelectHandler: [() -> Void]
    
    override func awakeFromNib() {
        backgroundColor = .clear
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        photoItemViews = [UIImageView]()
        
        photoItemViews?.append(ivPhoto01)
        photoItemViews?.append(ivPhoto02)
        photoItemViews?.append(ivPhoto03)
        photoItemViews?.append(ivPhoto04)
        photoItemViews?.append(ivPhoto05)
        photoItemViews?.append(ivPhoto06)
        photoItemViews?.append(ivPhoto07)
        photoItemViews?.append(ivPhoto08)
        photoItemViews?.append(ivPhoto09)
        photoItemViews?.append(ivPhoto10)
        
        ivPhoto01.isHidden = true
        ivPhoto02.isHidden = true
        ivPhoto03.isHidden = true
        ivPhoto04.isHidden = true
        ivPhoto05.isHidden = true
        ivPhoto06.isHidden = true
        ivPhoto07.isHidden = true
        ivPhoto08.isHidden = true
        ivPhoto09.isHidden = true
        ivPhoto10.isHidden = true
        
//        constOfStackViewWidth.constant = 0
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    @IBAction func subPhotoSelected(_ sender: UIButton) {
        
        print("\(sender.tag)")
        curSelectedImageIndex = sender.tag - 1000
        let photoView = photoItemViews![curSelectedImageIndex]
        ivOpenPhoto.image = photoView.image
    }
    
    @IBAction func selectedPhoto(_ sender: Any) {
        print("tap")
        delegate?.selectedMainImage(index: curSelectedImageIndex)
        
    }
}

