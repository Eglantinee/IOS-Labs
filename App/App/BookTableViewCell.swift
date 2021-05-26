//
//  BookTableViewCell.swift
//  App
//
//  Created by Ivan on 24.04.2021.
//
import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var price: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setUp(book: BookViewController.Book) {
        title.text = book.title
        subtitle.text = book.subtitle
        price.text = book.price
        bookImage.sd_setImage(with: URL(string: book.image), placeholderImage: book.bookImage)
    }
}
