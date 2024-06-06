import UIKit

class GoodReadsListCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func configure(with book: Book) {
        titleLbl.text = book.title
        subTitleLbl.text = book.subtitle
        coverImage.image = book.coverImage
    }
}
