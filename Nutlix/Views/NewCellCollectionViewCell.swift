
import UIKit
import Kingfisher

class NewCellCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with url: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(url)") else {return}
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: url)
    }
}
