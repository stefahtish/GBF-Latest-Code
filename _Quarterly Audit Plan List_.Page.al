page 51241 "Quarterly Audit Plan List"
{
    CardPageID = "Quarterly Audit Plan";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Quarterly Audit"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Document Status"; Rec."Document Status")
                {
                    Caption = 'Audit Status';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Quarterly Audit";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Quarterly Audit";
    end;
}
