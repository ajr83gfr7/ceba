object fmOpenpitView3D: TfmOpenpitView3D
  Left = 509
  Top = 225
  HelpType = htKeyword
  HelpKeyword = 'Openpit'
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsNone
  Caption = 'fmOpenpitView3D'
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 688
    Height = 453
    Camera = GLCamera
    Buffer.BackgroundColor = clBlack
    FieldOfView = 132.356979370117200000
    Align = alClient
  end
  object GLScene: TGLScene
    Left = 32
    Top = 16
    object dcOpenpit: TGLDummyCube
      Direction.Coordinates = {000000000000803F0000000000000000}
      Up.Coordinates = {0000000000000000000080BF00000000}
      CubeSize = 100.000000000000000000
      VisibleAtRunTime = True
      object lcTopLeft: TGLLightSource
        ConstAttenuation = 1.000000000000000000
        Position.Coordinates = {0000000000000000000048420000803F}
        SpotCutOff = 180.000000000000000000
      end
      object lcTopRight: TGLLightSource
        ConstAttenuation = 1.000000000000000000
        SpotCutOff = 180.000000000000000000
      end
    end
    object GLCamera: TGLCamera
      DepthOfView = 50000.000000000000000000
      FocalLength = 100.000000000000000000
      TargetObject = dcOpenpit
      Position.Coordinates = {000000000000000000007A440000803F}
    end
  end
  object GLCadencer: TGLCadencer
    Scene = GLScene
    OnProgress = GLCadencerProgress
    Left = 128
    Top = 16
  end
end
