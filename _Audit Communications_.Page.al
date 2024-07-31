page 50899 "Audit Communications"
{
    CardPageID = "Audit Communication";
    PageType = List;
    SourceTable = "Communication Header";
    SourceTableView = WHERE(Type = FILTER(Audit));
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
                field(Description; Rec.Description)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Communication Type"; Rec."Communication Type")
                {
                }
                field("E-Mail Body"; Rec."E-Mail Body")
                {
                }
                field("SMS Text"; Rec."SMS Text")
                {
                }
                field("E-Mail Subject"; Rec."E-Mail Subject")
                {
                }
                field(Attachment; Rec.Attachment)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Audit;
    end;
}
