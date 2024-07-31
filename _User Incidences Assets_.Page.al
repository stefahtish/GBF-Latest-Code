page 50715 "User Incidences Assets"
{
    Caption = 'Assets';
    PageType = ListPart;
    SourceTable = "User Incidences Assets";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field("Tag Number"; Rec."Tag Number")
                {
                    ApplicationArea = All;
                }
                field("Serial Number"; Rec."Serial Number")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
