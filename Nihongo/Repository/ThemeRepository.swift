import Foundation

/*

api

a, b, c, there are different

 class CellViewModel {
 betType
comboType
 }

 strategy -> DIP

 protocol CellViewModel {
  var id: Int { get }
  var title: String { get }

  func tableCell()
  func requestAPI()
  func pushController(from controller: UIViewController)
 }

 extension CellViewModel {
 var title: String {
 "My \(id)"
 }
 }

 class ACellViewModel: CellViewModel {
  let betType

 func pushController(from controller: UIViewController) {
 //....
 }

 }

 class BCellViewModel: CellViewModel {
 func pushController(from controller: UIViewController) {
    //....
 }

 class DCellViewModel: CellViewModel {
 func pushController(from controller: UIViewController) {
 //....
 }

 }


 class PageViewModel {
  /// API ??
 ///
  let models: [CellViewModell] = [
 ACellViewModel(betType: )
 DCellViewModel()
 ]

func click(index: IndexPath, from controller: UIViewController) {
    models[safe: index.row].pushController(from: controller)
 }

 }


 */


struct ThemeRepository {
    let themes: [Theme] = [
        HiraganaTheme(),
        KatakanaTheme(),
        Beginner1Theme(),
        Beginner2Theme(),
        Beginner3Theme(),
        Beginner4Theme(),
        Beginner5Theme(),
        Beginner6Theme(),
    ]
}
