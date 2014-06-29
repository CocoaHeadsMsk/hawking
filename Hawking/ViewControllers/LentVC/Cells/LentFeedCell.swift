//
//  LentFeedCell.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit

let maxLength: Int = 90

class LentFeedCell: SWTableViewCell {

    @IBOutlet var articleImageView: UIImageView
    @IBOutlet var articleTextLabel: UILabel
    @IBOutlet var articleImageWidthConstraint: NSLayoutConstraint
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        articleTextLabel.adjustsFontSizeToFitWidth = true;
        selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillContent(image: UIImage?, title: String?, var text: String?) {
        if image {
            articleImageView.image = image;
        } else {
            articleImageWidthConstraint.constant = 0
        }
        
        var titleLength = 0;
        let mutableAttributedString = NSMutableAttributedString()
        
        if title {
            let attributedString = NSAttributedString(string: title! + "\n", attributes: [UITextAttributeFont
                : UIFont(name: "HelveticaNeue", size: 24)]);
            mutableAttributedString.appendAttributedString(attributedString)
            titleLength += title!.length
        }
        
        if text {
            if (titleLength + text!.length > maxLength) {
               
                let toIndexInt = (titleLength > maxLength) ? 0 : maxLength - titleLength;
                text = text!.substringToIndex(toIndexInt) + "..."
            }
            
            let attributedString = NSAttributedString(string: text, attributes: [UITextAttributeFont
                : UIFont(name: "HelveticaNeue", size: 14)]);
            mutableAttributedString.appendAttributedString(attributedString)
        }
        
        articleTextLabel.attributedText = mutableAttributedString;
    }
    
}
