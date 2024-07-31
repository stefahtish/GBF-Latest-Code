page 51015 "Vehicle Types Setup"
{
    Caption = 'Mode of transport';
    PageType = List;
    SourceTable = "Type of Vehicle Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(MotorCycle; Rec.MotorCycle)
                {
                    ToolTip = 'Specifies the value of the MotorCycle field.';
                    ApplicationArea = All;
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                    ApplicationArea = All;
                }
                // field(Descriptiom; Rec.Descriptiom)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}
