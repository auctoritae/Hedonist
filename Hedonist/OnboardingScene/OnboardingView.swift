//
//  OnboardingView.swift
//  Hedonist
//
//  Created by Alexandr on 6/24/23.
//

import UIKit
import SnapKit

final class OnboardingView: UIView {
    // MARK: - Variable
    var router: OnboardingRouter?
    
    
    // MARK: - UI Variable
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xMark")?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.7).cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.black.withAlphaComponent(1.0).cgColor
        ]
        return gradient
    }()
    
    private lazy var overlay: UIView = {
        let container = UIView()
        container.layer.masksToBounds = true
        container.isUserInteractionEnabled = true
        return container
    }()
    
    private lazy var onboardingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboardingImage")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var onboardingTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.placeTitle
        title.text = Onboarding.title.uppercased()
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var onboardingSubtitle: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = Fonts.cellSubtitle
        title.text = Onboarding.subtitle
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var first: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.text = Onboarding.firstPoint
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var second: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.text = Onboarding.secondPoint
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var third: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.text = Onboarding.thirdPoint
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    @objc private func close() {
        router?.close()
    }
    
    
    // MARK: - UI
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        overlay.layer.addSublayer(gradient)
        gradient.frame = overlay.bounds
    }
    
    private func layoutUI() {
        backgroundColor = .black
        
        addSubview(onboardingImage)
        addSubview(closeButton)
        addSubview(onboardingTitle)
        addSubview(onboardingSubtitle)
        addSubview(first)
        addSubview(second)
        addSubview(third)
        
        onboardingImage.addSubview(overlay)
        onboardingImage.bringSubviewToFront(overlay)
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        onboardingImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        onboardingTitle.snp.makeConstraints {
            $0.top.equalTo(onboardingImage.snp.bottom).offset(-UIConstants.sidePadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
        }
        
        onboardingSubtitle.snp.makeConstraints {
            $0.top.equalTo(onboardingTitle.snp.bottom).offset(UIConstants.sidePadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
        }
        
        first.snp.makeConstraints {
            $0.top.equalTo(onboardingSubtitle.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
        }
        
        second.snp.makeConstraints {
            $0.top.equalTo(first.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
        }
        
        third.snp.makeConstraints {
            $0.top.equalTo(second.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
        }
    }
}
