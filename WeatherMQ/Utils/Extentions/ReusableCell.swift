//
//  ReusableCell.swift
//  MQTest
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import Foundation
import UIKit

public protocol Reusable {}


// MARK: - UICollectionViewCell

extension UICollectionReusableView: Reusable {}

public extension Reusable where Self: UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


public extension Reusable where Self: UICollectionReusableView {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - UICollectionView

public extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func deueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
    
    func registerClass<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) {
        self.register(supplementaryViewType, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) {
        self.register(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>
    (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T {
        
        let dequeueView = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath)
        guard let view = dequeueView as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(viewType.reuseIdentifier)")
        }
        
        return view
    }
}


// MARK: - UITableViewCell

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

public extension Reusable where Self: UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


public extension Reusable where Self: UITableViewHeaderFooterView {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - UITableView

public extension UITableView {
    
    func registerClass<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(cellType: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
    
    func registerClass<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) {
        self.register(headerFooterViewType, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? {
        
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError("Could not dequeue header/footer with identifier: \(viewType.reuseIdentifier)")
        }
        
        return view
    }
}

