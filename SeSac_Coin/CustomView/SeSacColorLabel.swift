//
//  SeSacColorLabel.swift
//  SeSac_Coin
//
//  Created by youngjoo on 3/1/24.
//

import UIKit

enum SeSacColor {
    case sesac_Black
    case sesac_Blue
    case sesac_DarkGray
    case sesac_LightBlack
    case sesac_LightGray
    case sesac_Pink
    case sesac_Puple
    case sesac_Red
    case sesac_Sky
    case sesac_White
}

final class SeSacColorLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(color: SeSacColor) {
        self.init()
        configureView(color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeSacColorLabel {
    
    func configureView(_ color: SeSacColor) {
        switch color {
        case .sesac_Black:
            textColor = .sesacBlack
        case .sesac_Blue:
            textColor = .sesacBlue
        case .sesac_DarkGray:
            textColor = .sesacDarkGray
        case .sesac_LightBlack:
            textColor = .sesacLightBlack
        case .sesac_LightGray:
            textColor = .sesacLightGray
        case .sesac_Pink:
            textColor = .sesacPink
        case .sesac_Puple:
            textColor = .sesacPuple
        case .sesac_Red:
            textColor = .sesacRed
        case .sesac_Sky:
            textColor = .sesacSky
        case .sesac_White:
            textColor = .sesacWhite
        }
    }
}
