page 51139 "Calibration Frequency"
{
    Caption = 'Calibration Frequency';
    PageType = List;
    SourceTable = "Calibration Frequency";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
