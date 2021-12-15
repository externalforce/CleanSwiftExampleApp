//
//  ProductCell.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var foregroundView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var installmentLabel: UILabel!
    var productModel: ProductViewModel?
    let imageCache = NSCache<NSString, UIImage>()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearence()
    }
    
    fileprivate func configureAppearence() {
        foregroundView.layer.borderColor = UIColor.lightGray.cgColor
        foregroundView.layer.borderWidth = 0.5
        foregroundView.layer.cornerRadius = 5
        foregroundView.clipsToBounds = true
        spinner.hidesWhenStopped = true
    }
    func configureCell(model: ProductViewModel) {
        spinner.startAnimating()
        productImageView.image = UIImage(named: "productDefaultPlaceholder")
        oldPriceLabel.isHidden = false
        productModel = model
        productNameLabel.text = model.name
        if model.oldPrice == 0.0 {
            oldPriceLabel.isHidden = true
        }
        if model.installment == "" {
            installmentLabel.text = "Taksit mevcut değildir."
        } else {
            installmentLabel.text = model.installment
        }
        let attributedOldPriceString: NSMutableAttributedString =  NSMutableAttributedString(string: "\((productModel?.oldPrice)!) TL")
        attributedOldPriceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedOldPriceString.length))
        oldPriceLabel.attributedText = attributedOldPriceString
        newPriceLabel.text = "\((productModel?.newPrice)!) TL"
        downloadImage(from: model.imageURL) { (image, error) in
            DispatchQueue.main.async() {
                self.spinner.stopAnimating()
                self.productImageView.image = image
            }
        }
    }
    
    // MARK: - Helper Methods for asynchronous image download and caching
    func downloadImage(from url: URL, completion: @escaping(_ image: UIImage?, _ error: Error?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        }
        getData(from: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
