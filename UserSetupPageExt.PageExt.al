pageextension 50157 UserSetupPageExt extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Post JV"; Rec."Post JV")
            {
                ApplicationArea = Basic, Suite;
            }
            field("User Responsibility Center"; Rec."User Responsibility Center")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Show All"; Rec."Show All")
            {
                ApplicationArea = Basic, Suite;
            }
            field(Manager; Rec.Manager)
            {
                ApplicationArea = All;
                Caption = 'HOD';
                ToolTip = 'Specifies the value of the Manager field.';
            }
            field("CRM Users"; Rec."CRM Users")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Active Assigned Cases"; Rec."Active Assigned Cases")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Closed Cases"; Rec."Closed Cases")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Active Registry Cases"; Rec."Active Registry Cases")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Case Handler"; Rec."Case Handler")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Registry Handler"; Rec."Registry Handler")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Temp Active Cases"; Rec."Temp Active Cases")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Interactions Admin"; Rec."Interactions Admin")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Send Notification"; Rec."Send Notification")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Assets Admin"; Rec."Assets Admin")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            field(Department; Rec.Department)
            {
                Enabled = false;
                ApplicationArea = All;
            }
            field("Station Manager"; Rec."Station Manager")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Director; Rec.Director)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Director field.';
            }
        }
    }
    actions
    {
        addlast(Navigation)
        {
            action("User Signature")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Signature;
                RunObject = page "User Signatures";
                RunPageLink = "User ID" = field("User ID");
                ApplicationArea = All;
            }
            action("Account Restrictions")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Restore;
                RunObject = page "Account Restrictions";
                RunPageLink = "UserID" = field("User ID");
                ApplicationArea = All;
            }
        }
    }
}
