page 50240 "Asset Allocation List"
{
    ApplicationArea = All;
    Caption = 'Asset Allocation List';
    PageType = List;
    CardPageId = "Asset Allocation Card";
    Editable = false;
    SourceTable = "Asset Allocation and Transfer";
    SourceTableView = where(Type=const("Initial Allocation"));
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
                field("Current Employee No."; Rec."New Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Current Employee name"; Rec."New Employee name")
                {
                    ApplicationArea = All;
                }
                field("Current Branch"; Rec."Current Branch")
                {
                    ApplicationArea = All;
                }
                field("Current Department"; Rec."Current Department")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::"Initial Allocation";
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::"Initial Allocation";
    end;
}
