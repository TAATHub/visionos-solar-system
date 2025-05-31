import SwiftUI
import RealityKit

struct ImmersiveView: View {
    @State private var model = SolarSystemModel()
    @Environment(AppModel.self) private var appModel

    var body: some View {
        RealityView { content in
            // ECSシステムを登録
            OrbitSystem.registerSystem()
            RotationSystem.registerSystem()
            
            // Modelから太陽系エンティティを作成
            let solarSystemEntity = model.createSolarSystem()
            content.add(solarSystemEntity)
        }
        .gesture(
            TapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    // Modelでタップ処理を実行し、AppModelを更新
                    model.handleCelestialBodyTap(entity: value.entity, appModel: appModel)
                }
        )
    }
}

#if DEBUG
struct ImmersiveView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveView()
            .environment(AppModel())
    }
}
#endif
