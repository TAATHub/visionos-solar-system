import SwiftUI

@main
struct SolarSystemApp: App {

    @State private var appModel = AppModel()

    private var immersionStyleBinding: Binding<ImmersionStyle> {
        Binding(
            get: {
                switch appModel.selectedImmersionStyleOption {
                case .mixed:
                    return .mixed
                case .full:
                    return .full
                }
            },
            set: { newValue in
                switch newValue {
                case is MixedImmersionStyle:
                    appModel.selectedImmersionStyleOption = .mixed
                case is FullImmersionStyle:
                    appModel.selectedImmersionStyleOption = .full
                default:
                    break
                }
            }
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowResizability(.contentSize)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: immersionStyleBinding, in: .mixed, .full)
     }
}
