VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "С��Ϸ - ���ֹ�����"
   ClientHeight    =   3840
   ClientLeft      =   150
   ClientTop       =   840
   ClientWidth     =   4860
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   3840
   ScaleWidth      =   4860
   StartUpPosition =   3  '����ȱʡ
   Begin VB.CommandButton Command2 
      Caption         =   "�˳�"
      Height          =   735
      Left            =   3480
      TabIndex        =   2
      Top             =   1440
      Width           =   1215
   End
   Begin VB.CommandButton Start 
      Caption         =   "��ʼ"
      Height          =   615
      Left            =   3480
      TabIndex        =   1
      Top             =   600
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   3500
      Left            =   120
      ScaleHeight     =   3465
      ScaleWidth      =   3165
      TabIndex        =   0
      Top             =   120
      Width           =   3200
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Height          =   180
      Left            =   3600
      TabIndex        =   3
      Top             =   120
      Width           =   90
   End
   Begin VB.Menu Setting 
      Caption         =   "ѡ��"
      Begin VB.Menu VSofCom 
         Caption         =   " 1P VS Com"
      End
      Begin VB.Menu GamerVBGamer 
         Caption         =   " 1P VB 2P"
      End
      Begin VB.Menu Nothing 
         Caption         =   "-"
      End
      Begin VB.Menu ThanksTo 
         Caption         =   " ��л"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim GameStart As Boolean
Dim S(3, 3) As Long                 ''''ע�⣺1�������ӣ�2������ӣ�0����û����
Dim PutChess As Long                ''''ע�⣺1����Ȧ��2�����
Dim VSToCom As Boolean              ''''ע�⣺PutChess��  1����Ȧ��2�����(����)

Private Sub Command2_Click()
End
End Sub

Private Sub Form_Load()
GameStart = False
Label1.Caption = "��Ҷ�ս"
End Sub

Private Sub Start_Click()
Picture1.Cls

Picture1.Line (100, Picture1.Height / 3)-(Picture1.Width - 200, Picture1.Height / 3)
Picture1.Line (100, (Picture1.Height / 3) * 2)-(Picture1.Width - 200, (Picture1.Height / 3) * 2)
Picture1.Line (Picture1.Width / 3, 100)-(Picture1.Width / 3, Picture1.Height - 200)
Picture1.Line ((Picture1.Width / 3) * 2, 100)-((Picture1.Width / 3) * 2, Picture1.Height - 200)
GameStart = True
PutChess = 1   ''Ȧ����
For i = 1 To 3
For j = 1 To 3
S(i, j) = 0
Next
Next

Start.Caption = "���¿�ʼ"
End Sub

Private Function ChackWinning() As Boolean         '''''''    ((����Ƿ�����ʤ����  ))

For i = 1 To 3         ''' ���� �ᣬ�� ��ʤ���ж�
  If S(i, 1) = 1 And S(i, 2) = 1 And S(i, 3) = 1 Then    ''''û�а취����ֻ������
  Winning 1
  ChackWinning = True                      ''''' ����True ���Ը����û���һ���ý�����
  Exit Function                            ''''' һ��������ߵ��ٶȣ�������Ϊ�˷�ֹ�жϳ���
  ElseIf S(i, 1) = 2 And S(i, 2) = 2 And S(i, 3) = 2 Then
  Winning 2
    ChackWinning = True
  Exit Function
  ElseIf S(1, i) = 1 And S(2, i) = 1 And S(3, i) = 1 Then
  Winning 1
    ChackWinning = True
  Exit Function
  ElseIf S(1, i) = 2 And S(2, i) = 2 And S(3, i) = 2 Then
  Winning 2
    ChackWinning = True
  Exit Function
  End If
Next

''''   ���ڶԽ��ߵ��ж�
If S(1, 1) = 1 And S(2, 2) = 1 And S(3, 3) = 1 Then
Winning 1
  ChackWinning = True
Exit Function
ElseIf S(1, 1) = 2 And S(2, 2) = 2 And S(3, 3) = 2 Then
Winning 2
  ChackWinning = True
Exit Function
ElseIf S(1, 3) = 1 And S(2, 2) = 1 And S(3, 1) = 1 Then
Winning 1
  ChackWinning = True
Exit Function
ElseIf S(1, 3) = 2 And S(2, 2) = 2 And S(3, 1) = 2 Then
Winning 2
  ChackWinning = True
Exit Function
End If

Dim Sum As Long      ''�����������ڼ���S�������Ƿ��������
  For j = 1 To 3
    For k = 1 To 3
    If S(j, k) <> 0 Then Sum = Sum + 1
    Next
  Next
If Sum = 9 Then
MsgBox "ƽ��"
Start.Caption = "��ʼ"
 GameStart = False
  ChackWinning = True
Picture1.Cls
End If

End Function

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
If GameStart = True Then
 If SetChess(X, Y, PutChess) = 0 Then        ''''�ɹ�����
 Drowing X, Y, PutChess '''�ɹ�����
  If ChackWinning = True Then Exit Sub     '''' Ӯ�˵Ļ����˳�����Ȼ��������
  If VSToCom = True And PutChess = 2 Then MainCom         '''''      <---  This
 End If
End If
End Sub
''''                  "Can doing
Private Sub Drowing(ByVal X As Long, ByVal Y As Long, ByVal Chess As Long)         '''' ��ͼ����
 If Chess = 1 Then
 DCir X, Y  ''''Ҫ����Ȧ
 PutChess = 2
 ElseIf Chess = 2 Then
 DX X, Y        ''''Ҫ������
 PutChess = 1
 End If
End Sub
Private Sub DCir(ByVal X As Long, ByVal Y As Long)
''''   S(1,1)
If X < Picture1.Width / 3 And Y < Picture1.Height / 3 Then    ''' �ڵ�һ��������
Picture1.Circle ((Picture1.Width / 3) / 2, (Picture1.Height / 3) / 2), 400, 0    ''''Picture1.Width / 3) / 2   Y�᣺3��֮һ��һ��   (Picture1.Height / 3) / 2)   X�᣺3��֮һ��һ��   400  �뾶�պ�
''''   S(2,1)
ElseIf X < Picture1.Width / 3 And Y < (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
Picture1.Circle ((Picture1.Width / 3) / 2, (Picture1.Height / 3) + (Picture1.Height / 3) / 2), 400, 0      ''''(Picture1.Height / 3) + (Picture1.Height / 3) / 2)   Y�᣺3��֮һ + 3��֮һ��һ��
''''   S(3,1)
ElseIf X < Picture1.Width / 3 And Y > (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
Picture1.Circle ((Picture1.Width / 3) / 2, (Picture1.Height / 3) * 2 + (Picture1.Height / 3) / 2), 400, 0            ''''(Picture1.Height / 3) * 2 + (Picture1.Height / 3) / 2)     Y�᣺3��֮�� + 3��֮һ��һ��
''''   S(1,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + (Picture1.Width / 3), (Picture1.Height / 3) / 2), 400, 0
''''   S(2,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < (Picture1.Width / 3) * 2 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + (Picture1.Width / 3), (Picture1.Height / 3) + (Picture1.Height / 3) / 2), 400, 0
''''   S(3,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y > (Picture1.Width / 3) * 2 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + (Picture1.Width / 3), (Picture1.Height / 3) * 2 + (Picture1.Height / 3) / 2), 400, 0
''''   S(1,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + 2 * (Picture1.Width / 3), (Picture1.Height / 3) / 2), 400, 0
''''   S(2,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < (Picture1.Height / 3) * 2 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + 2 * (Picture1.Width / 3), (Picture1.Height / 3) + (Picture1.Height / 3) / 2), 400, 0
''''   S(3,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y > (Picture1.Height / 3) * 2 Then
Picture1.Circle ((Picture1.Width / 3) / 2 + 2 * (Picture1.Width / 3), (Picture1.Height / 3) * 2 + (Picture1.Height / 3) / 2), 400, 0
End If
End Sub
Private Sub DX(ByVal X As Long, ByVal Y As Long)    ''''  �� X
''''   S(1,1)
If X < Picture1.Width / 3 And Y < Picture1.Height / 3 Then    ''' �ڵ�һ��������
Picture1.Line (Picture1.Width / 18, Picture1.Height / 18)-((Picture1.Width / 18) * 5, (Picture1.Height / 18) * 5)
Picture1.Line (Picture1.Width / 18, (Picture1.Height / 18) * 5)-((Picture1.Width / 18) * 5, Picture1.Height / 18)
''''   S(2,1)
ElseIf X < Picture1.Width / 3 And Y < (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
Picture1.Line (Picture1.Width / 18, (Picture1.Height / 18) * 7)-((Picture1.Width / 18) * 5, (Picture1.Height / 18) * 11)
Picture1.Line (Picture1.Width / 18, (Picture1.Height / 18) * 11)-((Picture1.Width / 18) * 5, (Picture1.Height / 18) * 7)     ''''(Picture1.Height / 3) + (Picture1.Height / 3) / 2)   Y�᣺3��֮һ + 3��֮һ��һ��
''''   S(3,1)
ElseIf X < Picture1.Width / 3 And Y > (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
Picture1.Line (Picture1.Width / 18, (Picture1.Height / 18) * 13)-((Picture1.Width / 18) * 5, (Picture1.Height / 18) * 17)
Picture1.Line (Picture1.Width / 18, (Picture1.Height / 18) * 17)-((Picture1.Width / 18) * 5, (Picture1.Height / 18) * 13)          ''''(Picture1.Height / 3) * 2 + (Picture1.Height / 3) / 2)     Y�᣺3��֮�� + 3��֮һ��һ��
''''   S(1,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
Picture1.Line ((Picture1.Width / 18) * 7, Picture1.Height / 18)-((Picture1.Width / 18) * 11, (Picture1.Height / 18) * 5)
Picture1.Line ((Picture1.Width / 18) * 7, (Picture1.Height / 18) * 5)-((Picture1.Width / 18) * 11, Picture1.Height / 18)
''''   S(2,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < (Picture1.Width / 3) * 2 Then
Picture1.Line ((Picture1.Width / 18) * 7, (Picture1.Height / 18) * 7)-((Picture1.Width / 18) * 11, (Picture1.Height / 18) * 11)
Picture1.Line ((Picture1.Width / 18) * 7, (Picture1.Height / 18) * 11)-((Picture1.Width / 18) * 11, (Picture1.Height / 18) * 7)
''''   S(3,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y > (Picture1.Width / 3) * 2 Then
Picture1.Line ((Picture1.Width / 18) * 7, (Picture1.Height / 18) * 13)-((Picture1.Width / 18) * 11, (Picture1.Height / 18) * 17)
Picture1.Line ((Picture1.Width / 18) * 7, (Picture1.Height / 18) * 17)-((Picture1.Width / 18) * 11, (Picture1.Height / 18) * 13)
''''   S(1,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
Picture1.Line ((Picture1.Width / 18) * 13, Picture1.Height / 18)-((Picture1.Width / 18) * 17, (Picture1.Height / 18) * 5)
Picture1.Line ((Picture1.Width / 18) * 13, (Picture1.Height / 18) * 5)-((Picture1.Width / 18) * 17, Picture1.Height / 18)
''''   S(2,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < (Picture1.Height / 3) * 2 Then
Picture1.Line ((Picture1.Width / 18) * 13, (Picture1.Height / 18) * 7)-((Picture1.Width / 18) * 17, (Picture1.Height / 18) * 11)
Picture1.Line ((Picture1.Width / 18) * 13, (Picture1.Height / 18) * 11)-((Picture1.Width / 18) * 17, (Picture1.Height / 18) * 7)
''''   S(3,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y > (Picture1.Height / 3) * 2 Then
Picture1.Line ((Picture1.Width / 18) * 13, (Picture1.Height / 18) * 13)-((Picture1.Width / 18) * 17, (Picture1.Height / 18) * 17)
Picture1.Line ((Picture1.Width / 18) * 13, (Picture1.Height / 18) * 17)-((Picture1.Width / 18) * 17, (Picture1.Height / 18) * 13)
End If
End Sub

Private Function SetChess(ByVal X As Long, ByVal Y As Long, ByVal Chess As Long) As Long    ''''����� S ������ͬ  ((    ���ڷ��ظ������Ƿ�������   ))

''''   S(1,1)
If X < Picture1.Width / 3 And Y < Picture1.Height / 3 Then    ''' �ڵ�һ��������

If S(1, 1) = 0 Then
S(1, 1) = Chess
SetChess = 0
Else               '''����ӣ������ӵĻ����������Զ��ظ���ͼ
SetChess = 1
End If

''''   S(2,1)
ElseIf X < Picture1.Width / 3 And Y < (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
If S(2, 1) = 0 Then
S(2, 1) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(3,1)
ElseIf X < Picture1.Width / 3 And Y > (Picture1.Height / 3) * 2 Then     ''' �ڵڶ���������
If S(3, 1) = 0 Then
S(3, 1) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(1,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
If S(1, 2) = 0 Then
S(1, 2) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(2,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y < (Picture1.Width / 3) * 2 Then
If S(2, 2) = 0 Then
S(2, 2) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(3,2)
ElseIf X < (Picture1.Width / 3) * 2 And Y > (Picture1.Width / 3) * 2 Then
If S(3, 2) = 0 Then
S(3, 2) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(1,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < Picture1.Height / 3 Then
If S(1, 3) = 0 Then
S(1, 3) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(2,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y < (Picture1.Height / 3) * 2 Then
If S(2, 3) = 0 Then
S(2, 3) = Chess
SetChess = 0
Else
SetChess = 1
End If

''''   S(3,3)
ElseIf X > (Picture1.Width / 3) * 2 And Y > (Picture1.Height / 3) * 2 Then
If S(3, 3) = 0 Then
S(3, 3) = Chess
SetChess = 0
Else
SetChess = 1
End If
End If
End Function
''''                  "Can doing
Private Sub Winning(ByVal Chess As Long)
If Chess = 1 Then
 If (MsgBox("Ȧʤ") = vbOK) Then
 Picture1.Cls
 End If
ElseIf Chess = 2 Then
 If (MsgBox("��ʤ") = vbOK) Then
 Picture1.Cls
 End If
 End If
 
 Start.Caption = "��ʼ"
 GameStart = False
End Sub

Private Sub ThanksTo_Click()
Dim ThanksFor As String
ThanksFor = "  �ر���л:" & vbCrLf & vbCrLf & vbCrLf
ThanksFor = ThanksFor & "  �ܿ�(�������)    " & vbCrLf & "  ����(�������) "
MsgBox ThanksFor
End Sub

Private Sub VSofCom_Click()
VSToCom = True
MsgBox "�Ѿ�����Ϊ :�˻���ս"
Label1.Caption = "�˻���ս"
End Sub

Private Sub GamerVBGamer_Click()
VSToCom = False
MsgBox "�Ѿ�����Ϊ :��Ҷ�ս"
Label1.Caption = "��Ҷ�ս"
End Sub

'''''' -------------------------Computer  Put  Chess---------------------

Private Sub MainCom()

 If NextStep(2) = True Then
 ChackWinning
 Exit Sub     ''�ж��Լ��ܷ�ʤ��      Exit Sub��Ϊ�˲���RndPutChess�л�������
 End If
 If NextStep(1) = True Then Exit Sub          ''�ж϶Է��ܷ�ʤ��

 If ToFocu4 = True Then Exit Sub          ''�����м�
If ToFocu1 = True Then Exit Sub
If ToFocu2 = True Then Exit Sub

RndPutChess
End Sub

Private Function ReturnTheSiteX(ByVal SiteX As Long) As Long
If SiteX = 1 Then
ReturnTheSiteX = (Picture1.Width / 3) / 2     ''''��һ���ߵ�һ��
ElseIf SiteX = 2 Then
ReturnTheSiteX = Picture1.Width / 2           ''''�м䣨�����һ�룩
ElseIf SiteX = 3 Then
ReturnTheSiteX = (Picture1.Width / 3) / 2 + (Picture1.Width / 3) * 2   ''''���һ����һ��
End If
End Function

Private Function ReturnTheSiteY(ByVal SiteY As Long) As Long
If SiteY = 1 Then
ReturnTheSiteY = Picture1.Height / 6      ''''��һ���ߵ�һ��
ElseIf SiteY = 2 Then
ReturnTheSiteY = Picture1.Height / 2          ''''�м䣨�����һ�룩
ElseIf SiteY = 3 Then
ReturnTheSiteY = (Picture1.Height / 3) * 2 + Picture1.Height / 6 ''''���һ����һ��
End If
End Function

Private Function NextStep(ByVal Color As Long) As Boolean           ''''ע�⣺1�������ӣ�2�������

Dim Chess1(3), Chess2(3) As Long
For i = 1 To 3
   For j = 1 To 3
   Chess1(j) = S(i, j)       ''����
 Chess2(j) = S(j, i)        ''����
Next

If Chess1(1) = Chess1(2) And Chess1(1) = Color Then ''''''   Chess1(1) = Chess1(2) = 1  ---��������
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(i), 2) = 0 Then    ''��S(i,3)        ''��֪Ϊ��Ҫ���� ��ת
Drowing ReturnTheSiteY(3), ReturnTheSiteX(i), 2
NextStep = True              '''''''<--------------------------------       ����Ҫ������������ֵ�Ļ���MainCom��ʱ�������������ӵ�
Exit Function              '''''''<--------------------------------       ����Ҫ���������˳��Ļ�����ʱ�������������ӵ�
End If
ElseIf Chess1(1) = Chess1(3) And Chess1(1) = Color Then
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(i), 2) = 0 Then    ''��S(i,2)
Drowing ReturnTheSiteY(2), ReturnTheSiteX(i), 2
NextStep = True
Exit Function
End If
ElseIf Chess1(2) = Chess1(3) And Chess1(3) = Color Then
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(i), 2) = 0 Then    ''��S(i,1)
Drowing ReturnTheSiteY(1), ReturnTheSiteX(i), 2
NextStep = True
Exit Function
End If
End If
 ''''    �����Ǻ��Ź���
If Chess2(1) = Chess2(2) And Chess2(1) = Color Then
If SetChess(ReturnTheSiteY(i), ReturnTheSiteX(3), 2) = 0 Then    ''��S(3,i)
Drowing ReturnTheSiteY(i), ReturnTheSiteX(3), 2
NextStep = True
Exit Function
End If
ElseIf Chess2(1) = Chess2(3) And Chess2(1) = Color Then
If SetChess(ReturnTheSiteY(i), ReturnTheSiteX(2), 2) = 0 Then    ''��S(2,i)
Drowing ReturnTheSiteY(i), ReturnTheSiteX(2), 2
NextStep = True
Exit Function
End If
ElseIf Chess2(2) = Chess2(3) And Chess2(3) = Color Then
If SetChess(ReturnTheSiteY(i), ReturnTheSiteX(1), 2) = 0 Then    ''��S(1,i)
Drowing ReturnTheSiteY(i), ReturnTheSiteX(1), 2
NextStep = True
Exit Function
End If
End If
Next
 ''''    ���������Ź���
 ''''    �����ǶԽ��߹���
 For j = 1 To 3
 Chess1(j) = S(j, j)        ''""" ���Ͻ������½� �ĶԽ���
 Chess2(j) = S(4 - j, j)     ''""" ���½������Ͻ� �ĶԽ���
 Next
  ''""" ���Ͻ������½� �ĶԽ��߹���
If Chess1(1) = Chess1(2) And Chess1(1) = Color Then                   ''S(1,1)  S(2,2)
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(3), 2) = 0 Then    ''��S(3,3)
Drowing ReturnTheSiteY(3), ReturnTheSiteX(3), 2
NextStep = True
Exit Function
End If
ElseIf Chess1(1) = Chess1(3) And Chess1(1) = Color Then                  ''S(1,1)  S(3,3)
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(2), 2) = 0 Then    ''��S(2,2)
Drowing ReturnTheSiteY(2), ReturnTheSiteX(2), 2
NextStep = True
Exit Function
End If
ElseIf Chess1(2) = Chess1(3) And Chess1(3) = Color Then                 ''S(2,2)  S(3,3)
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(1), 2) = 0 Then    ''��S(1,1)
Drowing ReturnTheSiteY(1), ReturnTheSiteX(1), 2
NextStep = True
Exit Function
End If
End If

  ''""" ���½������Ͻ� �ĶԽ��߹���
If Chess2(1) = Chess2(2) And Chess2(1) = Color Then                   ''S(3,1)  S(2,2)
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(1), 2) = 0 Then    ''��S(1,3)
Drowing ReturnTheSiteY(3), ReturnTheSiteX(1), 2
NextStep = True
Exit Function
End If
ElseIf Chess2(1) = Chess2(3) And Chess2(1) = Color Then                  ''S(3,1)  S(1,3)
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(2), 2) = 0 Then    ''��S(2,2)
Drowing ReturnTheSiteY(2), ReturnTheSiteX(2), 2
NextStep = True
Exit Function
End If
ElseIf Chess2(2) = Chess2(3) And Chess2(3) = Color Then                   ''S(2,2)  S(1,3)
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(3), 2) = 0 Then    ''��S(1,3)
Drowing ReturnTheSiteY(1), ReturnTheSiteX(3), 2
NextStep = True
Exit Function
End If
End If

NextStep = False
End Function

Private Sub RndPutChess()
Dim Rnd1, Rnd2 As Long
Rnd1 = Int(Rnd * 3 + 1)
Rnd2 = Int(Rnd * 3 + 1)
If SetChess(ReturnTheSiteY(Rnd1), ReturnTheSiteX(Rnd2), 2) = 0 Then
Drowing ReturnTheSiteY(Rnd1), ReturnTheSiteX(Rnd2), 2
Else
RndPutChess
End If
End Sub

Private Function ToFocu4() As Boolean            ''''''  �����Ľ� ���������
If S(1, 1) = 1 Or S(1, 3) = 1 Or S(3, 1) = 1 Or S(3, 3) = 1 Then
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(2), 2) = 0 Then
Drowing ReturnTheSiteY(2), ReturnTheSiteX(2), 2
ToFocu4 = True
Exit Function         '''' �ɹ���Ҫ�˳�������������е�����
End If
End If

ToFocu4 = False
End Function

Private Function ToFocu2() As Boolean            ''''''  �����ĽǼ��м� ���������
If S(2, 1) <> 0 And S(1, 2) <> 0 And S(3, 2) <> 0 And S(2, 3) <> 0 Then
ToFocu2 = False
Exit Function
End If

If S(1, 1) = 1 And S(3, 3) = 1 And S(2, 2) = 2 Or S(3, 1) = 1 And S(1, 3) = 1 And S(2, 2) Then
Dim nRnd As Long
nRnd = Int(Rnd(1) * 4 + 1)
If nRnd = 1 Then                       ''''  ������ S(2,1) ��
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(2), 2) = 0 Then
Drowing ReturnTheSiteY(1), ReturnTheSiteX(2), 2
ToFocu2 = True
Exit Function
Else
ToFocu2
End If

ElseIf nRnd = 2 Then                       ''''  ������ S(1,2) ��
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(1), 2) = 0 Then
Drowing ReturnTheSiteY(2), ReturnTheSiteX(1), 2
ToFocu2 = True
Exit Function
Else
ToFocu2
End If

ElseIf nRnd = 3 Then                       ''''  ������ S(3,2) ��
If SetChess(ReturnTheSiteY(2), ReturnTheSiteX(3), 2) = 0 Then
Drowing ReturnTheSiteY(2), ReturnTheSiteX(3), 2
ToFocu2 = True
Exit Function
Else
ToFocu2
End If

ElseIf nRnd = 4 Then                       ''''  ������ S(2,3) ��
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(2), 2) = 0 Then
Drowing ReturnTheSiteY(3), ReturnTheSiteX(2), 2
ToFocu2 = True
Exit Function
Else
ToFocu2
End If
End If
End If

ToFocu2 = False
End Function

Private Function ToFocu1() As Boolean            ''''''  �����м� ���������
If S(1, 1) <> 0 And S(1, 3) <> 0 And S(3, 1) <> 0 And S(3, 3) <> 0 Then
ToFocu1 = False
Exit Function
End If

If S(2, 2) = 1 Then

Dim nRnd As Long
nRnd = Int(Rnd(1) * 4 + 1)
If nRnd = 1 Then                       ''''  ������ S(1,1) ��
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(1), 2) = 0 Then
Drowing ReturnTheSiteY(1), ReturnTheSiteX(1), 2
ToFocu1 = True
Exit Function
Else
ToFocu1
End If

ElseIf nRnd = 2 Then                       ''''  ������ S(1,3) ��
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(1), 2) = 0 Then
Drowing ReturnTheSiteY(3), ReturnTheSiteX(1), 2
ToFocu1 = True
Exit Function
Else
ToFocu1
End If

ElseIf nRnd = 3 Then                       ''''  ������ S(3,1) ��
If SetChess(ReturnTheSiteY(1), ReturnTheSiteX(3), 2) = 0 Then
Drowing ReturnTheSiteY(1), ReturnTheSiteX(3), 2
ToFocu1 = True
Exit Function
Else
ToFocu1
End If

ElseIf nRnd = 4 Then                       ''''  ������ S(3,3) ��
If SetChess(ReturnTheSiteY(3), ReturnTheSiteX(3), 2) = 0 Then
Drowing ReturnTheSiteY(3), ReturnTheSiteX(3), 2
ToFocu1 = True
Exit Function
Else
ToFocu1
End If

End If
End If

ToFocu1 = False
End Function
