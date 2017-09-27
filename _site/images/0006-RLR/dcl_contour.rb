=begin
=dcl_contour.rb: 等高線と色塗りのサンプル
使用法
 % ruby dcl_contour.rb [-ps] [-dump]
履歴
 * 水田亮 作成 (「ごくらくDCL」デモプログラムを改変)
 * 堀之内 改造 2005/04
=end

require "numru/dcl"
include NumRu
include NMath

nt = 50
nz = 50
tmin, tmax = 0.0, 5.0
zmin, zmax = 20.0,50.0

t = NArray.sfloat(nt+1,    1).indgen! * (tmax-tmin)/nt    # 横軸
z = NArray.sfloat(   1, nz+1).indgen! * (zmax-zmin)/nz    # 縦軸

uz = exp(-0.2*z)*sqrt(z)
tz = -2.0*exp(-0.1*z)
u = uz*sin(3.0*(tz+t))               # (nt+1,nz+1)の配列になる。

if ARGV.index("-ps")
  # コマンドラインオプションに-psが含まれていればPSファイルを作る
  DCL::gropn(2)     # Windows では 3 にすること
else
  # ウィンドウを開く
  DCL::swpset('iheight',700)           # 画面の縦方向のピクセル数指定
  DCL::swpset('iwidth',700)            # 画面の横方向のピクセル数指定
  DCL::gropn(1)     
  DCL::swpset('ldump', true) if ARGV.index("-dump")   # 画面のダンプ
end

DCL::grfrm
DCL::grswnd(tmin, tmax, zmin, zmax)         # 左・右・下・上の座標値
DCL::uspfit                                 # あとはおまかせ
DCL::grstrf                                 # 座標の確定

DCL::ussttl('TIME', 'YEAR', 'HEIGHT', 'km') # 軸のタイトルと単位の設定
DCL::uelset("ltone",true)                   # 色つきにする
DCL::uetone(u)                              # ぬりわけ
DCL::usdaxs                                 # 座標軸を描く
DCL::udcntr(u)                              # 等値線をひく
DCL::uxmttl('t','Idealized QBO',0.0)        # title. top に中央合せ(0.0)

DCL::grcls
