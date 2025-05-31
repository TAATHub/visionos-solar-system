import RealityKit
import Foundation

/// 自転のパラメータを格納するコンポーネント
struct RotationComponent: Component {
    /// 回転軸
    let axis: SIMD3<Float>
    /// 角速度（ラジアン/秒）
    let angularVelocity: Float
    /// 軸の傾斜角（度）
    let axialTilt: Float
    
    init(axis: SIMD3<Float> = [0, 1, 0], period: TimeInterval, axialTilt: Float = 0.0) {
        self.axis = normalize(axis)
        self.angularVelocity = Float(2.0 * .pi / period) // 1周期での角速度
        self.axialTilt = axialTilt
    }
} 