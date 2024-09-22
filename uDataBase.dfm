object dmDataBase: TdmDataBase
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 344
  Width = 470
  PixelsPerInch = 144
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=testetecnico'
      'User_Name=root'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 96
    Top = 24
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 96
    Top = 120
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 96
    Top = 216
  end
end
