//
//  TestView.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos, Vodafone on 7/7/23.
//

import UIKit

class TestView: UIView {
    //create the outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var testLabel: UILabel!
    
    override init(frame: CGRect) { // for using  CustomView in code
        super.init (frame : frame)
        commonInit()
    }
    
    required init?(coder aDecoder : NSCoder) { // for using CostumView in InterfaceBuilder
        super.init(coder : aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        //we are going to load the xib file here
        Bundle.main.loadNibNamed("TestView", owner: self , options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
    }
    
    func configure(label : String) {
        self.testLabel.text = label
    }

}
