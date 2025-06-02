import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        @Bindable var appModel = appModel
        
        VStack(spacing: 0) {
            if let selectedBodyData = appModel.selectedCelestialBodyData,
               let selectedBody = selectedBodyData as? CelestialBody {
                VStack(spacing: 16) {
                    Text(selectedBody.japaneseName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(selectedBody.description)
                        .font(.body)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                }
                .background(Color(.systemBackground))
            } else {
                Text("天体をタッチして詳細を表示")
                    .foregroundColor(.secondary)
                    .frame(maxHeight: .infinity)
            }
            
            Spacer(minLength: 0)
            
            // Immersion Style切り替えPicker
            VStack(spacing: 16) {
                Text("Immersion Style")
                    .font(.headline)
                
                Picker("Immersion Style", selection: $appModel.selectedImmersionStyleOption) {
                    ForEach(AppModel.ImmersionStylePickerOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                
                // 軌道線表示トグル
                HStack {
                    Text("軌道線を表示")
                        .font(.headline)
                    
                    Spacer()
                    
                    Toggle("", isOn: $appModel.showOrbits)
                        .toggleStyle(SwitchToggleStyle())
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 40)
            .background(Color(.systemBackground))

            ToggleImmersiveSpaceButton()
                .padding(.top, 40)
        }
        .padding(40)
        .frame(width: 480, height: 480)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
