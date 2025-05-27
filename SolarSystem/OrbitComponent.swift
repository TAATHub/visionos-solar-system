import RealityKit
import Foundation

/// 軌道運動のパラメータを格納するコンポーネント
struct OrbitComponent: Component {
    /// 軌道の半径
    let radius: Float
    /// 回転軸
    let axis: SIMD3<Float>
    /// 角速度（ラジアン/秒）
    let angularVelocity: Float
    /// 現在の角度（ラジアン）
    var currentAngle: Float
    /// 軌道の中心位置
    let centerPosition: SIMD3<Float>
    
    init(radius: Float, axis: SIMD3<Float> = [0, 1, 0], period: TimeInterval, centerPosition: SIMD3<Float> = [0, 0, 0]) {
        self.radius = radius
        self.axis = normalize(axis)
        self.angularVelocity = Float(2.0 * .pi / period) // 1周期での角速度
        self.currentAngle = 0
        self.centerPosition = centerPosition
    }
} 