page 51369 "Contract General Conditions"
{
    Caption = 'General Contract Condtions Setup';
    PageType = List;
    SourceTable = GeneralConditionssetup;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("General Condition Code"; Rec."General Condition Code")
                {
                    ToolTip = 'Specifies the value of the General Condition Code field.';
                    ApplicationArea = All;
                }
                field("General Conditions"; Rec."General Conditions")
                {
                    ToolTip = 'Specifies the value of the General Conditions field.';
                    ApplicationArea = All;
                    Caption = 'Condition';
                }
            }
        }
    }
}
