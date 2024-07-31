page 51094 "Dilution Factor Setup"
{
    Caption = 'Dilution Factor Setup';
    PageType = List;
    SourceTable = "Dilution Factor Setup";
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
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                }
                field(Exponential; Rec.Exponential)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Type" := Rec."Type"::Dilution;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Type" := Rec."Type"::Dilution;
    end;
}
