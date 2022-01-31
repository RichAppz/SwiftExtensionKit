//
//  UICollectionView+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2022 RichAppz Limited (https://richappz.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UICollectionView.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(
            UINib(nibName: cellId, bundle: nil),
            forCellWithReuseIdentifier: identifier ?? cellId
        )
    }
    
    func registerCells(types: [UICollectionViewCell.Type]) {
        for type in types {
            let cellId = String(describing: type)
            register(
                UINib(nibName: cellId, bundle: nil),
                forCellWithReuseIdentifier:cellId
            )
        }
    }
    
    func registerHeader(
        type: UICollectionReusableView.Type,
        identifier: String? = nil,
        hasNib: Bool = true) {
        
        let cellId = String(describing: type)
        if hasNib {
            register(
                UINib(nibName: cellId, bundle: nil),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: identifier ?? cellId
            )
        } else {
            register(
                type,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: identifier ?? cellId
            )
        }
    }
    
    func registerFooter(
        type: UICollectionReusableView.Type,
        identifier: String? = nil) {
        
        let cellId = String(describing: type)
        register(
            UINib(nibName: cellId, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: identifier ?? cellId
        )
    }
    
    /**
     DequeueCell by passing the type of UICollectionViewCell and IndexPath
     - Parameter type: UICollectionViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UICollectionViewCell>(
        withType type: T.Type,
        for indexPath: IndexPath) -> T? {
        
        return dequeueReusableCell(
            withReuseIdentifier: type.identifier,
            for: indexPath) as? T
    }
    
    func dequeueReusableCell<T: UICollectionReusableView>(
        withType type: UICollectionReusableView.Type,
        for indexPath: IndexPath,
        ofKind: String ) -> T? {
        
        return dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: type.identifier,
            for: indexPath) as? T
    }
    
}

public extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
