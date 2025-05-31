import RealityKit
import Foundation

/// 自転を処理するSystem
struct RotationSystem: System {
    static let query = EntityQuery(where: .has(RotationComponent.self))
    
    init(scene: RealityKit.Scene) {}
    
    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)
        
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard let rotationComponent = entity.components[RotationComponent.self] else { continue }
            
            // フレーム間の回転角度を計算
            let frameRotationAngle = rotationComponent.angularVelocity * deltaTime
            
            // Y軸周りの回転クォータニオンを作成
            let rotation = simd_quatf(angle: frameRotationAngle, axis: SIMD3<Float>(0, 1, 0))
            
            // エンティティの回転を相対的に更新（軸の傾きは保持される）
            entity.setOrientation(rotation, relativeTo: entity)
        }
    }
}