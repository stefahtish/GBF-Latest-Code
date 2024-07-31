page 51128 "Perfomance Contract Actuals"
{
    Caption = 'Perfomance Contract Actual';
    PageType = List;
    CardPageId = "Perfomance Contract Actual";
    SourceTable = "Perfomance Contract Actuals";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Criteria Code"; Rec."Criteria Code")
                {
                    ApplicationArea = All;
                }
                field("Criteria Description"; Rec."Criteria Description")
                {
                    ApplicationArea = All;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = All;
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                }
                field(TimeFrame; Rec.TimeFrame)
                {
                    ApplicationArea = All;
                }
                field(Quarter; Rec.Quarter)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
