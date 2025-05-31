import SwiftUI
import RealityKit

struct ImmersiveView: View {
    @State private var model = SolarSystemModel()
    @Environment(AppModel.self) private var appModel
    
    @State private var rootEntity: Entity = .init()
    @State private var skyboxEntity: Entity?

    var body: some View {
        RealityView { content in
            // ECSシステムを登録
            OrbitSystem.registerSystem()
            RotationSystem.registerSystem()
            
            // Modelから太陽系エンティティを作成
            let solarSystemEntity = model.createSolarSystem()
            rootEntity.addChild(solarSystemEntity)

            content.add(rootEntity)
        } update: { content in
            // selectedImmersionStyleOptionに基づいてskyboxの表示を制御
            if appModel.selectedImmersionStyleOption == .full {
                // .fullの場合、skyboxがまだ追加されていなければ追加
                if rootEntity.findEntity(named: "skybox") == nil {
                    let skyboxEntity = Entity.createMilkyWaySkybox()
                    rootEntity.addChild(skyboxEntity)
                }
            } else {
                // .full以外の場合、skyboxが存在すれば削除
                if let skyboxEntiry = rootEntity.findEntity(named: "skybox") {
                    skyboxEntiry.removeFromParent()
                }
            }
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
