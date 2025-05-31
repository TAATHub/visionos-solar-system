import SwiftUI
import RealityKit

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    // Pickerで使用するためのenum型
    enum ImmersionStylePickerOption: String, CaseIterable, Identifiable, Equatable {
        case mixed = "Mixed"
        case full = "Full"
        
        var id: String { rawValue }
    }
    
    // Pickerで選択されたオプション
    var selectedImmersionStyleOption: ImmersionStylePickerOption = .mixed
    
    var selectedType: Int = 0
    
    // 選択された天体の情報
    var selectedCelestialBodyData: Any?
}
