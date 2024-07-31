page 50631 "Jobs Applied"
{
    Caption = 'Jobs applied';
    PageType = ListPart;
    CardPageId = "Applicant job applied";
    SourceTable = "Applicant job applied";
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
                    Visible = false;
                }
                field("Need Code"; Rec."Need Code")
                {
                    ApplicationArea = All;
                }
                field(Job; Rec.Job)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
        }
    }
}
