page 51173 "Reviewed Audit Work Papers"
{
    CardPageID = "Audit Working Paper";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Work Paper"), Status = FILTER(Released));
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
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
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
        Rec.Type := Rec.Type::"Work Paper";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Work Paper";
    end;

    procedure GetSelectionFilter(): Text
    var
        AuditHeader: Record "Audit Header";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(AuditHeader);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForWorkingPapers(AuditHeader));
    end;

    local procedure SelectInItemList(var Audit: Record "Audit Header"): Text
    var
        AuditWorkpapers: Page "Reviewed Audit Work Papers";
    begin
        AuditWorkpapers.SETTABLEVIEW(Audit);
        AuditWorkpapers.LOOKUPMODE(TRUE);
        IF AuditWorkpapers.RUNMODAL = ACTION::LookupOK THEN EXIT(AuditWorkpapers.GetSelectionFilter);
    end;

    procedure SelectActiveWorkpapersForReport(): Text
    var
        Audit: Record "Audit Header";
    begin
        EXIT(SelectInItemList(Audit));
    end;
}
