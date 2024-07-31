page 51233 "Inspection Reports"
{
    caption = 'Special Investigation Audit List';
    CardPageID = "Inspection Report";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER(Inspection));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

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
        Rec.Type := Rec.Type::Inspection;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Inspection;
    end;
}
