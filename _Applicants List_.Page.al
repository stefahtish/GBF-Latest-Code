page 50466 "Applicants List"
{
    CardPageID = "Applicant Card";
    PageType = List;
    SourceTable = Applicants2;
    Caption = 'Recruitment LongListing';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                }
                field(Notified; Rec.Notified)
                {
                }
                field(Applied; Rec.Applied)
                {
                }
                field(Shortlist; Rec.Shortlist)
                {
                }
                field(Interviewed; Rec.Interviewed)
                {
                }
                // field(Qualified; Qualified)
                // {
                // }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Recruitment Long listing Report")
            {
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Recruitment Long listing";
            }
        }
    }
}
