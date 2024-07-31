page 51133 "Permit Applications"
{
    Caption = 'Permit  Applications and Renewal';
    PageType = List;
    CardPageId = "License and Permit App card";
    SourceTable = "License Applications";
    ApplicationArea = All;

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
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("License Type"; Rec."Type")
                {
                    visible = false;
                    ApplicationArea = All;
                }
                field("License/Permit"; Rec.Category)
                {
                    caption = 'Regulatory Permit';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                // field("Approval Status"; "Approval Status")
                // {
                //     Enabled = false;
                // }
                field("Application Type"; Rec."Application Type")
                {
                    //Visible = false;
                }
                field("Sent to LIS"; Rec."Sent to LIS")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
