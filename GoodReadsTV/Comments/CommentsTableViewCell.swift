import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameTitleLbl: UILabel!
    @IBOutlet weak var commentTextLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTableView(with book: Book) {
        nicknameTitleLbl.text = book.title
        commentTextLbl.text = book.subtitle
        avatarImageView.image = book.coverImage
    }
}
