page 51124 "Perfomance Contract Targets"
{
    Caption = 'Perfomance Contract Targets';
    PageType = List;
    CardPageId = "Perfomance Contract Target";
    SourceTable = "Perfomance Targets";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Criteria Code"; Rec."Criteria Code")
                {
                }
                field("Criteria Description"; Rec."Criteria Description")
                {
                }
                field(Activity; Rec.Activity)
                {
                }
            }
        }
    }
}
