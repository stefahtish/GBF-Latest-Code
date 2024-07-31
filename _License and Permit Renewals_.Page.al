page 51136 "License and Permit Renewals"
{
    PageType = List;
    CardPageId = "License and Permit Renewal";
    SourceTable = "License Applications";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                }
                field("License Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("License/Permit"; Rec.Category)
                {
                    Caption = 'Regulatory Permit';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    Visible = false;
                }
            }
        }
    }
}
