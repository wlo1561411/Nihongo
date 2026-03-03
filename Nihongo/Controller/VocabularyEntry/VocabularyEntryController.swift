import FMUIKit
import UIKit

class VocabularyEntryController: ThemesViewController {
    init() {
        super.init(viewModel: ViewModel())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
