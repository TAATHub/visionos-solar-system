import RealityKit
import Foundation

/// 自転を処理するSystem
struct RotationSystem: System {
    static let query = EntityQuery(where: .has(RotationComponent.self))
    
    init(scene: RealityKit.Scene) {}
    
    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)
        
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard var rotationComponent = entity.components[RotationComponent.self] else { continue }
            
            // 角度を更新
            rotationComponent.currentAngle += rotationComponent.angularVelocity * deltaTime
            
            // 2πを超えたら正規化
            if rotationComponent.currentAngle >= 2.0 * .pi {
                rotationComponent.currentAngle -= 2.0 * .pi
            }
            
            // 軸の傾斜を考慮した回転軸を計算
            let tiltRadians = rotationComponent.axialTilt * .pi / 180.0
            let tiltedAxis = SIMD3<Float>(
                sin(tiltRadians),
                cos(tiltRadians),
                0
            )
            
            // 回転クォータニオンを作成
            let rotation = simd_quatf(angle: rotationComponent.currentAngle, axis: tiltedAxis)
            
            // エンティティの回転を更新
            entity.orientation = rotation
            
            // コンポーネントを更新
            entity.components[RotationComponent.self] = rotationComponent
        }
    }
}