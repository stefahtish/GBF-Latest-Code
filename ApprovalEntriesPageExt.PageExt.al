pageextension 50113 ApprovalEntriesPageExt extends "Approval Entries"
{
    layout
    {
        modify("Document Type")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field("Staff No."; Rec."Staff No.")
            {
                ApplicationArea = All;
            }
            field("Approver Staff No."; Rec."Approver Staff No.")
            {
                ApplicationArea = All;
            }
            field("Payroll period start Date"; Rec."Payroll period start Date")
            {
                ApplicationArea = All;
            }
        }
    }
    procedure Setfilters2(TableId: Integer; DocumentType: Enum "Approval Document Type"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            Rec.FilterGroup(2);
            Rec.SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
            Rec.SetRange("Table ID", TableId);
            Rec.SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then Rec.SetRange("Document No.", DocumentNo);
            Rec.FilterGroup(0);
        end;
    end;

    procedure Setfilters2(TableId: Integer; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            // FilterGroup(2);
            Rec.SetCurrentKey("Table ID", "Document Type", "Document No.", "Date-Time Sent for Approval");
            Rec.SetRange("Table ID", TableId);
            if DocumentNo <> '' then Rec.SetRange("Document No.", DocumentNo);
            //FilterGroup(0);
        end;
    end;
}
