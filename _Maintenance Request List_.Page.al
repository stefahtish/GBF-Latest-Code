page 50491 "Maintenance Request List"
{
    Caption = 'Maintenance Request List';
    PageType = List;
    CardPageId = "Maintenance Request";
    SourceTable = "Maintenance Registration";
    SourceTableView = where(Fleet = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Maintenance No"; Rec."Maintenance No")
                {
                    ApplicationArea = All;
                }
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                }
                field("Service/Repair Description"; Rec."Service/Repair Description")
                {
                    ApplicationArea = All;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.fleet := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.fleet := true;
    end;
}
