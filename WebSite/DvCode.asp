<%
Rem 动网论坛验证码程序改进版
Rem 改动：NetDust qq:544703577
Rem http://www.netdust.cn/CodeDefence.htm

Rem 使用时，请将 Call CreatValidCode("CSName") 中的CSName更改为实际的名称

Rem 保护强度说明
Rem 默认设置基本能够满足一般的情况，如需加强保护可考虑下面两个方法：
Rem 1、增加字符个数 （同时可增加数据区宽度、高度），如：
Rem Const nCharMin = 5
Rem Const nCharMax = 7
Rem Const nImgWidth = 90
Rem 2、采用复杂颜色模式
Rem Const nColorMode = 2
Rem 估计方法2的保护强度更大，目前我没想到有效的识别方法，但可读性稍差，
Rem 有时不易看清图片，可酌情使用。

Rem 改动列表
Rem 2006-3-9	修正了一个可能除0的错误
Rem 2006-7-31 字符个数随机，宽度、高度、位置随机，加入干扰线
Rem 2007-7-16	修正图像宽度非4整数倍时的错误，干扰线可设置加粗，加入字符粘连
Rem 2007-7-18	来路判断，允许多页面同时产生验证码而不冲突
Rem 2008-12-23 斜向拉伸处理
Rem 2008-12-25 加入复杂颜色模式，进一步提高保护强度

Rem ---------------------

Option Explicit

Rem 设置部分

Const nCodeCount = 5						'	允许保存的验证码数量 (原始值 5)
Const nColorMode = 1						' 颜色模式(1 黑白 2 复杂) (1) (复杂模式可提高保护强度，但有时较难看清)
Const nJoinOdds = 0.3						' 字符粘连的几率 (0.8)
Const nSlantMax = 0.1						' 最大倾斜比例 (0.5)
Const nCharMin = 3							' 产生的最小字符个数 (3)
Const nCharMax = 4							' 产生的最大字符个数 (4)
Const nImgWidth = 60						' 数据区宽度 (60)
Const nImgHeight = 16						' 数据区高度 (16)
Const nSpaceX = 2								' 左右两边的空白宽度 (2)
Const nSpaceY = 2								' 上下两边的空白宽度 (2)
Const nCharWidthRandom = 16			' 字符宽度随机量 (16)
Const nCharHeightRandom = 16		' 字符高度随机量 (16)
Const nPositionXRandom = 10			' 横向位置随机量 (10)
Const nPositionYRandom = 10			' 纵向位置随机量 (10)
Const nAngleRandom = 6         	' 笔画角度随机量 (6)
Const nLengthRandom = 6        	' 笔画长度随机量(百分比) (6)
Const nBlankNoisyDotOdds = 0.0  ' 空白处噪点率 (0.0)
Const nColorNoisyDotOdds = 0.0 	' 有色处噪点率 (0.0)
Const bNoisyLineBold = False		'	干扰线是否加粗 (False)
Const nNoisyLineCount = 1				' 噪音线条数 (1)
Const cCharSet = "0123456789"
                                ' 构成验证码的字符集
                                ' 如果扩充了下边的字母矢量库，则可以相应扩充这个字符集

Dim RGB0,RGB1
RGB0 = ChrB(255)&ChrB(255)&ChrB(255)				' 背景色的bgr值 (255..)
RGB1 = ChrB(0)&ChrB(0)&ChrB(0)							' 字符的bgr值 (0..)

Rem ---------------------

Randomize

Dim Buf(), DigtalStr, Lasts()
Dim Lines(), LineCount
Dim CursorX, CursorY, DirX, DirY, nCharCount, nPixelWidth, nPixelHeight, PicWidth, PicHeight, Slant
nCharCount = nCharMin + CInt(Rnd * (nCharMax - nCharMin))
PicWidth = nImgWidth + nSpaceX + nSpaceX
DirX = PicWidth Mod 4
If DirX <> 0 Then PicWidth = PicWidth + (4-DirX)
PicHeight = nImgHeight + nSpaceY + nSpaceY

Call CreatValidCode("CSName")

Sub CDGen_Reset()
	' 复位矢量笔和环境变量
	LineCount = 0
	CursorX = 0
	CursorY = 0
	' 初始的光笔方向是垂直向下
	DirX = 0
	DirY = 1
End Sub

Sub CDGen_Clear()
	' 清空位图阵列
	Dim i, j
	ReDim Buf(PicHeight - 1, PicWidth - 1)
	ReDim Lasts(PicHeight - 1)

	For j = 0 To PicHeight - 1
		For i = 0 To PicWidth - 1
			Buf(j, i) = 0
		Next
	Next

	For j = 0 To PicHeight - 1
		Lasts(j) = 0
	Next
End Sub

Sub CDGen_PSet(X, Y, M)
	' 在位图阵列上画点
	If X >= 0 And X < PicWidth And Y >= 0 And Y < PicHeight Then
		If M = 1 Then
			Buf(Y, X) = 1
		ElseIf M = 2 Then
			Dim n
			n=-(11+Rnd*8)
			Buf(Y, X) = Buf(Y, X) + n
			if x>0 then Buf(Y, X-1) = Buf(Y, X-1) + n
			if x+1<picwidth then Buf(Y, X+1) = Buf(Y, X+1) + n
			if y>0 then Buf(Y-1, X) = Buf(Y-1, X) + n
			if y+1<picheight then Buf(Y+1, X) = Buf(Y+1, X) + n
		Else
			Buf(Y, X) = Buf(Y, X) - (16+Rnd*10)
		End If
		If X > Lasts(Y) Then Lasts(Y) = X
	End If
End Sub

Sub CDGen_Line(X1, Y1, X2, Y2, M)
	' 在位图阵列上画线
	Dim DX, DY, DeltaT, i

	DX = X2 - X1
	DY = Y2 - Y1
	If Abs(DX) > Abs(DY) Then DeltaT = Abs(DX) Else DeltaT = Abs(DY)
	If DeltaT = 0 Then
		CDGen_PSet CInt(X1),CInt(Y1), M
	Else
		For i = 0 To DeltaT
			CDGen_PSet CInt(X1 + DX * i / DeltaT), CInt(Y1 + DY * i / DeltaT), M
		Next
	End If
End Sub

Function CDGen_LineCheck(X1, Y1, X2, Y2)
	' 在位图阵列上进行检测，返回距离最小值
	Dim DX, DY, DeltaT, x, y, i, n, j, v
	v = 0

	DX = X2 - X1
	DY = Y2 - Y1
	If Abs(DX) > Abs(DY) Then DeltaT = Abs(DX) Else DeltaT = Abs(DY)
	If DeltaT = 0 Then
		x = CInt(X1)
		y = CInt(Y1)
		If x >= 0 And x < PicWidth And y >= 0 And y < PicHeight Then
			v = x - Lasts(y)
		End If
	Else
		j = PicWidth
		For i = 0 To DeltaT
			x = CInt(X1 + DX * i / DeltaT)
			y = CInt(Y1 + DY * i / DeltaT)
			If x >= 0 And x < PicWidth And y >= 0 And y < PicHeight Then
				n = x - Lasts(y)
				If n < j Then
					j = n
					If n <= 2 Then Exit For
				End If
			End If
		Next
		v = j
	End If
	CDGen_LineCheck = v
End Function

Sub CDGen_FowardDraw(nLength)
	' 按当前光笔方向绘制指定长度并移动光笔，正数表示从左向右/从上向下绘制，负数表示从右向左/从下向上绘制
	nLength = nLength * (1 + (Rnd * 2 - 1) * nLengthRandom / 100)
	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	CursorX = CursorX + DirX * nLength
	CursorY = CursorY + DirY * nLength
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_SetDirection(nAngle)
	' 按指定角度设定画笔方向, 正数表示相对当前方向顺时针改变方向，负数表示相对当前方向逆时针改变方向
	Dim DX, DY

	nAngle = (nAngle + (Rnd * 2 - 1) * nAngleRandom) / 180 * 3.1415926
	DX = DirX
	DY = DirY
	DirX = DX * Cos(nAngle) - DY * Sin(nAngle)
	DirY = DX * Sin(nAngle) + DY * Cos(nAngle)
End Sub

Sub CDGen_MoveToMiddle(nActionIndex, nPercent)
	' 将画笔光标移动到指定动作的中间点上，nPercent为中间位置的百分比
	Dim DeltaX, DeltaY

	DeltaX = Lines(2, nActionIndex) - Lines(0, nActionIndex)
	DeltaY = Lines(3, nActionIndex) - Lines(1, nActionIndex)
	CursorX = Lines(0, nActionIndex) + DeltaX * nPercent / 100
	CursorY = Lines(1, nActionIndex) + DeltaY * Abs(DeltaY) * nPercent / 100
End Sub

Sub CDGen_MoveCursor(nActionIndex)
	' 将画笔光标移动到指定动作的起始点上
	CursorX = Lines(0, nActionIndex)
	CursorY = Lines(1, nActionIndex)
End Sub

Sub CDGen_Close(nActionIndex)
	' 将当前光笔位置与指定动作的起始点闭合并移动光笔
	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	CursorX = Lines(0, nActionIndex)
	CursorY = Lines(1, nActionIndex)
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_CloseToMiddle(nActionIndex, nPercent)
	' 将当前光笔位置与指定动作的中间点闭合并移动光笔，nPercent为中间位置的百分比
	Dim DeltaX, DeltaY

	ReDim Preserve Lines(3, LineCount)
	Lines(0, LineCount) = CursorX
	Lines(1, LineCount) = CursorY
	DeltaX = Lines(2, nActionIndex) - Lines(0, nActionIndex)
	DeltaY = Lines(3, nActionIndex) - Lines(1, nActionIndex)
	CursorX = Lines(0, nActionIndex) + Sgn(DeltaX) * Abs(DeltaX) * nPercent / 100
	CursorY = Lines(1, nActionIndex) + Sgn(DeltaY) * Abs(DeltaY) * nPercent / 100
	Lines(2, LineCount) = CursorX
	Lines(3, LineCount) = CursorY
	LineCount = LineCount + 1
End Sub

Sub CDGen_Flush(X0, Y0)
	' 按照当前的画笔动作序列绘制位图点阵
	Dim MaxX, MinX, MaxY, MinY
	Dim DeltaX, DeltaY, StepX, StepY, OffsetX, OffsetY
	Dim i, n, joinX

	MaxX = MinX = MaxY = MinY = 0
	For i = 0 To LineCount - 1
		If MaxX < Lines(0, i) Then MaxX = Lines(0, i)
		If MaxX < Lines(2, i) Then MaxX = Lines(2, i)
		If MinX > Lines(0, i) Then MinX = Lines(0, i)
		If MinX > Lines(2, i) Then MinX = Lines(2, i)
		If MaxY < Lines(1, i) Then MaxY = Lines(1, i)
		If MaxY < Lines(3, i) Then MaxY = Lines(3, i)
		If MinY > Lines(1, i) Then MinY = Lines(1, i)
		If MinY > Lines(3, i) Then MinY = Lines(3, i)
	Next
	DeltaX = MaxX - MinX
	DeltaY = MaxY - MinY
	If DeltaX = 0 Then DeltaX = 1
	If DeltaY = 0 Then DeltaY = 1
	MaxX = MinX
	MaxY = MinY
	If DeltaX > DeltaY Then
		StepX = (nPixelWidth - 2) / DeltaX
		StepY = (nPixelHeight - 2) / DeltaX
		OffsetX = 0
		OffsetY = (DeltaX - DeltaY) / 2
	Else
		StepX = (nPixelWidth - 2) / DeltaY
		StepY = (nPixelHeight - 2) / DeltaY
		OffsetX = (DeltaY - DeltaX) / 2
		OffsetY = 0
	End If
	For i = 0 To LineCount - 1
		Lines(0, i) = Round((Lines(0, i) - MaxX + OffsetX) * StepX, 0)
		Lines(1, i) = Round((Lines(1, i) - MaxY + OffsetY) * StepY, 0)
		Lines(2, i) = Round((Lines(2, i) - MinX + OffsetX) * StepX, 0)
		Lines(3, i) = Round((Lines(3, i) - MinY + OffsetY) * StepY, 0)

		' 斜向拉伸
		If Slant > 0 Then
			Lines(0,i) = Lines(0,i) + Round(Lines(1,i) * Slant)
			Lines(2,i) = Lines(2,i) + Round(Lines(3,i) * Slant)
		Else
			Lines(0,i) = Lines(0,i) - Round((nPixelHeight-Lines(1,i)) * Slant)
			Lines(2,i) = Lines(2,i) - Round((nPixelHeight-Lines(3,i)) * Slant)
		End If
	Next
	If (Rnd >= nJoinOdds) or (Len(DigtalStr)<2) Then
		joinX = 0
	Else
		joinX = PicWidth
		For i = 0 To LineCount - 1
			n = CDGen_LineCheck(Lines(0, i) + X0 + 1, Lines(1, i) + Y0 + 1, Lines(2, i) + X0 + 1, Lines(3, i) + Y0 + 1)
			If n < joinX Then
				joinX = n
				If n <= 2 Then Exit For
			End If
		Next
		If (joinX <= 2) or (joinX = PicWidth) Then
			joinX = 0
		Else
			joinX = joinX - 2
		End If
	End If
	X0 = X0 + 1 - joinX
	For i = 0 To LineCount - 1
		CDGen_Line Lines(0, i) + X0, Lines(1, i) + Y0 + 1, Lines(2, i) + X0, Lines(3, i) + Y0 + 1, nColorMode
	Next
End Sub

Sub CDGen_Char(cChar, X0, Y0)
	' 在指定坐标处生成指定字符的位图阵列
	CDGen_Reset
	Select Case cChar
	Case "0"
		CDGen_SetDirection -60                            ' 逆时针60度(相对于垂直线)
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 逆时针60度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 1.5                              ' 绘制1.5个单位
		CDGen_SetDirection -60                            ' 逆时针60度
		CDGen_FowardDraw 0.7                              ' 绘制0.7个单位
		CDGen_SetDirection -60                            ' 顺时针120度
		CDGen_FowardDraw 0.7                              ' 绘制0.7个单位
		CDGen_Close 0                                     ' 封闭当前笔与第0笔(0开始)
	Case "1"
		CDGen_SetDirection -90                            ' 逆时针90度(相对于垂直线)
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_MoveToMiddle 0, 50                          ' 移动画笔的位置到第0笔(0开始)的50%处
		CDGen_SetDirection 90                             ' 逆时针90度
		CDGen_FowardDraw -1.4                             ' 反方向绘制1.4个单位
		CDGen_SetDirection 30                             ' 逆时针30度
		CDGen_FowardDraw 0.4                              ' 绘制0.4个单位
	Case "2"
		CDGen_SetDirection 45                             ' 顺时针45度(相对于垂直线)
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -120                           ' 逆时针120度
		CDGen_FowardDraw 0.4                              ' 绘制0.4个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.6                              ' 绘制0.6个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 1.6                              ' 绘制1.6个单位
		CDGen_SetDirection -135                           ' 逆时针135度
		CDGen_FowardDraw 1.0                              ' 绘制1.0个单位
	Case "3"
		CDGen_SetDirection -90                            ' 逆时针90度(相对于垂直线)
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection 135                            ' 顺时针135度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection -120                           ' 逆时针120度
		CDGen_FowardDraw 0.6                              ' 绘制0.6个单位
		CDGen_SetDirection 80                             ' 顺时针80度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
	Case "4"
		CDGen_SetDirection 20                             ' 顺时针20度(相对于垂直线)
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection -110                           ' 逆时针110度
		CDGen_FowardDraw 1.2                              ' 绘制1.2个单位
		CDGen_MoveToMiddle 1, 60                          ' 移动画笔的位置到第1笔(0开始)的60%处
		CDGen_SetDirection 90                             ' 顺时针90度
		CDGen_FowardDraw 0.7                              ' 绘制0.7个单位
		CDGen_MoveCursor 2                                ' 移动画笔到第2笔(0开始)的开始处
		CDGen_FowardDraw -1.5                             ' 反方向绘制1.5个单位
	Case "5"
		CDGen_SetDirection 90                             ' 顺时针90度(相对于垂直线)
		CDGen_FowardDraw 1.0                              ' 绘制1.0个单位
		CDGen_SetDirection -90                            ' 逆时针90度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection -90                            ' 逆时针90度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection 30                             ' 顺时针30度
		CDGen_FowardDraw 0.4                              ' 绘制0.4个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.4                              ' 绘制0.4个单位
		CDGen_SetDirection 30                             ' 顺时针30度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
	Case "6"
		CDGen_SetDirection -60                            ' 逆时针60度(相对于垂直线)
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 逆时针60度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 1.5                              ' 绘制1.5个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 0.7                              ' 绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_CloseToMiddle 2, 50                         ' 将当前画笔位置与第2笔(0开始)的50%处封闭
	Case "7"
		CDGen_SetDirection 180                            ' 顺时针180度(相对于垂直线)
		CDGen_FowardDraw 0.3                              ' 绘制0.3个单位
		CDGen_SetDirection 90                             ' 顺时针90度
		CDGen_FowardDraw 0.9                              ' 绘制0.9个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 1.3                              ' 绘制1.3个单位
	Case "8"
		CDGen_SetDirection -60                            ' 逆时针60度(相对于垂直线)
		CDGen_FowardDraw -0.8                             ' 反方向绘制0.8个单位
		CDGen_SetDirection -60                            ' 逆时针60度
		CDGen_FowardDraw -0.8                             ' 反方向绘制0.8个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection 110                            ' 顺时针110度
		CDGen_FowardDraw -1.5                             ' 反方向绘制1.5个单位
		CDGen_SetDirection -110                           ' 逆时针110度
		CDGen_FowardDraw 0.9                              ' 绘制0.9个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.8                              ' 绘制0.8个单位
		CDGen_SetDirection 60                             ' 顺时针60度
		CDGen_FowardDraw 0.9                              ' 绘制0.9个单位
		CDGen_SetDirection 70                             ' 顺时针70度
		CDGen_FowardDraw 1.5	                            ' 绘制1.5个单位
		CDGen_Close 0                                     ' 封闭当前笔与第0笔(0开始)
	Case "9"
		CDGen_SetDirection 120                            ' 逆时针60度(相对于垂直线)
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 逆时针60度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 顺时针120度
		CDGen_FowardDraw -1.5                              ' 绘制1.5个单位
		CDGen_SetDirection -60                            ' 顺时针120度
		CDGen_FowardDraw -0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 顺时针120度
		CDGen_FowardDraw -0.7                              ' 绘制0.7个单位
		CDGen_SetDirection 120                            ' 顺时针120度
		CDGen_FowardDraw 0.7                             ' 反方向绘制0.7个单位
		CDGen_SetDirection -60                            ' 顺时针120度
		CDGen_FowardDraw 0.5                              ' 绘制0.5个单位
		CDGen_CloseToMiddle 2, 50                         ' 将当前画笔位置与第2笔(0开始)的50%处封闭
	End Select
	CDGen_Flush X0, Y0
End Sub

Sub CDGen_Blur()
	' 对产生的位图进行柔化处理
	Dim i, j

	For j = 1 To PicHeight - 2
		For i = 1 To PicWidth - 2
			If Buf(j, i) = 0 Then
				If ((Buf(j, i - 1) Or Buf(j + 1, i)) And 1) <> 0 Then
					' 如果当前点是空白点，且上下左右四个点中有一个点是有色点，则该点做柔化处理
					Buf(j, i) = 2
				End If
			End If
		Next
	Next
End Sub

Sub CDGen_NoisyLine()
	Dim i
	For i=1 To nNoisyLineCount
		If nColorMode = 1 Then
			CDGen_Line Rnd * PicWidth, Rnd * PicHeight, Rnd * PicWidth, Rnd * PicHeight, 1
		Else
			CDGen_Line Rnd * PicWidth, Rnd * PicHeight, Rnd * PicWidth, Rnd * PicHeight, 3
		End If
	Next
End Sub

Sub CDGen_NoisyDot()
	' 对产生的位图进行噪点处理
	Dim i, j, NoisyDot, CurDot

	For j = 0 To PicHeight - 1
		For i = 0 To PicWidth - 1
			If Buf(j, i) <> 0 Then
				If Rnd < nColorNoisyDotOdds Then
					Buf(j, i) = 0
				Else
					Buf(j, i) = 100
				End If
			Else
				If Rnd < nBlankNoisyDotOdds Then
					Buf(j, i) = 100
				Else
					Buf(j, i) = 0
				End If
			End If
		Next
	Next
End Sub

' 彩色画点
Sub ColorPSet(X, Y, C)
	' 在位图阵列上画点
	If X >= 0 And X < PicWidth And Y >= 0 And Y < PicHeight Then
		Buf(Y, X) = C + (2*Rnd-1)*5
	End If
End Sub

' 彩色画线
Sub ColorLine(X1, Y1, X2, Y2, ByVal C1, ByVal C2)
	' 在位图阵列上画线
	Dim DX, DY, DeltaT, i

	DX = X2 - X1
	DY = Y2 - Y1
	If Abs(DX) > Abs(DY) Then DeltaT = Abs(DX) Else DeltaT = Abs(DY)
	If DeltaT > 0 Then
		C2 = (C2 - C1) / DeltaT
		For i = 0 To DeltaT
			ColorPSet CInt(X1 + DX * i / DeltaT), CInt(Y1 + DY * i / DeltaT), C1
			C1 = C1 + C2
		Next
	End If
End Sub

' 彩色背景
Sub ColorBackGround
	'随机生成1个中点和4个边点
	Dim x,y,t,l,r,b,c0,c
	x = CInt(PicWidth * (1+Rnd) / 3)
	y = CInt(PicHeight * (1+Rnd) / 3)
	t = CInt(1 + (PicWidth-3) * Rnd)
	l = CInt(1 + (PicHeight-3) * Rnd)
	r = CInt(1 + (PicHeight-3) * Rnd)
	b = CInt(1 + (PicWidth-3) * Rnd)
	'彩色连线
	c0 = 240+CInt(Rnd*30)
	c = 180+CInt(Rnd*60)
	ColorLine 0,0,0,l,180+CInt(Rnd*60),c
	ColorLine 0,l,0,PicHeight-1,c,180+CInt(Rnd*60)
	ColorLine 0,l,x,y,c,c0
	c = 180+CInt(Rnd*60)
	ColorLine PicWidth-1,0,PicWidth-1,r,180+CInt(Rnd*60),c
	ColorLine PicWidth-1,r,PicWidth-1,PicHeight-1,c,180+CInt(Rnd*60)
	ColorLine x,y,PicWidth-1,r,c0,c
	ColorLine t,0,x,y,180+CInt(Rnd*60),c0
	ColorLine x,y,b,PicHeight-1,c0,180+CInt(Rnd*60)
	'彩色填充
	For y=0 To PicHeight-1
		x = 1
		While x < PicWidth-1
			While x < PicWidth-1 And Buf(y,x) <> 0
				x = x + 1
			WEnd
			If x < PicWidth-1 Then
				c0 = Buf(y,x-1)
				For l=x+1 To PicWidth-1
					If Buf(y,l) <> 0 Then Exit For
				Next
				c = (Buf(y,l)-c0)/(l-x+1)
				While x < l
					c0 = c0 + c
					Buf(y,x) = c0 + (2*Rnd-1)*8
					x = x + 1
				WEnd
				x = l + 1
			End If
		WEnd
	Next
End Sub

Sub CDGen()
	' 生成位图阵列
	Dim i, Ch, w, x, y

	DigtalStr = ""
	CDGen_Clear
	w = nImgWidth / nCharCount

	If nColorMode = 2 Then ColorBackGround

	Slant = (Rnd * 2 - 1) * nSlantMax

	For i = 0 To nCharCount - 1
		nPixelWidth = w * (1 + (Rnd * 2 - 1) * nCharWidthRandom / 100)
		nPixelHeight = nImgHeight * (1 - Rnd * nCharHeightRandom / 100)
		x = nSpaceX + w * (i + (Rnd * 2 - 1) * nPositionXRandom / 100)
		y = nSpaceY + nImgHeight * (Rnd * 2 - 1) * nPositionYRandom / 100
		Ch = Mid(cCharSet, Int(Rnd * Len(cCharSet)) + 1, 1)
		DigtalStr = DigtalStr + Ch
		CDGen_Char Ch, x, y
	Next

	If nColorMode = 1 Then
		If bNoisyLineBold Then
			CDGen_NoisyLine
			CDGen_Blur
		Else
			CDGen_Blur
			CDGen_NoisyLine
		End If
		CDGen_NoisyDot
	Else
		CDGen_Blur
		CDGen_NoisyLine
	End If
End Sub

Function HSBToRGB(vH, vS, vB)
	' 将颜色值由HSB转换为RGB
	Dim aRGB(3), RGB1st, RGB2nd, RGB3rd
	Dim nH, nS, nB
	Dim lH, nF, nP, nQ, nT

	vH = (vH Mod 360)
	If vS > 100 Then
		vS = 100
	ElseIf vS < 0 Then
		vS = 0
	End If
	If vB > 100 Then
		vB = 100
	ElseIf vB < 0 Then
		vB = 0
	End If
	If vS > 0 Then
		nH = vH / 60
		nS = vS / 100
		nB = vB / 100
		lH = Int(nH)
		nF = nH - lH
		nP = nB * (1 - nS)
		nQ = nB * (1 - nS * nF)
		nT = nB * (1 - nS * (1 - nF))
		Select Case lH
		Case 0
			aRGB(0) = nB * 255
			aRGB(1) = nT * 255
			aRGB(2) = nP * 255
		Case 1
			aRGB(0) = nQ * 255
			aRGB(1) = nB * 255
			aRGB(2) = nP * 255
		Case 2
			aRGB(0) = nP * 255
			aRGB(1) = nB * 255
			aRGB(2) = nT * 255
		Case 3
			aRGB(0) = nP * 255
			aRGB(1) = nQ * 255
			aRGB(2) = nB * 255
		Case 4
			aRGB(0) = nT * 255
			aRGB(1) = nP * 255
			aRGB(2) = nB * 255
		Case 5
			aRGB(0) = nB * 255
			aRGB(1) = nP * 255
			aRGB(2) = nQ * 255
		End Select
	Else
		aRGB(0) = (vB * 255) / 100
		aRGB(1) = aRGB(0)
		aRGB(2) = aRGB(0)
	End If
	HSBToRGB = ChrB(Round(aRGB(2), 0)) & ChrB(Round(aRGB(1), 0)) & ChrB(Round(aRGB(0), 0))
End Function

Rem 避免用户自己构造表单提交
Sub ComeFromCheck()
	Dim s1,s2,i
	s1 = LCase(Request.ServerVariables("HTTP_REFERER"))
	s2 = LCase(Request.ServerVariables("SERVER_NAME"))
	i = InStr(s1,"://")
	If i=0 Or InStr(s1,"://")<>Instr(s1,"://"&s2) Then
		Response.Write("禁止外部请求！")
		Response.End
	End If
End Sub

Sub CreatValidCode(pSN)
	Dim i, j, CurColorHue, s, k

	ComeFromCheck()

	k = Request.QueryString("k")
	If Not IsNumeric(k) Or IsEmpty(k) Then
		Response.Write "参数错误！"
		Response.End
	End If

	CDGen

	'记录入Session
	s = Session(pSN)
	If s = "" Then s = ";"
	i = InStr(s,";"&k&":")
	If i > 0 Then
		s = Left(s,i) & Right(s,Len(s)-InStr(i+1,s,";"))
	Else
		'这里要根据目前长度来判断是否需要把最早的删除
		j = 1 + (8+nCharMax)*(nCodeCount-1)
		i = InStr(2,s,";")
		While Len(s)>j And i>1
			s = ";" & Right(s,Len(s)-i)
			i = InStr(2,s,";")
		WEnd
	End If
	Session(pSN) = s&k&":"&DigtalStr&";"

	Dim FileSize, PicDataSize
	PicDataSize = PicWidth * PicHeight * 3
	FileSize = PicDataSize + 54

	' 输出BMP文件信息头
	Response.BinaryWrite ChrB(66) & ChrB(77) & ChrB(FileSize Mod 256) & ChrB((FileSize \ 256) Mod 256) & ChrB((FileSize \ 256 \ 256) Mod 256) & ChrB(FileSize \ 256 \ 256 \ 256) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(54) & ChrB(0) & ChrB(0) & ChrB(0)

	' 输出BMP位图信息头
	Response.BinaryWrite ChrB(40) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(PicWidth Mod 256) & ChrB((PicWidth \ 256) Mod 256) & ChrB((PicWidth \ 256 \ 256) Mod 256) & ChrB(PicWidth \ 256 \ 256 \ 256) & ChrB(PicHeight Mod 256) & ChrB((PicHeight \ 256) Mod 256) & ChrB((PicHeight \ 256 \ 256) Mod 256) & ChrB(PicHeight \ 256 \ 256 \ 256) & ChrB(1) & ChrB(0) & ChrB(24) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(PicDataSize Mod 256) & ChrB((PicDataSize \ 256) Mod 256) & ChrB((PicDataSize \ 256 \ 256) Mod 256) & ChrB(PicDataSize \ 256 \ 256 \ 256) & ChrB(18) & ChrB(11) & ChrB(0) & ChrB(0) & ChrB(18) & ChrB(11) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0) & ChrB(0)

	' 逐点输出位图阵列
	For j = 0 To PicHeight - 1
		For i = 0 To PicWidth - 1
			If nColorMode = 1 Then
				' 直接输出颜色rgb值
				If Buf(PicHeight - 1 - j, i) = 0 Then
					Response.BinaryWrite RGB0
				Else
					Response.BinaryWrite RGB1
				End If
			Else
				Response.BinaryWrite HSBToRGB(Buf(PicHeight - 1 - j, i),60,100)
			End If
		Next
	Next
End Sub
%>