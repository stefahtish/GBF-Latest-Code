page 51322 "Addendum Registration"
{
    Caption = 'Addendum Registration';
    PageType = ListPart;
    SourceTable = "Tender Addendum Registrations";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Prospect No."; Rec."Prospect No.")
                {
                    ToolTip = 'Specifies the value of the Prospect No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field';
                    ApplicationArea = All;
                }
                field("Name of the Firm"; Rec."Name of the Firm")
                {
                    ToolTip = 'Specifies the value of the Name of the Firm field';
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the value of the Postal Address field';
                    ApplicationArea = All;
                }
                field("Telephone Contacts"; Rec."Telephone Contacts")
                {
                    ToolTip = 'Specifies the value of the Telephone Contacts field';
                    ApplicationArea = All;
                }
                field("Company Email"; Rec."Company Email")
                {
                    ToolTip = 'Specifies the value of the Company Email field';
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ToolTip = 'Specifies the value of the Contact Person field';
                    ApplicationArea = All;
                }
            }
        }
    }
}
