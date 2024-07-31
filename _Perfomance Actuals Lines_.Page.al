page 51129 "Perfomance Actuals Lines"
{
    Caption = 'Perfomance Actuals Lines';
    PageType = ListPart;
    SourceTable = "Perfomance Actual Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("SubIndicator Code"; Rec."SubIndicator Code")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Quarter Target"; Rec."Quarter Target")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Quarter Actual"; Rec."Quarter Actual")
                {
                    ApplicationArea = All;
                }
                field("Quarter Remarks"; Rec."Quarter Remarks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
