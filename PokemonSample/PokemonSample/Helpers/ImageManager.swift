//
//  ImageManager.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/04.
//

import Foundation


import UIKit
import SDWebImage

// ライブラリのimportを一箇所にまとめるためのクラスを作った
struct ImageManager {

    static func setImage(target: UIImageView, url: URL?) {
        target.sd_setImage(with: url, completed: nil)
    }
}
