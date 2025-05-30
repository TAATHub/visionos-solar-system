import SwiftUI
import RealityKit
// import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
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
