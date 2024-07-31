page 50828 "Supplier Evaluation Documents"
{
    Caption = 'Supplier Evaluation Documents';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Document";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Submitted; Rec.Submitted)
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
