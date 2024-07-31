page 50709 "Asset Maintenance Request List"
{
    Caption = 'Maintenance Request List';
    PageType = List;
    CardPageId = "Asset Maintenance Request";
    SourceTable = "Maintenance Registration";
    SourceTableView = where(Fleet = const(false));
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
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
