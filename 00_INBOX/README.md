# ミニゲーム共通ロジックとクラス構成

00_INBOX/ディレクトリ内のミニゲームサンプルは、主に以下の共通クラスとロジックを基盤として構築されています。

## 1. 共通クラス
ほぼ全てのゲームで以下の基礎クラスが共有されています。

### `BaseClass.pde`
- **概要**: 全てのゲームオブジェクト（プレイヤー、敵、アイテムなど）の基礎となる親クラス。
- **機能**:
  - 位置 (`x`, `y`)
  - サイズ (`w`, `h`)
  - 速度/加速度 (`vx`, `vy`)
  - 画像データ (`img`) の保持と描画 (`draw()`)、移動更新 (`update()`)

### `CollisionUtil.pde`
- **概要**: 当たり判定と物理演算を扱うユーティリティ関数群。
- **主な関数**:
  - `isColliding(obj1, obj2)`: AABB (Axis-Aligned Bounding Box) による矩形衝突判定。
  - `resolveCollision`, `resolveDynamicCollision`: 静的オブジェクトや動的オブジェクトとの衝突解決（押し出しや反発）。
  - `applyGravity`, `applyFriction`, `limitVelocity`: 重力、摩擦、速度制限などの簡易物理演算。
  - `checkBounds`: 画面端での境界チェックと跳ね返り。

## 2. 共通ロジックとパターン

### 入力状態の管理
- **実装方法**: `isLeftKeyPressed`, `isRightKeyPressed` のようなグローバルなboolean型変数を使用する。
- **理由**: `keyPressed()` や `keyReleased()` イベント内でこれらのフラグをON/OFFし、`draw()` ループ内でフラグ状態に応じてオブジェクトを移動させることで、キーボードの長押しによる移動をスムーズに処理しています。

### 安全なオブジェクトの削除
- **実装方法**: `ArrayList`から要素を削除する際、逆順の`for`ループ (`for (int i = list.size() - 1; i >= 0; i--)`) を使用しています。
- **理由**: リストの前から要素を削除するとインデックスがずれ、後続の要素の処理がスキップされたり `IndexOutOfBoundsException` が発生する原因になります。学習用のシンプルなコードとして `removeIf()` 等の高度な機能を使わず、直感的に安全なリスト操作を学ぶための意図的な実装です。

### オブジェクトの状態管理
- **実装方法**: オブジェクト内に `isActive`, `is_alive`, `is_destroyed` などのbooleanフラグを持たせ、死亡や破壊時にフラグを切り替える手法も用いられています（例: `Sample_AngryBird`）。不要になったらリストから消すパターンと、フラグで描画をスキップするパターンの両方が学べます。

### Processingのスケッチ規約
- ディレクトリ名とメインのファイル名が一致するように設定されています（例: `Sample_2DTopDown` ディレクトリには `Sample_2DTopDown.pde` が存在します）。これはProcessing IDEで正常に開くための必須要件です。
