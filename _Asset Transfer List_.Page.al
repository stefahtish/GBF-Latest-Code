page 50242 "Asset Transfer List"
{
    ApplicationArea = All;
    Caption = 'Asset Transfer List';
    PageType = List;
    Editable = false;
    CardPageId = "Asset Transfer Card";
    SourceTable = "Asset Allocation and Transfer";
    SourceTableView = where(Type=const(Transfer));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Asset; Rec.Asset)
                {
                    ApplicationArea = All;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = All;
                }
                field("Transfer Branch"; Rec."Transfer Branch")
                {
                    ApplicationArea = All;
                }
                field("Transfer Department"; Rec."Transfer Department")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("New Employee No."; Rec."New Employee No.")
                {
                    Caption = 'Transferred to Employee No';
                    ApplicationArea = All;
                }
                field("New Employee Name"; Rec."New Employee Name")
                {
                    Caption = 'Employee Name';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Transfer date';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::Transfer;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::Transfer;
    end;
}
