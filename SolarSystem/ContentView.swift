import SwiftUI
import RealityKit
// import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        @Bindable var appModel = appModel
        
        VStack(spacing: 40) {
            if let selectedBodyData = appModel.selectedCelestialBodyData,
               let selectedBody = selectedBodyData as? CelestialBody {
                VStack(spacing: 16) {
                    Text(selectedBody.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(selectedBody.description)
                        .font(.body)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
            } else {
                Text("天体をタッチして詳細を表示")
                    .foregroundColor(.secondary)
            }

            // Immersion Style切り替えPicker
            VStack(spacing: 16) {
                Text("スタイル")
                    .font(.headline)
                
                Picker("Immersion Style", selection: $appModel.selectedImmersionStyleOption) {
                    ForEach(AppModel.ImmersionStylePickerOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)

            ToggleImmersiveSpaceButton()
        }
        .padding()
        .frame(width: 480, height: 480)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
