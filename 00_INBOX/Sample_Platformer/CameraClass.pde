// カメラクラス
class CameraClass {
  float x, y;

  // カメラの境界
  float minX, maxX;
  float minY, maxY;
  boolean useBounds;

  // 境界付きコンストラクタ
  CameraClass(float minX, float minY, float maxX, float maxY) {
    this.x = 0;
    this.y = 0;
    this.minX = minX;
    this.minY = minY;
    this.maxX = maxX;
    this.maxY = maxY;
    this.useBounds = true;
  }

  // 対象オブジェクトを追従（プレイヤーを中心に配置）
  // 境界チェックも同時に実行
  void follow(BaseClass target) {
    if (target != null) {
      x = target.x + target.w/2 - width/2;
      y = target.y + target.h/2 - height/2;

      // 境界チェック
      if (useBounds) {
        x = constrain(x, minX, maxX - width);
        y = constrain(y, minY, maxY - height);
      }
    }
  }

  // カメラ変換を開始
  void begin() {
    pushMatrix();
    translate(-x, -y);
  }

  // カメラ変換を終了
  void end() {
    popMatrix();
  }
}
