//
//  GWLTextView.swift
//  GWLFloatingLabelTextField
//
//  Created by MAC-51 on 18/02/21.
//

import UIKit

open class GWLTextView: UIView, UITextViewDelegate {
    
    var labelBottomError = UILabel()
    var gwlTextView = UITextView()
    var labelTopTitle = UILabel()
    var labelPlaceholder = UILabel()
    var viewBottomLine = UIView()

    var font = UIFont.systemFont(ofSize: 13)
    var placeholder = "Placeholder"
    var isSelected = false
    
    var lineSelectedColor: UIColor = .black
    var lineDeSelectedColor: UIColor = .lightGray

    open var text: String? {
        set {
            self.gwlTextView.text = newValue
            self.setPlaceholder()
        }
        get {
            return self.gwlTextView.text
        }
    }
    
    open var errorMessage: String? {
        didSet {
            updateColor()
        }
    }
    
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.3
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        init_GWLTextView()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_GWLTextView()
    }

    fileprivate final func init_GWLTextView() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            self.addSubViews()
        }
    }
    func addSubViews() {
        addBottomErrorLabel()
        addBottomLine()
        addTopTitle()
        addTextView()
        addLabelPlaceHolder()
        updateselection(isSelected: false)
        self.setPlaceholder()

    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.setPlaceholder()
        print("Begin")
        isSelected = true
        self.updateselection(isSelected: true)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        self.setPlaceholder()
        print("Finish")
        isSelected = false
        self.updateselection(isSelected: false)
    }
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    public func textViewDidChange(_ textView: UITextView) {
        self.setPlaceholder()
        print("Change")
    }
    func setPlaceholder(){
        if self.gwlTextView.text.isEmpty == true {
//            labelPlaceholder.isHidden = false
//            self.labelTopTitle.isHidden = true
            #if swift(>=4.2)
                let animationOptions: UIView.AnimationOptions = .curveEaseOut
            #else
                let animationOptions: UIViewAnimationOptions = .curveEaseOut
            #endif
            UIView.animate(withDuration: titleFadeOutDuration, delay: 0, options: animationOptions, animations: { () -> Void in
                self.labelTopTitle.alpha = 0
                self.labelPlaceholder.alpha = 1
                }, completion: nil)
            
        }else {
//            labelPlaceholder.isHidden = true
//            self.labelTopTitle.isHidden = false
            
            #if swift(>=4.2)
                let animationOptions: UIView.AnimationOptions = .curveEaseOut
            #else
                let animationOptions: UIViewAnimationOptions = .curveEaseOut
            #endif
            UIView.animate(withDuration: titleFadeInDuration, delay: 0, options: animationOptions, animations: { () -> Void in
                self.labelTopTitle.alpha = 1
                self.labelPlaceholder.alpha = 0

                }, completion: nil)
            
        }
    }
    func updateselection(isSelected: Bool){
        if isSelected {
            self.viewBottomLine.backgroundColor = lineSelectedColor
        }else {
            self.viewBottomLine.backgroundColor = lineDeSelectedColor
        }
    }
    func removePlaceholder(){
        self.gwlTextView.textColor = .black
    }
    
    func updateColor(){
        if errorMessage != nil {
            self.labelTopTitle.textColor = .red
            self.viewBottomLine.backgroundColor = .red
        }else {
            self.labelTopTitle.textColor = isSelected ? lineSelectedColor : lineDeSelectedColor
            self.viewBottomLine.backgroundColor = isSelected ? lineSelectedColor : lineDeSelectedColor
        }
        
    }
    
    
    
    
}

extension GWLTextView {
    func addBottomErrorLabel(){
        labelBottomError.numberOfLines = 2
        labelBottomError.text = errorMessage
        labelBottomError.textAlignment = .left
        labelBottomError.font = self.font
//        titleLabel.textColor = self.aListConfiguration.aListTitle.titleColor
//        titleLabel.backgroundColor = self.aListConfiguration.backgroundColor
        self.addSubview(labelBottomError)
        labelBottomError.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: labelBottomError, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: labelBottomError, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -0))
        self.addConstraint(NSLayoutConstraint(item: labelBottomError, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -0))
    }
    func addBottomLine(){
        viewBottomLine.backgroundColor = .red
        self.addSubview(viewBottomLine)
        viewBottomLine.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: viewBottomLine, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: viewBottomLine, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -0))
        self.addConstraint(NSLayoutConstraint(item: viewBottomLine, attribute: .bottom, relatedBy: .equal, toItem: labelBottomError, attribute: .top, multiplier: 1.0, constant: 0))
        viewBottomLine.addConstraint(NSLayoutConstraint(item: viewBottomLine, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .height, multiplier: 1.0, constant: 2))
    }
    
    func addTopTitle(){
        labelTopTitle.numberOfLines = 2
        labelTopTitle.text = placeholder
        labelTopTitle.textAlignment = .left
        labelTopTitle.font = self.font
//        titleLabel.textColor = self.aListConfiguration.aListTitle.titleColor
//        titleLabel.backgroundColor = self.aListConfiguration.backgroundColor
        self.addSubview(labelTopTitle)
        labelTopTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: labelTopTitle, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: labelTopTitle, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -0))
        self.addConstraint(NSLayoutConstraint(item: labelTopTitle, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: -0))
    }
    
    func addTextView(){
        gwlTextView.text = text
        gwlTextView.font = self.font
        gwlTextView.textAlignment = .left
//        titleLabel.textColor = self.aListConfiguration.aListTitle.titleColor
        gwlTextView.backgroundColor = self.backgroundColor
        gwlTextView.delegate = self
        self.addSubview(gwlTextView)
        gwlTextView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: gwlTextView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: gwlTextView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -0))
        self.addConstraint(NSLayoutConstraint(item: gwlTextView, attribute: .bottom, relatedBy: .equal, toItem: viewBottomLine, attribute: .top, multiplier: 1.0, constant: -0))
        self.addConstraint(NSLayoutConstraint(item: gwlTextView, attribute: .top, relatedBy: .equal, toItem: labelTopTitle, attribute: .bottom, multiplier: 1.0, constant: -0))
    }
    
    func addLabelPlaceHolder(){
        labelPlaceholder.numberOfLines = 2
        labelPlaceholder.text = placeholder
        labelPlaceholder.textAlignment = .left
        labelPlaceholder.font = self.font
        labelPlaceholder.textColor = .lightGray
//        titleLabel.backgroundColor = self.aListConfiguration.backgroundColor
        self.addSubview(labelPlaceholder)
        labelPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: labelPlaceholder, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: labelPlaceholder, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: labelPlaceholder, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 25))
    }
}
