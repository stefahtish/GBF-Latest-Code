page 51417 "Contract Committee List"
{
    Caption = 'Committee Creation';
    PageType = List;
    SourceTable = "Tender Committees";
    SourceTableView = where(Contract = const(True));
    CardPageId = "Contract Committees";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    ApplicationArea = All;
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Committee Members"; "Committee Members")
            {
                SubPageLink = "Appointment No" = field("Appointment No");
                Visible = false;
            }
        }
    }
}
