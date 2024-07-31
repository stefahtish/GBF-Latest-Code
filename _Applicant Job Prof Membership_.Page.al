page 50626 "Applicant Job Prof Membership"
{
    Caption = 'Applicant Job professional membership';
    PageType = ListPart;
    CardPageId = "Applicant Prof Membership Card";
    SourceTable = "Applicant Prof Membership2";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Professional Body"; Rec."Professional Body")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(MembershipNo; Rec.MembershipNo)
                {
                    ApplicationArea = All;
                }
                field("Applicant No."; Rec."Applicant No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Year of Attainment"; Rec."Year of Attainment")
                {
                    ApplicationArea = All;
                }
                field("Language proficiency"; Rec."Language proficiency")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = true;
                }
                field("Need Code"; Rec."Need Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
            }
        }
    }
}
