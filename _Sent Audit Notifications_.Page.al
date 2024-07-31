page 50903 "Sent Audit Notifications"
{
    CardPageID = "Audit Notification";
    PageType = List;
    SourceTable = "Communication Header";
    SourceTableView = WHERE(Type = FILTER("Audit Notification"), Sent = FILTER(true));
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
                field("No. Series"; Rec."No. Series")
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
                field("Sender Email"; Rec."Sender Email")
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
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}
