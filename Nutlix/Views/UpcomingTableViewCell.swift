//
//  UpComingTableViewCell.swift
//  Nutlix
//
//  Created by Евгений Башун on 10.04.2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    private let upcomingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let mediaDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentStackView.frame = contentView.bounds
        stackViewlayout()
    }
    
    private func addViews() {
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(upcomingImageView)
        contentStackView.addArrangedSubview(mediaDescriptionLabel)
        contentStackView.addArrangedSubview(playButton)
    }
    
    private func stackViewlayout() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            upcomingImageView.widthAnchor.constraint(equalToConstant: 130),
            upcomingImageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor),
            
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor)
        ])
    }
    
    func configure(with model: UpcomingModel) {
        upcomingImageView.kf.indicatorType = .activity
        upcomingImageView.kf.setImage(with: model.imageURL)
        
        mediaDescriptionLabel.text = model.title
        
    }
    
}
