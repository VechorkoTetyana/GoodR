import UIKit

class GoodReadsHeaderCell: UITableViewCell {

    @IBOutlet weak var backgrounrCircleImageView: UIImageView!
    @IBOutlet weak var backgrounrCircleImageMiddleView: UIImageView!
    @IBOutlet weak var smsSearchImageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgrounrCircleImageView.layer.cornerRadius = 90
        backgrounrCircleImageView.layer.masksToBounds = true

        backgrounrCircleImageMiddleView.layer.cornerRadius = 62
        backgrounrCircleImageMiddleView.layer.masksToBounds = true
       
        selectionStyle = .none
    }
    
    func configure(with books: Book) {
        titleLbl.text = books.title
        subTitleLbl.text = books.subtitle
        smsSearchImageView.image = books.coverImage
    }
}
