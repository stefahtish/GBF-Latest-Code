page 51140 "Calibration Method"
{
    Caption = 'Calibration Method';
    PageType = List;
    SourceTable = "Calibration Methods";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Method; Rec.Method)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
