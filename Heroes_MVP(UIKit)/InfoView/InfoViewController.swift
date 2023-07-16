import UIKit
// MARK: - Outlets connection
class InfoViewController: UIViewController {
    //connect the outlets from the xib file
    //InfoView outlets
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet weak var heroLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameInputLabel: UILabel!
    
    @IBOutlet weak var alterLabel: UILabel!
    
    @IBOutlet weak var alterInputLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var placeInputLabel: UILabel!
    
    @IBOutlet weak var alignmentLabel: UILabel!
    
    @IBOutlet weak var alignmentInputLabel: UILabel!
    
    @IBOutlet weak var appearanceLabel: UILabel!
    
    
    @IBOutlet weak var containerController: UISegmentedControl!
    
    var segement = "Bio"{
        didSet{
            configure()
        }
    }
    var hero: SuperHero? // add the hero object from the TableViewController
    // MARK: - Lifecycle
 
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
    // MARK: - Setup
    

    private func loadViewFromNib() {
        let nib = UINib(nibName: "InfoViewController", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load InfoViewController from nib.")
            
        }
        self.view = view
    }
    
    
    @IBAction func didSegmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segement = "Bio"
        } else if sender.selectedSegmentIndex == 1 {
            segement = "Powers"
        }
    }
    
    private func configure() {
        
       
        
            // Configure the label and other UI elements here unwrapping the hero object
            if let hero = self.hero{
                //load the image
                if let imageUrl = URL(string: hero.image.url) {
                    URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                        guard let self = self, let data = data, error == nil else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            // Update the heroImageView with the downloaded image
                            self.heroImageView.image = UIImage(data: data)
                            self.heroImageView.layer.cornerRadius = 10
                        }
                    }.resume()
                }
                
                if segement == "Bio"{
                    //configure the label texts
                    heroLabel.text = "\(hero.name)"
                    nameLabel.text = "Full Name:"
                    nameInputLabel.text = "\(hero.biography.fullName)"
                    alterLabel.text = "Alter Egos :"
                    alterInputLabel.text = hero.biography.alterEgos
                    placeLabel.text = "Place of Birth:"
                    placeInputLabel.text = hero.biography.placeOfBirth
                    alignmentLabel.text = " Alignment:"
                    alignmentInputLabel.text = hero.biography.alignment
                    appearanceLabel.text = hero.biography.firstAppearance
                }else if segement == "Powers" {
                    //configure the label texts
                    heroLabel.text = "\(hero.name)"
                    nameLabel.text = "Combat:"
                    nameInputLabel.text = "\(hero.powerstats.combat)"
                    alterLabel.text = "Durability :"
                    alterInputLabel.text = hero.powerstats.durability
                    placeLabel.text = "Intelligence:"
                    placeInputLabel.text = hero.powerstats.intelligence
                    alignmentLabel.text = " Power:"
                    alignmentInputLabel.text = hero.powerstats.power
                    appearanceLabel.text = ""
                    
                }
                
                
            }
            
            
        
        
        
        
    }
        
    
    // Other methods and functionality for the InfoViewController class
    
}
