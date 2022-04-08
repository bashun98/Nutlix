//
//  HeaderView.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import UIKit

class HeaderView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "duna")
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let downLoadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addGradient()
        //translatesAutoresizingMaskIntoConstraints = false
    }
    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        addViews()
//        addGradient()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
        gradientLayer.frame = bounds
        stackViewlayout()
    }
    
    private func addViews() {
        addSubview(headerImageView)
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(downLoadButton)
    }
    
    private func addGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        headerImageView.layer.addSublayer(gradientLayer)
    }
    
    private func stackViewlayout() {
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 35),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
}
