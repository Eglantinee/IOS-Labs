//
//  BookTableViewCell.swift
//  App
//
//  Created by Ivan on 24.04.2021.
//
import UIKit

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
        bookImage.image = book.bookImage
        title.text = book.title
        subtitle.text = book.subtitle
        price.text = book.price
    }
}
